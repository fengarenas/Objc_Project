//
//  AppDelegate.h
//  Chasing Alpha
//
//  Created by fengj on 2018/6/14.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;

- (void)presentLoginControllerFrom:(UIViewController *)vc;
- (void)setupLoginController;
- (void)setupTabBarController;

@end

