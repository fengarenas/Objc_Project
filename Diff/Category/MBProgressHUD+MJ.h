//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)

//提示信息,自动关闭
+ (MBProgressHUD *)toastMessage:(NSString *)message;
+ (MBProgressHUD *)toastMessage:(NSString *)message toView:(UIView *)view;

//提示信息,需手动关闭
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

//手动关闭信息显示
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end
