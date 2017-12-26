//
//  SSJFMineIntegralList.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFMineIntegralList.h"
#import "SSJFMineIntegralListHeadView.h"
#import "MineIntegralLisetCell.h"
#import "SSJFMineOrderViewController.h"

@interface SSJFMineIntegralList ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    SSJFMineIntegralListHeadView *_headView;
}

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
    _headView = [[NSBundle mainBundle]loadNibNamed:@"SSJFMineIntegralListHeadView" owner:nil options:nil].lastObject;
    _headView.btnMineOrderBlock = ^{
        NSLog(@"hello world");
        SSJFMineOrderViewController *orderVC = [[SSJFMineOrderViewController alloc]init];
        [self.navigationController pushViewController:orderVC animated:YES];
    };
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_tableView];
   _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MineIntegralLisetCell" bundle:nil] forCellReuseIdentifier:@"IntegralLisetCell"];
    [_tableView setTableHeaderView:_headView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uitableViewDelegate uitableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"IntegralLisetCell";
    MineIntegralLisetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[MineIntegralLisetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
@end
