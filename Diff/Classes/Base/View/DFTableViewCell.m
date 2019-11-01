//
//  CATableViewCell.m
//  Chasing Alpha
//
//  Created by fengj on 2018/6/27.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import "DFTableViewCell.h"

@implementation DFTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellEditingStyleNone;
        [self setup];
    }
    return self;
}

- (void)setup {
    //TODO 交给子类实现
}

+ (CGFloat)height {
    return 0;
}

- (void)bind:(id)data {
    
}

@end
