//
//  DFScrollView.h
//  DFPP
//
//  Created by zewill on 2019/9/3.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFScrollView : UIScrollView

- (instancetype) initWithViews:(NSArray<UIView *> *)views topPadding:(CGFloat)padding;

- (instancetype) initWithViews:(NSArray<UIView *> *)views paddings:(NSArray<NSNumber *> *)paddings;

- (instancetype) initWithViews:(NSArray<UIView *> *)views paddings:(NSArray<NSNumber *> *)paddings superview:(UIView *)superView ;

- (instancetype)initWithViews:(NSArray<UIView *> *)views paddings:(NSArray<NSNumber *> *)paddings superview:(UIView *)superView bottomPadding:(CGFloat)bottomPadding;

- (void)insertViewAtTop:(UIView *)view;

- (void) setup:(NSArray<UIView *> *)views;

- (instancetype) initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype) init NS_UNAVAILABLE;

+ (instancetype) new NS_UNAVAILABLE;

- (void)drawContentBackgroundWhiteColor;

@property (nonatomic, strong, readonly) UIView *contentView;

- (void)deleteAllContentView;

@end
