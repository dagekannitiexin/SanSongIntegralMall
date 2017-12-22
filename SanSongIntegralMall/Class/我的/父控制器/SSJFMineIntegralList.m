//
//  SSJFMineIntegralList.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFMineIntegralList.h"
#import "SSJFMineIntegralListHeadView.h"

@interface SSJFMineIntegralList (){
    UITableView *_tableView;
}

@property (nonatomic,strong)SSJFMineIntegralListHeadView *headView;
@end

@implementation SSJFMineIntegralList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
    
    [self createHeadView];
    [self initTableView];
    
    
}
- (void)createHeadView
{
    self.headView = [[NSBundle mainBundle]loadNibNamed:@"SSJFMineIntegralListHeadView" owner:nil options:nil].lastObject;
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setTableHeaderView:self.headView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
