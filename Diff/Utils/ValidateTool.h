//
//  ValidateTool.h
//  HuaGuoYuan
//
//  Created by souwu on 14-6-20.
//  Copyright (c) 2014年 Model. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateTool : NSObject

//邮箱
+ (BOOL) validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;

//车型
+ (BOOL) validateCarType:(NSString *)CarType;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;


//昵称
+ (BOOL) validateNickname:(NSString *)nickname;


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

/**
 *  银行卡验证
 *
 *  @param cardNumber
 *
 *  @return
 */
+(BOOL)isValidBankCardNumber:(NSString *)cardNumber;


/**
 *  根据卡号获取开卡行
 *
 *  @param idCard
 *
 *  @return
 */
+ (NSString *)returnBankName:(NSString*) idCard;
@end
