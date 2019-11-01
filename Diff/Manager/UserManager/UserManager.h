//
//  UserManager.h
//  Chasing Alpha
//
//  Created by fengj on 2018/7/9.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFUser.h"

typedef void(^completion)(BOOL success,NSString *userName, NSString *pwd);
typedef void(^logoutCompletion)(BOOL success, APIRequest *request);

@interface UserManager : NSObject

+ (instancetype)share;

@property (nonatomic, strong) DFUser *user;

- (BOOL)isLogin;

//判断当前登录账号是否为游客
- (BOOL)isVisitor;

//登录接口
- (void)httpLoginWithUserName:(NSString *)userName
                          pwd:(NSString *)pwd
                     complete:(APIRequstCallBack)completed;

//重连接口
- (void)checkLoginStatus;

- (void)startTimerToCheckLoginStatus;


//登出接口
- (void)httpLogOutWithComplete:(logoutCompletion)completed;

//从本地数据读取存储的用户名和密码
- (void)readUserNameAndPwdFromLocalDBWithCompletion:(completion)callback;
//保存用户名和密码到本地
- (void)saveUserName:(NSString *)userName pwd:(NSString *)pwd;
//退出账户本地操作
- (void)logoutOperate;

@end
