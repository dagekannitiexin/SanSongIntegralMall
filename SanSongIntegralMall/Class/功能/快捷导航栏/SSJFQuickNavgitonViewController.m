//
//  SSJFQuickNavgitonViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SSJFQuickNavgitonViewController.h"

@interface SSJFQuickNavgitonViewController ()
/** 功能数组 */
@property(nonatomic,strong)NSArray * imgIcon;
@property(nonatomic,strong)NSArray *btntitle;
@end

@implementation SSJFQuickNavgitonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imgIcon = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)reloadView
//{
//
//    CGFloat h = 0.0;
//    CGFloat widspace = 5;
//    CGFloat heispace = 30;
//    CGFloat btnwid = (SCREEN_WIDTH-4*widspace)/3;
//    CGFloat btnhei = (SCREEN_WIDTH-4*widspace)/3;
//    for(int i = 0;i<_AdArray.count;i++)
//    {
//        int m = i/3;
//        int n = i%3;
//
//        AddFun * ad = self.AdArray[i];
//        NewButton *btn = [[NewButton alloc]initWithFrame:CGRectMake(widspace+n*(btnwid+widspace), heispace + m*(btnhei+heispace), btnwid, btnhei)];
//        btn.tag = i ;
//        NSString * urlstr = ad.image;
//        [btn sd_setImageWithURL:[NSURL URLWithString:urlstr] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//        [btn setTitle:ad.title forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.scrollView addSubview:btn];
//
//        h = CGRectGetMaxY(btn.frame);
//
//    }
//
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,btnwid,btnwid)];
//    btn.center = CGPointMake(self.view.width/2, h+btn.width/2);
//    [btn setImage:[UIImage imageNamed:@"home_home_chazi"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
//    [self.scrollView addSubview:btn];
//    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(btn.frame)+30);
//
//
//}

@end
