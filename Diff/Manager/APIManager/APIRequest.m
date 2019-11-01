//
//  BaseAPIManager.m
//  ECard
//
//  Created by FengJ on 16/11/24.
//  Copyright © 2016年 fengj. All rights reserved.
//

#import "APIRequest.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AppDelegate.h"

#ifdef DEBUG
NSString *const kBaseURL = @"http://139.159.221.91/huiyuan/api/";
#else
NSString *const kBaseURL = @"http://139.9.189.175/huiyuan/api/";
#endif

NSString *const responseCode = @"retCode";
NSString *const responseMsg = @"retMsg";

@interface APIRequest ()
@property (nonatomic, copy) APIRequstCallBack completedBlock;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation APIRequest {
    AFHTTPSessionManager *mgr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        mgr = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        mgr.requestSerializer = [AFJSONRequestSerializer serializer];
        mgr.requestSerializer.timeoutInterval = 60;
        [mgr.requestSerializer setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"App-Version"];
        //开启网络指示器
        [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
        [self setup];
    }
    return self;
}


- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field {
    [mgr.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (void)request:(NSDictionary *)param {
    self.param = param;
    
    NSArray<NSHTTPCookie *> *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqualToString:@"JSESSIONID"]) {
            NSString *value = [NSString stringWithFormat:@"JSESSIONID=%@",obj.value];
            [mgr.requestSerializer setValue:value forHTTPHeaderField:@"Cookie"];
        }
    }];
    
    NSLog(@"%@:%@ header: %@ param:%@",self.method == FJGET ? @"GET" : @"POST", [NSString stringWithFormat:@"%@%@",kBaseURL,self.url], mgr.requestSerializer.HTTPRequestHeaders, param);
    
    /* POST */
    if (self.method == FJPOST) {
        [mgr POST:self.url parameters:self.param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleResponse:responseObject error:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleResponse:nil error:error];
        }];
    /* GET */
    } else if (self.method == FJGET) {
        [mgr GET:self.url parameters:self.param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleResponse:responseObject error:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handleResponse:nil error:error];
        }];
    }
}

- (void)request:(NSDictionary *)param complete:(APIRequstCallBack)completed {
    if (completed && completed!=self.completedBlock) {
        self.completedBlock = completed;
    }
    [self request:param];
}

//通用的解析回调方法
- (void)handleResponse:(id)responseObject error:(NSError*)error {
    if (error && !responseObject) {
        NSLog(@"FAIL RECV:%@ param:%@ error:%@",self.url, self.param, error);
        self.errorMessage = error.localizedDescription;
        if (self.completedBlock) {
            self.completedBlock(NO,self);
        }
        if (_delegate && [_delegate respondsToSelector:@selector(fetchDataFailWithRequest:)]) {
            [_delegate fetchDataFailWithRequest:self];
        }
    } else {
        NSNumber *errorCode = [responseObject objectForKey:responseCode];
        NSString *errorMessage = [responseObject objectForKey:responseMsg];
        
        /*
         0成功 ，-1失败 ，2未登录，3鉴权失败
        */
        if ([errorCode isEqual:@0]) {
            //0 请求成功
            NSLog(@"SUCCESS RECV:%@ param:%@ respose:%@",self.url, self.param, [(NSDictionary *)responseObject description]);
            self.response = (NSDictionary *)responseObject;
            if (self.completedBlock) {
                self.completedBlock(YES,self);
            }
            if (_delegate && [_delegate respondsToSelector:@selector(fetchDataSuccessWithRequest:)]) {
                [_delegate fetchDataSuccessWithRequest:self];
            }
        } else if ([errorCode isEqual:@(-1)]) {
            //-1 其他异常
            NSLog(@"FAIL RECV:%@ param:%@ respose:%@",self.url, self.param, [(NSDictionary *)responseObject description]);
            self.errorMessage = errorMessage;
            if (self.completedBlock) {
                self.completedBlock(NO,self);
            }
            if (_delegate && [_delegate respondsToSelector:@selector(fetchDataFailWithRequest:)]) {
                
                [_delegate fetchDataFailWithRequest:self];
            }
        } else if ([errorCode isEqual:@(2)]) {
            //2 未登录或者session超时
            [MBProgressHUD toastMessage:@"用户未登录"];
        } else if ([errorCode isEqual:@(3)]) {
            //3 无权限
            NSLog(@"FAIL RECV:%@ param:%@ respose:%@",self.url, self.param, [(NSDictionary *)responseObject description]);
            self.errorMessage = errorMessage;
            if (self.completedBlock) {
                self.completedBlock(NO,self);
            }
            if (_delegate && [_delegate respondsToSelector:@selector(fetchDataFailWithRequest:)]) {
                
                [_delegate fetchDataFailWithRequest:self];
            }
        } else {
            //未定义错误码
            NSLog(@"FAIL RECV:%@ param:%@ respose:%@",self.url, self.param, [(NSDictionary *)responseObject description]);
            self.errorMessage = @"未知错误";
            if (self.completedBlock) {
                self.completedBlock(NO,self);
            }
            if (_delegate && [_delegate respondsToSelector:@selector(fetchDataFailWithRequest:)]) {
                
                [_delegate fetchDataFailWithRequest:self];
            }
        }
    }
    
}

- (void)setup {
    self.method = FJPOST;
    self.url = nil;
    self.param = nil;
    self.tag = 0;
    self.errorMessage = nil;
    self.response = nil;
}

- (void)dealloc {
    [mgr invalidateSessionCancelingTasks:YES];
    NSLog(@"APIRequest dealloc");
}

@end
