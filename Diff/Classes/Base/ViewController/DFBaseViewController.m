//
//  CABaseViewController.m
//  Chasing Alpha
//
//  Created by fengj on 2018/6/16.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import "DFBaseViewController.h"
#import <UIGestureRecognizer+YYAdd.h>

@interface DFBaseViewController ()

@end

@implementation DFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"class:%@ %s",NSStringFromClass([self class]),__func__);
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        } else {
            make.edges.mas_equalTo(self.view);
        }
    }];
    self.view.backgroundColor = BgColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.navigationController.viewControllers.firstObject == self) {
        //如果是navigationController的根控制器 要关闭pop手势 否则会出现在根控制器右滑手势后 push到其他控制器 UI错乱的bug
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
        //开启右滑返回上一级的手势。
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate=nil;
    }
}

- (void)viewDidLayoutSubviews {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        } else {
            make.edges.mas_equalTo(self.view);
        }
    }];
}

- (void)dealloc {
    NSLog(@"class:%@ %s",NSStringFromClass([self class]),__func__);
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = BgColor;
    }
    return _contentView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - 供子类调用

- (void)addNavigationBackBtn {
    UIImage *img = [UIImage imageNamed:@"back"];
    [self addNavigationLeftButtonWithImage:img seletor:@selector(navigationBackBtnClick:)];
}

- (void)navigationBackBtnClick:(id)sender {
    if (self.navigationController.viewControllers.count==1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addNavigationLeftButtonWithImage:(UIImage *)img seletor:(SEL)sel {
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:img forState:UIControlStateNormal];
    [leftButton setImage:img forState:UIControlStateHighlighted];
    [leftButton setImage:img forState:UIControlStateSelected];
    //增大,并且leading留出16pt
    leftButton.frame = CGRectMake(0, 0, 60, 44);
    CGFloat leading = 16.f;
    CGFloat imageMoveLeftDistance = (60 - img.size.width)/2.f - leading;
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0,-imageMoveLeftDistance, 0, imageMoveLeftDistance);
    [leftButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];

    [self setLeftBarButtonView:leftButton];
}

- (void)addNavigationLeftTitleButton:(NSAttributedString *)attributedString seletor:(SEL)sel {
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    //trailing留出16pt
    [leftButton sizeToFit];
    CGRect rect = leftButton.frame;
    CGFloat trailing = 16.f;
    rect.size.width += trailing;
    leftButton.frame = rect;
    //rightButton.titleLabel.textAlignment = NSTextAlignmentLeft; //it do not work
    leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, trailing/2.f, 0, -trailing/2.f);
    //leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [leftButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];

    [self setLeftBarButtonView:leftButton];
}

- (void)addNavigationRightButtonWithImage:(UIImage *)img seletor:(SEL)sel {
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:img forState:UIControlStateNormal];
    [rightButton setImage:img forState:UIControlStateHighlighted];
    [rightButton setImage:img forState:UIControlStateSelected];
    //增大,并且trailing留出16pt
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    CGFloat trailing = 16.f;
    CGFloat imageMoveRightDistance = (60 - img.size.width)/2.f - trailing;
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0,imageMoveRightDistance, 0, -imageMoveRightDistance);
    
    [rightButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];

    [self setRightBarButtonView:rightButton];
}

- (void)addNavigationRightButtonWithNormalStateImage:(UIImage *)img1
                                  selectedStateImage:(UIImage *)img2
                                               title:(NSAttributedString *)attributedString
                                             seletor:(SEL)sel {
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    [rightButton setImage:img1 forState:UIControlStateNormal];
    [rightButton setImage:img1 forState:UIControlStateHighlighted];
    [rightButton setImage:img2 forState:UIControlStateSelected];
    
    
    //button 左文字 右图片
    [rightButton.titleLabel sizeToFit];
    CGFloat titleW = rightButton.titleLabel.frame.size.width;
    
    CGFloat imgW = img1.size.width;
    
    CGFloat titleImgMargin = 2.f;
    
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, titleW, 0, -titleW);//设置图片位置
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgW + titleImgMargin), 0, (imgW + titleImgMargin));//设置文字位置  titleImgMargin为图片文字中间间隔

    //button设置为撑满,并且trailing留出16pt
    CGFloat trailing = 16.f;
    rightButton.frame = CGRectMake(0, 0, titleW + titleImgMargin + imgW + trailing, 44);
    
    CGFloat contentMoveRightDistance = (rightButton.bounds.size.width - (titleW+imgW+titleImgMargin))/2.f - trailing;
    rightButton.contentEdgeInsets = UIEdgeInsetsMake(0, contentMoveRightDistance, 0, -contentMoveRightDistance);
    
    /*
    //增大,并且trailing留出16pt
    rightButton.frame = CGRectMake(0, 0, 60, 44);
    CGFloat trailing = 16.f;
    CGFloat imageMoveRightDistance = (60 - img.size.width)/2.f - trailing;
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0,imageMoveRightDistance, 0, -imageMoveRightDistance);
    */
    [rightButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];

    [self setRightBarButtonView:rightButton];
    
}

- (void)addNavigationRightTitleButton:(NSAttributedString *)attributedString seletor:(SEL)sel {
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setAttributedTitle:attributedString forState:UIControlStateNormal];
    //trailing留出16pt
    [rightButton sizeToFit];
    CGRect rect = rightButton.frame;
    CGFloat trailing = 16.f;
    rect.size.width += trailing;
    rightButton.frame = rect;
    //rightButton.titleLabel.textAlignment = NSTextAlignmentLeft; //it do not work
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -trailing/2.f, 0, trailing/2.f);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButtonView:rightButton];
    
}

- (void)tapToEndEdit {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [self.view endEditing:YES];
    }];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - navigaitonItem Methons to fixed customItem alignment bug

- (void)setLeftBarButtonView:(UIView *)view
{
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11)
    {
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view]];
    }
    else
    {
        //iOS11以下系统,用fixedBarButtonItem来消除左边间隙  间隙宽度根据屏幕尺寸不同有所不同
        CGFloat systemPadding;
        if (SCREEN_WIDTH == 320 || SCREEN_WIDTH == 375) {
            systemPadding = 16;
        } else {
            systemPadding = 20;
        }
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
        [space setWidth:-systemPadding];
      
        [self.navigationItem setLeftBarButtonItems:@[space,[[UIBarButtonItem alloc] initWithCustomView:view]]];
    }
}
  
- (void)setRightBarButtonView:(UIView *)view
{
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 11)
    {
        //iOS11以上的处理 在自定义的navigationbar做了 这里不需要处理
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view]];
    }
    else
    {
        //iOS11以下系统,用fixedBarButtonItem来消除右边间隙  间隙宽度根据屏幕尺寸不同有所不同
        CGFloat systemPadding;
        if (SCREEN_WIDTH == 320 || SCREEN_WIDTH == 375) {
            systemPadding = 16;
        } else {
            systemPadding = 20;
        }
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
        [space setWidth:-systemPadding];
      
        [self.navigationItem setRightBarButtonItems:@[space,[[UIBarButtonItem alloc] initWithCustomView:view]]];
    }
}
@end
