//
//  CABaseViewController.h
//  Chasing Alpha
//
//  Created by fengj on 2018/6/16.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFBaseViewController : UIViewController

@property (nonatomic, strong) UIView *contentView;

- (void)addNavigationBackBtn;

- (void)navigationBackBtnClick:(id)sender;

- (void)addNavigationLeftButtonWithImage:(UIImage *)img seletor:(SEL)sel;

- (void)addNavigationLeftTitleButton:(NSAttributedString *)attributedString seletor:(SEL)sel;



- (void)addNavigationRightButtonWithImage:(UIImage *)img seletor:(SEL)sel;

//左文右图 
- (void)addNavigationRightButtonWithNormalStateImage:(UIImage *)img1
                                  selectedStateImage:(UIImage *)img2
                                               title:(NSAttributedString *)attributedString
                                             seletor:(SEL)sel;

- (void)addNavigationRightTitleButton:(NSAttributedString *)attributedString seletor:(SEL)sel;

- (void)tapToEndEdit;

@end
