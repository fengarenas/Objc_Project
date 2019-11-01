//
//  CATableViewCell.h
//  Chasing Alpha
//
//  Created by fengj on 2018/6/27.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFTableViewCell : UITableViewCell

+ (CGFloat)height;
- (void)bind:(id)data;
- (void)setup;

@end
