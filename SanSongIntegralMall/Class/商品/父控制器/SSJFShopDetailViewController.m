//
//  SSJFShopDetailViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFShopDetailViewController.h"
#import "SDCycleScrollView.h"

@interface SSJFShopDetailViewController ()<SDCycleScrollViewDelegate>{
    UITableView *_tableView;
    UIView      *_homeView;
    CGFloat      _totleHeight;
    SDCycleScrollView *_lunzhuanView;
}

@end

@implementation SSJFShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详细";
    //创建主视图 并且将其嵌入tableView内
    [self createView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)createView
{
    _homeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 0, 0)];
    [self.view addSubview:_homeView];
    //初始化总高
    _totleHeight = 0;
    //商品详细第一部分 轮转图
    [self createBannerView];
    //创建介绍富文本
    [self createDetailView];
    //创建底部责任条款
    [self createResponsibility];
    
    //最后重设_homeView的大小
    _homeView.size = CGSizeMake(SCREEN_WIDTH, _totleHeight);
}

- (void)createBannerView
{
    _lunzhuanView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, SCREEN_WIDTH/16*9) imageNamesGroup:[NSArray arrayWithObjects:@"Img_default",@"Img_default",@"Img_default", nil]];
    _lunzhuanView.backgroundColor = [UIColor whiteColor];
    _lunzhuanView.contentMode = UIViewContentModeScaleAspectFit;
    _lunzhuanView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _lunzhuanView.delegate=self;
    _lunzhuanView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _lunzhuanView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _lunzhuanView.pageDotColor =RGBACOLOR(19,150,224,0.7);
    _lunzhuanView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        NSLog(@"hah");
    };
    [_homeView addSubview:_lunzhuanView];
    _totleHeight = _totleHeight + _lunzhuanView.height;
}

 - (void)createDetailView
{
    UILabel *introduceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    introduceLabel.origin = CGPointMake(0, _totleHeight);
    
    [_homeView addSubview:introduceLabel];
}

- (void)createResponsibility
{
    
}
@end
