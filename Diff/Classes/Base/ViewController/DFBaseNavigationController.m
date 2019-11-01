//
//  CABaseNavigationController.m
//  Chasing Alpha
//
//  Created by fengj on 2018/6/16.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import "DFBaseNavigationController.h"

#import <YYKit/UIImage+YYAdd.h>

#import "DFNavigationBar.h"

@interface DFBaseNavigationController ()

@end

@implementation DFBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithNavigationBarClass:[DFNavigationBar class] toolbarClass:nil];
    if (self) {
        self.viewControllers = @[rootViewController];
        [self customInit];
    }
    return self;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}

- (void)customInit {
    NSDictionary *titleTextAttributes = @{
                                          NSFontAttributeName:FONTR(20),
                                          NSForegroundColorAttributeName: [UIColor blackColor],
                                          };
    self.navigationBar.titleTextAttributes = titleTextAttributes;
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:NavbarBgColor] forBarMetrics:UIBarMetricsDefault & UIBarMetricsLandscapePhone];
    [self.navigationBar setTintColor:NavbarTitleColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


@end
