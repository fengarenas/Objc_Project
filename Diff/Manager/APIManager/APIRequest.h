//
//  BaseAPIManager.h
//  ECard
//
//  Created by FengJ on 16/11/24.
//  Copyright © 2016年 fengj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * _Nonnull const kBaseURL;

typedef NS_ENUM(NSUInteger, FJRequestType) {
    FJPOST,
    FJGET,
};

@class APIRequest;

@protocol APIRequestDelegate <NSObject>
- (void)fetchDataFailWithRequest:(APIRequest *)request;
- (void)fetchDataSuccessWithRequest:(APIRequest *)request;
@end


typedef void(^APIRequstCallBack)(BOOL success, APIRequest *request);

@interface APIRequest : NSObject
@property (nonatomic, weak) id<APIRequestDelegate>delegate;

@property (nonatomic, assign) FJRequestType method;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSDictionary *param;
@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, copy) NSDictionary *response;

- (void)request:(NSDictionary *)param;

- (void)request:(NSDictionary *)param complete:(APIRequstCallBack)completed;

- (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field;

@end


NS_ASSUME_NONNULL_END

