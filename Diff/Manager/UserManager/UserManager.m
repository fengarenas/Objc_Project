//
//  UserManager.m
//  Chasing Alpha
//
//  Created by fengj on 2018/7/9.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import "UserManager.h"
#import <YYKit/NSObject+YYModel.h>
//#import "JPUSHService.h"

NSString *kUserName = @"kUserName";
NSString *kPassWord = @"kPassWord";
NSString *imUserName = @"imUserName";
NSString *imUserPassword = @"imUserPassword";

@interface UserManager ()
@property (nonatomic, assign) NSTimer *timer;
@end

@implementation UserManager

+ (instancetype)share {
    static dispatch_once_t onceToken;
    static UserManager *mgr;
    dispatch_once(&onceToken, ^{
        mgr =  [UserManager new];
    });
    return mgr;
}

- (BOOL)isLogin {
    return self.user;
}

- (BOOL)isVisitor {
    return [self.user.username isEqualToString:@""];
}

//登出接口
- (void)httpLogOutWithComplete:(logoutCompletion)completed {
    APIRequest *request = [APIRequest new];
    request.url = @"app/user/logout";
    request.method = FJPOST;
    __weak typeof(self) wself = self;
    [request request:nil complete:^(BOOL success, APIRequest *request) {
        if (success) {
            [wself logoutOperate];
        }
        completed(success, request);
    }];
    
//    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//                  NSLog(@"Delete Alias %@", iAlias);
//              } seq:1];
//    
//    [[EMClient sharedClient] logout:YES];
}

//登录接口
- (void)httpLoginWithUserName:(NSString *)userName
                          pwd:(NSString *)pwd
                     complete:(APIRequstCallBack)completed {

    NSDictionary *param = @{@"phone":userName, @"password":pwd};
    APIRequest *request = [APIRequest new];
    request.url = @"app/user/login";
    [request request:param complete:^(BOOL success, APIRequest *request) {
        if (success) {
            self.user = [DFUser modelWithDictionary:request.response[@"result"]];
            
            //本地化用户名,密码
            [self saveUserName:userName pwd:pwd];
            //绑定JPush
            [self httpJpushBindDevIdAndUserIMID:self.user.imUserName];
            
            [NC postNotificationName:@"" object:nil];
            //登陆环信
            //[self loginHX];
        }
        completed(success, request);
    }];
}
 

//用户绑定Jpush设备id
- (void)httpJpushBindDevIdAndUserIMID:(NSString *)imUserName {
    
//   
//    NSString *devId = [JPUSHService registrationID];
//    if (!devId.length) {
//        return;
//    }
//    NSDictionary *param = @{@"devId":devId,@"appType":@"IOS"};
//    APIRequest *request = [APIRequest new];
//    request.url = @"app/push/jpush/bind/devId";
//    [request request:param complete:^(BOOL success, APIRequest *request) {
//        if (success) {
//            NSLog(@"绑定 JPush registrationID 成功");
//        } else {
//            NSLog(@"绑定 JPush registrationID 失败");
//        }
//    }];
 
}

//重连接口
- (void)checkLoginStatus {
    APIRequest *request = [APIRequest new];
    request.url = @"app/user/login/state";
    [request request:nil complete:^(BOOL success, APIRequest *request) {
        if (success) {
            NSInteger result =  [request.response[@"result"] integerValue];
            if (result == 0) {
                //未登录
                //判断本地是否存储有用户名和密码 没有则跳转至登录页面 有则调用登录接口登录
                [self readUserNameAndPwdFromLocalDBWithCompletion:^(BOOL success, NSString *userName, NSString *pwd) {
                    if (success) {
                        [self httpLoginWithUserName:userName pwd:pwd complete:^(BOOL success, APIRequest *request) {
                            
                        }];
                    }
                }];
            } else {
               
            }
        }
    }];
}


/**
 登陆或注册环信
 */
