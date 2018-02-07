//
//  GZGMineViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/2/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GZGMineViewController.h"
#import "SSJFUserInfoView.h"
#import "SSJFMineViewController.h"
#import "HeadButton.h"

@interface GZGMineViewController (){
    UIScrollView *_mainScrollerView;
    CGFloat _totleHeight;
    UIView *_headView;
    SSJFUserInfoView  *_infoView;
}

@end

@implementation GZGMineViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    backImg.image = [UIImage imageNamed:@"mine_profile_bg"];
    backImg.contentMode = UIViewContentModeScaleAspectFill;
    backImg.clipsToBounds = YES;
    [self.view addSubview:backImg];
    
    _mainScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    [self.view addSubview:_mainScrollerView];
    
    //创建内容视图
    [self initHeadView];
    
    _mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}

/*
 头部图
 */
- (void)initHeadView
{
    //headView
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor clearColor];
    _totleHeight = 0; //设置总head高度
    //创建个人信息部分
    [self createInfoView];
    //创建我的订单部分
    [self createMineOrder];
    //创建我的订单部分
    [self createMineFuWu];
    
    UIView *footView= [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 200)];
    footView.backgroundColor = LYBgColor;
    [_mainScrollerView addSubview:footView];
    _totleHeight = _totleHeight +footView.height;
    //最后统计_headView大小
    _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _totleHeight);
    [_mainScrollerView addSubview:_headView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
 创建个人信息部分
 */
- (void)createInfoView
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.45)];
    bgView.backgroundColor = [UIColor clearColor];
    [_headView addSubview:bgView];
    
    _infoView = [[[NSBundle mainBundle]loadNibNamed:@"SSJFUserInfoView" owner:nil options:nil]lastObject];
    _infoView.centerY = bgView.height/2;
    __block GZGMineViewController *blockSelf = self;
    _infoView.touchViewBlock = ^(NSString *str) {
        if ([str isEqualToString:@"Icon"]){ //跳转到个人页面
            SSJFMineViewController *mine = [[SSJFMineViewController alloc]init];
            [blockSelf.navigationController pushViewController:mine animated:YES];
            
        }else if ([str isEqualToString:@"Integral"]){//跳转到积分页面
        }else if ([str isEqualToString:@"Login"]){//跳转到登录页面
        }
    };
    [bgView addSubview:_infoView];
    _totleHeight = _totleHeight +bgView.bottom;
}

- (void)createMineOrder
{
    UIView *orderView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 135)];
    orderView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:orderView];
    
    //我的订单
    UIView *orderOne = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UILabel *orderLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 30)];
    orderLabel.centerY = orderOne.height/2;
    orderLabel.text = @"我的订单";
    orderLabel.font = [UIFont systemFontOfSize:14];
    orderLabel.textColor = GZGGaryTextColor;
    [orderOne addSubview:orderLabel];
    
    UIImageView *more = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14/2, 25/2)];
    more.centerY = orderOne.height/2;
    more.right = SCREEN_WIDTH-15;
    more.image = [UIImage imageNamed:@"commoditydetail_ic_list_arrow"];
    [orderOne addSubview:more];
    
    UIView *lineOne = [[UIView alloc]initWithFrame:CGRectMake(15, orderOne.height-0.5, SCREEN_WIDTH-15, 0.5)];
    lineOne.backgroundColor = XMLowBottomLine;
    [orderOne addSubview:lineOne];
    [orderView addSubview:orderOne];
    
    
    //功能按钮
    UIView *orderTwo = [[UIView alloc]initWithFrame:CGRectMake(0, orderOne.bottom, SCREEN_WIDTH, 73)];
    [orderView addSubview:orderTwo];
    CGFloat btnrecommendedW = 70;
    CGFloat btnrecommendedH = 60;
    CGFloat recommendedspace = (SCREEN_WIDTH - 5*btnrecommendedW)/6;
    NSArray *actTitleArray = [NSArray arrayWithObjects:@"待付款",@"待发货",@"已发货",@"待评价",@"退换/售后", nil];
    NSArray *actImgArray = [NSArray arrayWithObjects:@"mine_profile_payment_ic",@"mine_profile_package_ic",@"mine_profile_delivering_ic",@"mine_profile_evaluation_ic",@"mine_profile_service_ic", nil];
    for (int i=0; i<5; i++) {
        HeadButton *btn = [[HeadButton alloc]initWithFrame:CGRectMake( recommendedspace+ (btnrecommendedW+recommendedspace)*i, 15, btnrecommendedW, btnrecommendedH)];
        
        btn.tag = i+100;
        [btn setImage:[UIImage imageNamed:actImgArray[i]] forState:UIControlStateNormal];
        [btn setTitle:actTitleArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(activeBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [orderTwo addSubview:btn];
    }
    UIView *lineNextView = [[UIView alloc]initWithFrame:CGRectMake(0, orderTwo.bottom+2, SCREEN_WIDTH, 10)];
    lineNextView.backgroundColor = XMBottomLine;
    [orderView addSubview:lineNextView];
    _totleHeight = _totleHeight +orderView.height;
}

- (void)activeBtnclick:(UIButton *)sender
{
    
}

- (void)createMineFuWu
{
    UIView *fuWuView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 145)];
    fuWuView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:fuWuView];
    
    //我的订单
    UIView *orderOne = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UILabel *orderLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 30)];
    orderLabel.centerY = orderOne.height/2;
    orderLabel.text = @"我的服务";
    orderLabel.font = [UIFont systemFontOfSize:14];
    orderLabel.textColor = GZGGaryTextColor;
    [orderOne addSubview:orderLabel];
    
    UIImageView *more = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14/2, 25/2)];
    more.centerY = orderOne.height/2;
    more.right = SCREEN_WIDTH-15;
    more.image = [UIImage imageNamed:@"commoditydetail_ic_list_arrow"];
    [orderOne addSubview:more];
    
    UIView *lineOne = [[UIView alloc]initWithFrame:CGRectMake(15, orderOne.height-0.5, SCREEN_WIDTH-15, 0.5)];
    lineOne.backgroundColor = XMLowBottomLine;
    [orderOne addSubview:lineOne];
    [fuWuView addSubview:orderOne];
    
    
    //功能按钮
    UIView *orderTwo = [[UIView alloc]initWithFrame:CGRectMake(0, orderOne.bottom, SCREEN_WIDTH, 73)];
    [fuWuView addSubview:orderTwo];
    CGFloat btnrecommendedW = 70;
    CGFloat btnrecommendedH = 48;
    CGFloat recommendedspace = (SCREEN_WIDTH - 4*btnrecommendedW)/6;
    NSArray *actTitleArray = [NSArray arrayWithObjects:@"邀请好友",@"优惠券",@"红包",@"会员俱乐部", nil];
    NSArray *actImgArray = [NSArray arrayWithObjects:@"mine_profile_invitation_ic",@"mine_profile_ticket_ic",@"mine_profile_welfare_ic",@"mine_profile_collection_ic", nil];
    for (int i=0; i<4; i++) {
        HeadButton *btn = [[HeadButton alloc]initWithFrame:CGRectMake(recommendedspace+ (btnrecommendedW+recommendedspace)*i,20,btnrecommendedW, btnrecommendedH)];
        btn.tag = i+200;
        [btn setImage:[UIImage imageNamed:actImgArray[i]] forState:UIControlStateNormal];
        [btn setTitle:actTitleArray[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(activeBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [orderTwo addSubview:btn];
    }
    _totleHeight = _totleHeight +fuWuView.height;
}
@end
