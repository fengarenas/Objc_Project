//
//  UIView+Ex.h
//  iCourse-Tch
//
//  Created by fengj on 2018/2/1.
//  Copyright © 2018年 fengj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ex)


/**
 加入子视图

 @param obj 可以是一个子视图,也可以是一个包含多个子视图的数组
 */
- (void)add:(id)obj;


/**
 代替 mas_makeConstraints 方法
 */
- (NSArray *)m:(void(^)(MASConstraintMaker *make))block;

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor
                             type:(UIRectCorner)corners;

@end
