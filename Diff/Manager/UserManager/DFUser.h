//
//  QUUser.h
//  Questions
//
//  Created by fengj on 2019/3/14.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface DFUser : NSObject <YYModel>

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *roleNames;
@property (nonatomic, strong) NSArray *roles;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *uid;//用于添加好友
@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) NSUInteger attentionPublicFlag;
@property (nonatomic, assign) NSUInteger collectionPublicFlag;

/**
 IM 登陆账号
 */
@property (nonatomic, copy) NSString *imUserName;


/**
 IM 登陆密码
 */
@property (nonatomic, copy) NSString *imUserPassword;

@end

NS_ASSUME_NONNULL_END
