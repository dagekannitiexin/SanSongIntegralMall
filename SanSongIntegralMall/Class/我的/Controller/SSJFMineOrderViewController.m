//
//  SSJFMineOrderViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFMineOrderViewController.h"
#import "MineIntegrallOrderCell.h"

@interface SSJFMineOrderViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
}

@end

@implementation SSJFMineOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    [self cretaeTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cretaeTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MineIntegrallOrderCell" bundle:nil] forCellReuseIdentifier:@"IntegrallOrderCell"];
}

#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 176;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];

    return view;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"IntegrallOrderCell";
    MineIntegrallOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[MineIntegrallOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
@end
