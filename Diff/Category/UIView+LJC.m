//
//  UIView+LJC.m
//  DemoMasonry
//
//  Created by Ralph Li on 7/1/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import "UIView+LJC.h"



@implementation UIView (LJC)


- (void) distributeSpacingVerticallyWith:(NSArray*)views
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    
    UIView *v0 = spaces[0];
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(((UIView*)views[0]).mas_centerX);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastSpace.mas_bottom);
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(obj.mas_bottom);
            make.centerX.equalTo(obj.mas_centerX);
            make.height.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

- (void)distributeSpacingVerticallyWith:(NSArray *)views height:(CGFloat)height leftPadding:(CGFloat)left spacing:(CGFloat)spacing{
    
    UIView *lastView = nil;
    for (NSInteger i = 0; i<views.count; i++) {
        UIView *sv = views[i];
        [self addSubview:sv];
        
        [sv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self).offset(left);
            make.height.mas_equalTo(height);
            if (i == 0) {
                make.top.equalTo(self);
            }else{
                make.top.equalTo(lastView.mas_bottom);
            }
        }];
        
        lastView = sv;
    }
}


- (void)distributeVeriticallWith:(NSArray *)views toppadding:(CGFloat)toppadding {
    if (views == nil) return;
    UIView *lastView = nil;
    for (UIView *view in views) {
        if (![self.subviews containsObject:view]) {
            [self addSubview:view];
        }
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (toppadding > 0) {
                if (lastView == nil) {
                    make.top.equalTo(self).offset(toppadding);
                }else{
                    make.top.equalTo(lastView.mas_bottom).offset(toppadding);
                }
            }else{
                make.top.equalTo(lastView == nil? self: lastView.mas_bottom);
            }
            make.left.right.equalTo(self);
            
        }];
        lastView = view;
    }
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView);
    }];
}

- (void)updateVeriticallWith:(NSArray *)views toppadding:(CGFloat)padding sp:(UIView*)spView{
    if (views == nil) {
        return;
    }
    UIView *lastView = nil;
    for (UIView *view in views) {
        if (![self.subviews containsObject:view]) {
            [self addSubview:view];
        }
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (padding > 0) {
                if (lastView == nil) {
                    make.top.equalTo(self).offset(padding);
                }else{
                    make.top.equalTo(lastView.mas_bottom).offset(padding);
                }
            }else{
                make.top.equalTo(lastView == nil? self: lastView.mas_bottom);
            }
            make.left.right.equalTo(self);
            
        }];
        lastView = view;
    }
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(spView);
        make.bottom.equalTo(lastView);
    }];
    
}

- (void)distributeSpacingHorizontallyWith:(NSArray *)views spacing:(CGFloat)spacing {
    if (views == nil) return;
    UIView *lastView = nil;
    for (UIView *view in views) {
        if (![self.subviews containsObject:view]) {
            [self addSubview:view];
        }
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (spacing > 0) {
                if (lastView == nil) {
                    make.left.equalTo(self).offset(spacing);
                }else{
                    make.left.equalTo(lastView.mas_right).offset(spacing);
                }
            }else{
                if (lastView) {
                    make.width.equalTo(lastView);
                }
                make.left.equalTo(lastView == nil? self: lastView.mas_right);
            }
            make.top.bottom.equalTo(self);
        }];
        lastView = view;
    }
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
    }];
}



@end
