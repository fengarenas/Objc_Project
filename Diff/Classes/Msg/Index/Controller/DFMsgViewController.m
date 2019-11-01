//
//  DFMsgViewController.m
//  DFPP
//
//  Created by fengj on 2019/5/19.
//  Copyright © 2019 JiangQian-Tec. All rights reserved.
//

#import "DFMsgViewController.h"
#import "DFMsgCell.h"

@interface DFMsgViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *listView;

@end

@implementation DFMsgViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setup];
}

- (void)setupNav {
    NSDictionary *attr = @{NSFontAttributeName:FONTR(14),NSForegroundColorAttributeName:FontColor1};
    NSAttributedString *leftTitle = [[NSAttributedString alloc]initWithString:@"好友列表" attributes:attr];
    [self addNavigationLeftTitleButton:leftTitle seletor:@selector(goToFriendList)];
    
    self.title = @"消息";
    
    [self addNavigationRightButtonWithImage:[UIImage imageNamed:@"addNewMsg"] seletor:@selector(newMsg)];
}

- (void)setup {
    __weak typeof(self) s = self;
    [s.contentView addSubview:s.listView];
    [s.listView m:^(MASConstraintMaker *make) {
        make.edges.equalTo(s.contentView);
    }];
    
}

#pragma mark - event response


#pragma mark - uitableview datasoure & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DFMsgCell *c = [tableView dequeueReusableCellWithIdentifier:@"DFMsgCell"];
    
    return c;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - setter and getter

- (UITableView *)listView {
    if (!_listView) {
        _listView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.showsVerticalScrollIndicator = NO;
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_listView registerClass:[DFMsgCell class] forCellReuseIdentifier:@"DFMsgCell"];
        
    }
    return _listView;
}

@end
