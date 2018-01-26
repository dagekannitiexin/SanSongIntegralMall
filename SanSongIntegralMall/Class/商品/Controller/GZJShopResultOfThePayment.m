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
#import "SSJFGoodsMostNumView.h"
#import "UIImageView+WebCache.h"

@interface GZJShopResultOfThePayment ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UIScrollView *_scrollerView;
    CGFloat       _totleHeight;
    UICollectionView  *mainCollectionView;
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

- (void)setRderRecommedShopModel:(GZJOrderOverRecommedShopModel *)rderRecommedShopModel
{
    if (!_rderRecommedShopModel){
        _rderRecommedShopModel = rderRecommedShopModel;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款结果";
    _totleHeight = 0; //设置总head高度
    [self createScroller];
    [self createPayInfo];
    [self createOrderInfo];
    [self createActDuiHuan];
    _scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, _totleHeight);
}

- (void)createPayInfo
{
    
    UIView *payView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH,payinfoHeight)];;
    payView.backgroundColor = [UIColor whiteColor];
    [_scrollerView addSubview:payView];
    
    UILabel *payState = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 30)];
    if (_isPayfor){
        payState.text = @"付款成功";
        payState.textColor = RGBACOLOR(82, 168, 91, 1);
    }else {
        payState.text = @"付款失败";
        payState.textColor = RGBACOLOR(166, 52, 50, 1);
    }
    payState.font = [UIFont systemFontOfSize:22];
    payState.textAlignment = NSTextAlignmentCenter;
    [payView addSubview:payState];
    
    UILabel *warmLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, payState.bottom+15, 185, 50)];
    warmLabel.centerX = SCREEN_WIDTH/2;
    warmLabel.textColor = RGBCOLOR(149, 149, 149);
    if (_isPayfor){
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"确认收货后，获得1积分预计3天内送达"];
        //设置文字颜色
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:RGBACOLOR(266, 53, 51, 1)
                              range:NSMakeRange(8, 1)];
        warmLabel.attributedText = AttributedStr;
    }else {
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"请在1小时内完成付款否则订单会被系统取消"];
        //设置文字颜色
        [AttributedStr addAttribute:NSForegroundColorAttributeName
                              value:RGBACOLOR(266, 53, 51, 1)
                              range:NSMakeRange(2, 1)];
        warmLabel.attributedText = AttributedStr;
    }
    
    //请在1小时内完成付款否则订单会被系统取消
    warmLabel.textAlignment = NSTextAlignmentCenter;
    warmLabel.numberOfLines = 2;
    warmLabel.font = [UIFont systemFontOfSize:13];
    [payView addSubview:warmLabel];
    
    CGFloat boredWith = (SCREEN_WIDTH - 95*2-25)/2;
    NomalBtnOne *lookOrderBtn = [[NomalBtnOne alloc]initWithFrame:CGRectMake(boredWith, warmLabel.bottom+25, 95, 35)];
    [lookOrderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [lookOrderBtn setTitleColor:RGBACOLOR(51, 51, 51, 1) forState:UIControlStateNormal];
    [payView addSubview:lookOrderBtn];
    
    NomalBtnOne *payStateBtn = [[NomalBtnOne alloc]initWithFrame:CGRectMake(boredWith+95+25, warmLabel.bottom+25, 95, 35)];
    if (_isPayfor){
        [payStateBtn setTitle:@"继续逛" forState:UIControlStateNormal];
    }else {
        [payStateBtn setTitle:@"重新付款" forState:UIControlStateNormal];
    }
    
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
    NSMutableString * num = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@"                                                           ,self.isPaymentModel.ReceiverTel]];
    [num replaceCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
    orderView.Tel.text  = num;
    orderView.AdressDetail.text  = self.isPaymentModel.ReceiverAddress;
    orderView.SumPrice.text  = [NSString stringWithFormat:@"¥  %@",self.isPaymentModel.Bid];
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
    _scrollerView.backgroundColor = [UIColor clearColor];
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

/*
 积分兑换
 UICollectionView的高度为150*(num/2+0.5)
 */
- (void)createActDuiHuan
{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake((SCREEN_WIDTH-30)/2, 270);
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 290*(_rderRecommedShopModel.pro.count)/2+55) collectionViewLayout:layout];
    mainCollectionView.scrollEnabled = NO;
    mainCollectionView.showsVerticalScrollIndicator = NO;
    [_scrollerView addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerNib:[UINib nibWithNibName:@"SSJFGoodsMostNumView" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    _totleHeight = _totleHeight +mainCollectionView.height;
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _rderRecommedShopModel.pro.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSJFGoodsMostNumView *cell = (SSJFGoodsMostNumView *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.ProductName.text = _rderRecommedShopModel.pro[indexPath.row].ProductName;
    cell.Price.text = [NSString stringWithFormat:@"%@%@",@"¥",_rderRecommedShopModel.pro[indexPath.row].Price];
    [cell.Imageurl sd_setImageWithURL:[NSURL URLWithString:_rderRecommedShopModel.pro[indexPath.row].Imageurl] placeholderImage:[UIImage imageNamed:@"Img_default"]];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-30)/2, 270);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 55);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor whiteColor];
    UILabel *shopRecommed = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 20)];
    shopRecommed.centerX = headerView.width/2;
    shopRecommed.centerY = headerView.height/2;
    shopRecommed.text = @"其他人也在买";
    shopRecommed.font = [UIFont systemFontOfSize:15];
    shopRecommed.textAlignment = NSTextAlignmentCenter;
    shopRecommed.textColor =RGBACOLOR(51, 51, 51, 1);
    [headerView addSubview:shopRecommed];
    return headerView;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *msg = cell.botlabel.text;
    //    NSLog(@"%@",msg);
}
@end