//- (void)registHX {
//
//    NSString *name = self.user.imUserName;
//    NSString *pwd = self.user.imUserPassword;
//    [[EMClient sharedClient] registerWithUsername:name password:pwd completion:^(NSString *aUsername, EMError *aError) {
//
//        if (!aError) {
//            return ;
//        }
//        NSString *errorDes = @"注册失败，请重试";
//        switch (aError.code) {
//                case EMErrorServerNotReachable:
//                errorDes = @"无法连接服务器";
//                break;
//                case EMErrorNetworkUnavailable:
//                errorDes = @"网络未连接";
//                break;
//                case EMErrorUserAlreadyExist:
//                errorDes = @"用户ID已存在";
//                break;
//                case EMErrorExceedServiceLimit:
//                errorDes = @"请求过于频繁，请稍后再试";
//                break;
//            default:
//                break;
//        }
//    }];
//}

//- (void)loginHX {
//    NSString *name = self.user.imUserName;
//    NSString *pwd = self.user.imUserPassword;
//
//    __weak typeof(self) weakself = self;
//    void (^finishBlock) (NSString *aName, EMError *aError) = ^(NSString *aName, EMError *aError) {
//
//        if (!aError) {
//            //设置是否自动登录
//            [[EMClient sharedClient].options setIsAutoLogin:YES];
////
//            EMPushOptions *pushOptions = [EMClient sharedClient].pushOptions;
//            pushOptions.displayStyle = EMPushDisplayStyleMessageSummary;
//            pushOptions.noDisturbStatus = EMPushNoDisturbStatusClose;
//            NSString *userName = [UD objectForKey:kUserName];
//            [[EMClient sharedClient] setApnsNickname:userName];
//            [[EMClient sharedClient] updatePushOptionsToServer];
////            EMDemoOptions *options = [EMDemoOptions sharedOptions];
////            options.isAutoLogin = YES;
////            options.loggedInUsername = aName;
////            options.loggedInPassword = pwd;
////            [options archive];
////
////            //发送自动登录状态通知
////            [[NSNotificationCenter defaultCenter] postNotificationName:ACCOUNT_LOGIN_CHANGED object:[NSNumber numberWithBool:YES]];
//
//            return ;
//        }
//
//        NSString *errorDes = @"登录失败，请重试";
//        switch (aError.code) {
//                case EMErrorUserNotFound:{
//                    errorDes = @"用户ID不存在";
//                    [weakself registHX];
//                 }
//                break;
//                case EMErrorNetworkUnavailable:
//                errorDes = @"网络未连接";
//                break;
//                case EMErrorServerNotReachable:
//                errorDes = @"无法连接服务器";
//                break;
//                case EMErrorUserAuthenticationFailed:
//                errorDes = aError.errorDescription;
//                break;
//                case EMErrorUserLoginTooManyDevices:
//                errorDes = @"登录设备数已达上限";
//                break;
//            default:
//                break;
//        }
////        [EMAlertController showErrorAlert:errorDes];
//    };
//
//    [[EMClient sharedClient] loginWithUsername:name password:pwd completion:finishBlock];
//}

- (void)startTimerToCheckLoginStatus {
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60*30 target:self selector:@selector(checkLoginStatus) userInfo:nil repeats:YES];
}

//保存用户名和密码到本地
- (void)saveUserName:(NSString *)userName pwd:(NSString *)pwd {
    [UD setObject:userName forKey:kUserName];
    [UD setObject:pwd forKey:kPassWord];
    [UD synchronize];
}

//从本地数据读取存储的用户名和密码
- (void)readUserNameAndPwdFromLocalDBWithCompletion:(completion)callback {
    NSString *userName = [UD objectForKey:kUserName];
    NSString *pwd = [UD objectForKey:kPassWord];
    if (!userName.length || !pwd.length) {
        callback(NO, nil, nil);
    } else {
        callback(YES, userName, pwd);
    }
}

- (void)clearUserNameAndPwd {
    [UD setObject:@"" forKey:kUserName];
    [UD setObject:@"" forKey:kPassWord];
    [UD synchronize];
}

- (void)logoutOperate {
    self.user = nil;
    [self clearUserNameAndPwd];
}


@end
