//
//  DFScrollView.m
//  DFPP
//
//  Created by zewill on 2019/9/3.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import "DFScrollView.h"
//#import <BlocksKit/NSArray+BlocksKit.h>
@interface DFScrollView()

@property (nonatomic, strong, readwrite) UIView *contentView;
@property (nonatomic, assign) CGFloat padding;

@end

@implementation DFScrollView

- (instancetype)initWithViews:(NSArray<UIView *> *)views topPadding:(CGFloat)padding{
    if (self = [super init]) {
        NSAssert(views, @"error");
        
        self.padding = padding;
        [self setup:views paddings:nil];
    }
    return self;
}

- (instancetype)initWithViews:(NSArray<UIView *> *)views paddings:(NSArray<NSNumber *> *)paddings {
    return [[DFScrollView alloc] initWithViews:views paddings:paddings superview:nil];
}

- (instancetype)initWithViews:(NSArray<UIView *> *)views paddings:(NSArray<NSNumber *> *)paddings superview:(UIView *)superView {
    if (self = [super init]) {
        NSAssert(views, @"error");
        if (paddings) {
            NSAssert(views.count == paddings.count, @"views and paddings must be the same count");
        }
        
        [self setup:views paddings:paddings];
        
        if (superView) {
            [superView addSubview:self];
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.edges.equalTo(superView).insets(superView.safeAreaInsets);
                }else{
                    make.edges.equalTo(superView);
                }
            }];
        }
    }
    return self;
}

- (instancetype)initWithViews:(NSArray<UIView *> *)views paddings:(NSArray<NSNumber *> *)paddings superview:(UIView *)superView bottomPadding:(CGFloat)bottomPadding{
    if (self = [super init]) {
        NSAssert(views, @"error");
        NSAssert(views.count == paddings.count, @"views and paddings must be the same count");
        [self setup:views paddings:paddings];
        if (superView) {
            [superView addSubview:self];
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.left.right.equalTo(superView);
                    make.top.equalTo(superView).offset(-(StatusBar_HEIGHT));
                    make.bottom.equalTo(superView.mas_safeAreaLayoutGuideBottom).offset(-bottomPadding);
                }else{
                    make.top.left.right.equalTo(superView);
                    make.bottom.equalTo(superView.mas_bottom).offset(-bottomPadding);
                }
            }];
        }
    }
    return self;
}

- (void) setup:(NSArray<UIView *> *)views {
   
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:views.count];
    
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:@(0)];
    }];
    
    [self setup:views paddings:result];
}

- (void) setup:(NSArray<UIView *> *)views paddings:(NSArray<NSNumber *> *)paddings {
    self.alwaysBounceVertical = true;
    self.backgroundColor = BgColor;
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    if (!_contentView) {
        _contentView = [UIView new];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
            make.width.equalTo(self);
        }];
    }
    
    
    UIView *lastView = nil;
    NSInteger idx = 0;
    for (UIView *view in views) {
        if (![_contentView.subviews containsObject:view]) {
            [_contentView addSubview:view];
        }
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self->_padding > 0) {
                if (lastView == nil) {
                    make.top.equalTo(self->_contentView).offset(0);
                }else{
                    make.top.equalTo(lastView.mas_bottom).offset(self->_padding);
                }
            }else{
                CGFloat toppadding = 0;
                if (paddings) {
                    toppadding = [paddings[idx] floatValue];
                }
                make.top.equalTo(lastView == nil? self->_contentView.mas_top: lastView.mas_bottom).offset(toppadding);
            }
            make.left.right.equalTo(self->_contentView);
            
        }];
        idx += 1;
        lastView = view;
    }
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView);
    }];
    
    
}

- (void)insertViewAtTop:(UIView *)view{
    if (_contentView.subviews.count == 0) {
        [self setup:@[view] paddings:@[@0]];
    }else {
        
        UIView *oriTopView = _contentView.subviews.firstObject;
        CGFloat oriTopViewH = oriTopView.frame.size.height;
        UIView *oriSecondView;
        CGFloat gap = 0;
        if (_contentView.subviews.count > 1) {
            oriSecondView = _contentView.subviews[1];
            gap = oriSecondView.frame.origin.y - oriTopViewH;
        }
        
        [_contentView addSubview:view];
        //remove origin top view's constraints first constraint
        
        [oriTopView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self->_contentView);
            make.top.equalTo(view.mas_bottom);
            make.height.equalTo(oriTopViewH);
        }];
        if (oriSecondView) {
            [oriSecondView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(oriTopView.mas_bottom).offset(gap);
            }];
        }
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self->_contentView);
        }];
        
    }
}


- (void)drawContentBackgroundWhiteColor {
    _contentView.backgroundColor = [UIColor whiteColor];
}

- (void)deleteAllContentView {
    while (_contentView.subviews.count) {
        [_contentView.subviews.lastObject removeFromSuperview];
    }
}

@end
