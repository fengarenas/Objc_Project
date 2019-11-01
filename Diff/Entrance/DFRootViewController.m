//
//  CARootViewController.m
//  Chasing Alpha
//
//  Created by fengj on 2018/6/16.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import "AppDelegate.h"
#import "DFRootViewController.h"


@interface DFRootViewController ()

@end

@implementation DFRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"launchIMG"]];
    bgImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:bgImageView];
    [bgImageView m:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    //判断本地是否存储有用户名和密码 没有则跳转登录界面 有则调用登录接口登录
    [[UserManager share] readUserNameAndPwdFromLocalDBWithCompletion:^(BOOL success, NSString *userName, NSString *pwd) {
        if (success) {
            [self loginWithPhone:userName password:pwd];
        } else {
            
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app setupLoginController];
             
            //[self loginWithPhone:kVisitorUserName password:kVisitorPwd];
        }
    }];
}

- (void)loginWithPhone:(NSString *)phone password:(NSString *)password {
    UserManager *mgr = [UserManager share];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:WINDOW animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"登录中";
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [mgr httpLoginWithUserName:phone pwd:password complete:^(BOOL success, APIRequest *request) {
        [hud hideAnimated:NO afterDelay:0];
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [appDelegate setupTabBarController];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [appDelegate setupLoginController];
            });
        }

    }];
}

@end
