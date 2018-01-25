//
//  GZJShopResultOfThePayment.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GZJShopResultOfThePayment.h"
#import "NomalBtnOne.h"
#import "orderPayBriefInformation.h"

@interface GZJShopResultOfThePayment (){
    UIScrollView *_scrollerView;
    CGFloat       _totleHeight;
}

@end

@implementation GZJShopResultOfThePayment

#define payinfoHeight 245
#define orderinfoHeight 85
- (void)setIsPaymentModel:(IsPaymentModel *)isPaymentModel
{
    if (!_isPaymentModel){
        _isPaymentModel = isPaymentModel;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款结果";
    _totleHeight = 0; //设置总head高度
    [self createScroller];
    [self createPayInfo];
    [self createOrderInfo];
    _scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, _totleHeight);
}

- (void)createPayInfo
{
    
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH,payinfoHeight)];;
    [_scrollerView addSubview:payView];
    
    UILabel *payState = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 30)];
    payState.text = @"付款成功";
    payState.font = [UIFont systemFontOfSize:22];
    payState.textAlignment = NSTextAlignmentCenter;
    payState.textColor = RGBACOLOR(166, 52, 50, 1);
    [payView addSubview:payState];
    
    UILabel *warmLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, payState.bottom+15, 200, 50)];
    warmLabel.centerX = SCREEN_WIDTH/2;
    warmLabel.text = @"您的商品我们会进口送到你的身边请耐心等待";
    //请在1小时内完成付款否则订单会被系统取消
    warmLabel.textAlignment = NSTextAlignmentCenter;
    warmLabel.numberOfLines = 2;
    warmLabel.textColor = RGBCOLOR(149, 149, 149);
    [payView addSubview:warmLabel];
    
    CGFloat boredWith = (SCREEN_WIDTH - 95*2-25)/2;
    NomalBtnOne *lookOrderBtn = [[NomalBtnOne alloc]initWithFrame:CGRectMake(boredWith, warmLabel.bottom+25, 95, 35)];
    [lookOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [lookOrderBtn setTitleColor:RGBACOLOR(51, 51, 51, 1) forState:UIControlStateNormal];
    [payView addSubview:lookOrderBtn];
    
    NomalBtnOne *payStateBtn = [[NomalBtnOne alloc]initWithFrame:CGRectMake(boredWith+95+25, warmLabel.bottom+25, 95, 35)];
    [payStateBtn setTitle:@"再来一单" forState:UIControlStateNormal];
    [payStateBtn setTitleColor:RGBACOLOR(51, 51, 51, 1) forState:UIControlStateNormal];
    [payView addSubview:payStateBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, payView.height-10, SCREEN_WIDTH, 10)];
    line.backgroundColor = RGBACOLOR(249, 249, 249, 1);
    [payView addSubview:line];
    
    _totleHeight = _totleHeight +payView.height;
}

- (void)createOrderInfo
{
    orderPayBriefInformation *orderView = [[NSBundle mainBundle]loadNibNamed:@"orderPayBriefInformation" owner:nil options:nil].lastObject;
    orderView.frame = CGRectMake(0, _totleHeight, SCREEN_WIDTH, 83);
    orderView.Name.text = self.isPaymentModel.Receiver;
    orderView.Tel.text  = self.isPaymentModel.ReceiverTel;
    orderView.AdressDetail.text  = self.isPaymentModel.ReceiverAddress;
    orderView.SumPrice.text  = [NSString stringWithFormat:@"¥%@",self.isPaymentModel.Bid];
    [_scrollerView addSubview:orderView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, orderView.bottom, SCREEN_WIDTH, 10)];
    line.backgroundColor = RGBACOLOR(249, 249, 249, 1);
    [_scrollerView addSubview:line];
    _totleHeight = _totleHeight +orderView.height +10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createScroller
{
    _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollerView.backgroundColor = [UIColor whiteColor];
    _scrollerView.showsVerticalScrollIndicator = FALSE;
    _scrollerView.showsHorizontalScrollIndicator = FALSE;
    _scrollerView.alwaysBounceHorizontal = NO;
    _scrollerView.layer.masksToBounds = YES;
    [self.view addSubview:_scrollerView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_scrollerView.contentOffset.y <= 0) {
        _scrollerView.bounces = NO;
    }
    else
        if (_scrollerView.contentOffset.y >= 0){
            _scrollerView.bounces = YES;
        }
}
@end
