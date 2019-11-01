//
//  DFMsgCell.m
//  DFPP
//
//  Created by fengj on 2019/5/24.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import "DFMsgCell.h"

@interface DFMsgCell()
@property (nonatomic, strong) UIImageView *headIconIv;
@property (nonatomic, strong) UILabel *nameLb;
@property (nonatomic, strong) UILabel *msgDetialLb;
@property (nonatomic, strong) UILabel *dateLb;
@end

@implementation DFMsgCell

#pragma mark - life cycle

- (void)setup {
  __weak typeof(self) s = self;
    [s.contentView add:@[s.headIconIv, s.nameLb, s.msgDetialLb, s.dateLb]];
    
    [s.headIconIv m:^(MASConstraintMaker *make) {
        make.leading.equalTo(s.contentView).offset(21);
        make.width.height.equalTo(60);
        make.top.equalTo(s.contentView).offset(17);
        make.bottom.equalTo(s.contentView).offset(-17);
    }];
    [s.nameLb m:^(MASConstraintMaker *make) {
        make.top.equalTo(s.headIconIv.mas_top);
        make.leading.equalTo(s.headIconIv.mas_trailing).offset(10);
    }];
    [s.msgDetialLb m:^(MASConstraintMaker *make) {
        make.bottom.equalTo(s.headIconIv.mas_bottom);
        make.leading.equalTo(s.headIconIv.mas_trailing).offset(10);
    }];
    [s.dateLb m:^(MASConstraintMaker *make) {
        make.top.equalTo(s.headIconIv.mas_top);
        make.trailing.equalTo(s.contentView.mas_trailing).offset(-20);
    }];
    
    [s.dateLb setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [s.nameLb setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
}

#pragma mark - setter and getter

- (UIImageView *)headIconIv {
    if (!_headIconIv) {
        UIImageView *iv = [UIImageView new];
        iv.image = [UIImage imageNamed:@"merchant"];
        _headIconIv = iv;
    }
    return _headIconIv;
}

- (UILabel *)nameLb {
    if (!_nameLb) {
        UILabel *lb = [UILabel new];
        lb.font = FONTM(16);
        lb.textColor = FontColor1;
        lb.textAlignment = NSTextAlignmentLeft;
        lb.text = @"藤野造型";
        _nameLb = lb;
    }
    return _nameLb;
}

- (UILabel *)msgDetialLb {
    if (!_msgDetialLb) {
        UILabel *lb = [UILabel new];
        lb.font = FONTR(14);
        lb.textColor = GrayColor;
        lb.textAlignment = NSTextAlignmentLeft;
        lb.text = @"李春瑶：我发现一个新品还不错。";
        _msgDetialLb = lb;
    }
    return _msgDetialLb;
}

- (UILabel *)dateLb {
    if (!_dateLb) {
        UILabel *lb = [UILabel new];
        lb.font = FONTR(12);
        lb.textColor = GrayColor;
        lb.textAlignment = NSTextAlignmentLeft;
        lb.text = @"下午12:41";
        _dateLb = lb;
    }
    return _dateLb;
}

@end
