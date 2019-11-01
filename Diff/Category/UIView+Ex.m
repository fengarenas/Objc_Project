//
//  UIView+Ex.m
//  iCourse-Tch
//
//  Created by fengj on 2018/2/1.
//  Copyright © 2018年 fengj. All rights reserved.
//

#import "UIView+Ex.h"
#import <Masonry/View+MASAdditions.h>

@implementation UIView (Ex)

- (void)add:(id)obj {
    NSParameterAssert(obj);
    if ([obj isKindOfClass:[UIView class]]) {
        [self addSubview:obj];
    } else if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *arr = [obj copy];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull a, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([a isKindOfClass:[UIView class]]) {
                [self addSubview:a];
            }
        }];
    }
}

- (NSArray *)m:(void (^)(MASConstraintMaker *make))block {
    return [self mas_makeConstraints:block];
}

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners {
    
    //    UIRectCorner type = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    
    //1. 加一个layer 显示形状
    CGRect rect = CGRectMake(borderWidth/2.0, borderWidth/2.0,
                             CGRectGetWidth(self.frame)-borderWidth, CGRectGetHeight(self.frame)-borderWidth);
    CGSize radii = CGSizeMake(cornerRadius, borderWidth);
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    shapeLayer.lineWidth = borderWidth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
    
    
    
    
    //2. 加一个layer 按形状 把外面的减去
    CGRect clipRect = CGRectMake(0, 0,
                                 CGRectGetWidth(self.frame)-1, CGRectGetHeight(self.frame)-1);
    CGSize clipRadii = CGSizeMake(cornerRadius, borderWidth);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:clipRect byRoundingCorners:corners cornerRadii:clipRadii];
    
    CAShapeLayer *clipLayer = [CAShapeLayer layer];
    clipLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    clipLayer.lineWidth = 1;
    clipLayer.lineJoin = kCALineJoinRound;
    clipLayer.lineCap = kCALineCapRound;
    clipLayer.path = clipPath.CGPath;
    
    self.layer.mask = clipLayer;
}

@end
