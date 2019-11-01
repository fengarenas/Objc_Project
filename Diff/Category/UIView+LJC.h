//
//  UIView+LJC.h
//  DemoMasonry
//
//  Created by Ralph Li on 7/1/15.
//  Copyright (c) 2015 LJC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LJC)


- (void)distributeSpacingHorizontallyWith:(NSArray *)views spacing:(CGFloat)spacing;
- (void)distributeSpacingVerticallyWith:(NSArray *)views height:(CGFloat)height leftPadding:(CGFloat)left spacing:(CGFloat)spacing;

- (void)distributeVeriticallWith:(NSArray *)views toppadding:(CGFloat)toppadding;
- (void)updateVeriticallWith:(NSArray *)views toppadding:(CGFloat)padding sp:(UIView*)spView;



@end
