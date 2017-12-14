//
//  SSJFHomeViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFHomeViewController.h"
#import "SSJFUserInfoView.h" //头部信息
#import "HeadButton.h"
#import "SDCycleScrollView.h"

@interface SSJFHomeViewController ()<SDCycleScrollViewDelegate>{
    SSJFUserInfoView  *_infoView;
    SDCycleScrollView *_lunzhuanView;
    UIScrollView      *_activeView;
}


@end

@implementation SSJFHomeViewController

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏设置 底部tabBar
    self.view.backgroundColor= [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    //建设
    self.title = @"积分商城";
    //创建个人信息部分
    [self createInfoView];
    //创建活动
    [self madeActiveView];
    //创建广告轮转图
    [self createBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 创建个人信息部分
 */
- (void)createInfoView
{
    _infoView = [[[NSBundle mainBundle]loadNibNamed:@"SSJFUserInfoView" owner:nil options:nil]lastObject];
    _infoView.origin = CGPointMake(0, 64);
    [self.view addSubview:_infoView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _infoView.bottom, SCREEN_WIDTH, 12)];
    line.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [self.view addSubview:line];
}

- (void)madeActiveView
{
    //创建活动栏
    _activeView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _infoView.bottom+12, SCREEN_WIDTH, 95)];
    _activeView.backgroundColor = [UIColor whiteColor];
    _activeView.showsVerticalScrollIndicator = FALSE;
    _activeView.showsHorizontalScrollIndicator = FALSE;
    _activeView.alwaysBounceHorizontal = YES;
    _activeView.layer.masksToBounds = YES;
    [self.view addSubview:_activeView];
    
    CGFloat btnrecommendedW = 50;
    CGFloat btnrecommendedH = 70;
    CGFloat recommendedspace = (SCREEN_WIDTH -2*20-4*btnrecommendedW)/3;
    for (int i=0; i<4; i++) {
        HeadButton *btn = [[HeadButton alloc]initWithFrame:CGRectMake(20 + (btnrecommendedW+recommendedspace)*i, 12.5, btnrecommendedW, btnrecommendedH)];
        btn.tag = i+100;
        [btn setImage:[UIImage imageNamed:@"Img_default"] forState:UIControlStateNormal];
        [btn setTitle:@"积分兑换" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(activeBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.imageView.layer.cornerRadius = btnrecommendedW/2;
        btn.imageView.clipsToBounds = YES;
        [_activeView addSubview:btn];
        _activeView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame)+20, _activeView.height);
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _activeView.bottom, SCREEN_WIDTH, 12)];
    line.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [self.view addSubview:line];
}

/*
 创建轮转图
 */
- (void)createBanner
{
    //创建轮转图
//    __weak SSJFHomeViewController *weakSelf = self;
    _lunzhuanView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, _activeView.bottom+12, SCREEN_WIDTH, SCREEN_WIDTH/3) imageNamesGroup:[NSArray arrayWithObjects:@"Img_default",@"Img_default",@"Img_default", nil]];
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
    [self.view addSubview:_lunzhuanView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _lunzhuanView.bottom, SCREEN_WIDTH, 12)];
    line.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [self.view addSubview:line];
}
#pragma maek - btnClick
- (void)activeBtnclick:(UIButton*)sender
{
    
}
@end
