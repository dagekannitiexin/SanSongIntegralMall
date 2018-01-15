//
//  SSJFQuickNavgitonViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SSJFQuickNavgitonViewController.h"
#import "NewButton.h"
#import "XMNavigationController.h"

@interface SSJFQuickNavgitonViewController ()
/** 功能数组 */
@property(nonatomic,strong)NSArray * imgIcon;
@property(nonatomic,strong)NSArray *btntitle;
@property(nonatomic,strong)UIScrollView * scrollView;
@end

@implementation SSJFQuickNavgitonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_interactivePopDisabled = YES;
    self.fd_prefersNavigationBarHidden = YES;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    _btntitle = [NSArray arrayWithObjects:@"摇一摇",@"大转盘",@"积分商城",@"积分商城",@"积分商城",@"积分商城",@"积分商城",@"积分商城", nil];
    _imgIcon =  [NSArray arrayWithObjects:@"14118b1838ce59ec1660349fe7132aab",@"0ffdf77a44bba312f53d5f2d72165d77",@"9250c17e8b4b74abb3ab41010b5a26b4",@"7c771ba44f5206f3d91946e28887accc",@"0cbdd1396a1aad263ce07e3e62f39071",@"aa1684550639106055813f6328a8a9d1",@"4460e0cf8575e8307f7f2cdf87aa4bb7",@"cd13de0e578303f904b8f1cd02ae9983", nil];
    [self reloadView];
}

- (void)setleftBackBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed: @"checkUserType_backward_9x15_" ] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(close)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 18/2, 37/2);
    UIBarButtonItem* itembutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = itembutton;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadView
{

    CGFloat h = 0.0;
    CGFloat widspace = 5;
    CGFloat heispace = 30;
    CGFloat btnwid = (SCREEN_WIDTH-4*widspace)/3;
    CGFloat btnhei = (SCREEN_WIDTH-4*widspace)/3;
    for(int i = 0;i<_btntitle.count;i++)
    {
        int m = i/3;
        int n = i%3;

//        AddFun * ad = self.AdArray[i];
        NewButton *btn = [[NewButton alloc]initWithFrame:CGRectMake(widspace+n*(btnwid+widspace), heispace + m*(btnhei+heispace), btnwid, btnhei)];
        btn.tag = i ;
//        NSString * urlstr = ad.image;
//        [btn sd_setImageWithURL:[NSURL URLWithString:urlstr] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:_imgIcon[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitle:_btntitle[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];

        h = CGRectGetMaxY(btn.frame);

    }

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,btnwid,btnwid)];
    btn.center = CGPointMake(self.view.width/2, h+btn.width/2);
    [btn setImage:[UIImage imageNamed:@"home_home_chazi"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(btn.frame)+30);


}

-(void)close
{
    XMNavigationController *nav = (XMNavigationController*)self.navigationController;
    [nav pop];
}

-(void)btnclick:(UIButton *)btn
{
    
}
@end
