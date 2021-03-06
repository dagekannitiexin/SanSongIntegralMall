//
//  SSJFShopDetailViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFShopDetailViewController.h"
#import "SDCycleScrollView.h"
#import "XMBuyShopView.h"
#import "XMMeAddressEmpty.h"
#import "ShopDetailModel.h"
#import "NSString+JSON.h"
#import <AlipaySDK/AlipaySDK.h>
#import "IsPaymentModel.h"
#import "GZJShopResultOfThePayment.h"
#import "GZJOrderOverRecommedShopModel.h"
#import "UIImageView+WebCache.h"
#import "GZGShopIntroduction.h"

@interface SSJFShopDetailViewController ()<SDCycleScrollViewDelegate>{
    SDCycleScrollView *_lunzhuanView;
    UITableView       *_tableView;
    UIView            *_homeView;
    UITextView        *_text;
    CGFloat            _totleHeight;
}

@property (nonatomic ,strong)ShopDetailModel *shopModel;
@property (nonatomic ,strong)IsPaymentModel  *isPaymentModel;
//订单回调推荐商品model
@property (nonatomic ,strong)GZJOrderOverRecommedShopModel *rderRecommedShopModel;

/*
 毛玻璃界面
 */
@property (nonatomic,strong)UIVisualEffectView *effectView;
/*购买界面
 */
@property (nonatomic,strong) XMBuyShopView *shopView;

@property(nonatomic,strong)NSString * string;

@end

@implementation SSJFShopDetailViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeNotificationCenter];
}
//初始化proid 来获取产品详细
- (void)setProid:(NSString *)proid
{
    if (proid){
        _proid = proid;
        [self initNetwork];
    }
}

/*
 请求网络详细
 */
- (void)initNetwork
{
    
    //查看首页
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/Product/GetProDetail"];
    //设置常用参数
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setValue:self.proid forKey:@"proid"];
    [SVProgressHUD showWithStatus:@"获取商品详细中"];
    __weak SSJFShopDetailViewController *weakSelf = self;
    [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"GET" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        NSString *reflag = [aDictronaryBaseObjects objectForKey:@"ReFlag"];
        NSDictionary *rdt = [aDictronaryBaseObjects objectForKey:@"Rdt"];
        if ([reflag isEqualToString:@"1"]){
            [SVProgressHUD dismiss];
            weakSelf.shopModel = [ShopDetailModel mj_objectWithKeyValues:[rdt objectForKey:@"ReData"]];
            //创建主视图 并且将其嵌入tableView内
            [weakSelf createView];
            [weakSelf initTableView];
            //创建底部兑换界面
            [weakSelf exchangeView];
        }else {
            [SVProgressHUD showInfoWithStatus:[rdt objectForKey:@"ErrorMessage"]];
        }
        
    } onError:^(NSError *engineError) {
        [SVProgressHUD dismiss];
        NSLog(@"no");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详细";
    //注册通知
    [self registration];
}

/*
 注册通知
 */
- (void)registration
{
    [GZNotificationCenter addObserver:self selector:@selector(PayInfoThing:) name:PayForInfo object:nil];
}

/*
 移除通知
 */
- (void)removeNotificationCenter
{
    [GZNotificationCenter removeObserver:self];
}
/*
 支付回调
 */
- (void)PayInfoThing:(NSNotification *)note
{
    NSDictionary *payDic = [note valueForKey:@"object"];
    if (payDic){
        NSDictionary *result = [payDic objectForKey:@"result"];
        NSString *jsonStr = [result mj_JSONString];
        //查看首页
        NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/OrderDetail/IsPayment"];
        //设置常用参数
        NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
        [requestInfo setValue:jsonStr forKey:@""];
        __weak SSJFShopDetailViewController *weakSelf = self;
        [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
            NSString *reflag = [aDictronaryBaseObjects objectForKey:@"ReFlag"];
            NSDictionary *rdt = [aDictronaryBaseObjects objectForKey:@"Rdt"];
            if ([reflag isEqualToString:@"1"]){
                NSDictionary *Reta = [rdt objectForKey:@"ReData"];
                weakSelf.isPaymentModel = [IsPaymentModel mj_objectWithKeyValues:[Reta objectForKey:@"OrderVml"]];
                weakSelf.rderRecommedShopModel = [GZJOrderOverRecommedShopModel mj_objectWithKeyValues:Reta];
                GZJShopResultOfThePayment *VC = [[GZJShopResultOfThePayment alloc]init];
                VC.isPaymentModel = weakSelf.isPaymentModel;
                VC.rderRecommedShopModel = weakSelf.rderRecommedShopModel;
                //设置回调页面的支付状态
                if ([[rdt objectForKey:@"ErrorMessage"]isEqualToString:@"success"])
                {
                    VC.isPayfor = YES;
                }
                [weakSelf.navigationController pushViewController:VC animated:YES];
            }
        } onError:^(NSError *engineError) {
            [SVProgressHUD dismiss];
            NSLog(@"no");
        }];
    }else {
        [SVProgressHUD showInfoWithStatus:@"网络状态不佳"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_tableView];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = YES;
    [_tableView setTableHeaderView:_homeView];
}

#pragma mark - init
- (void)createView
{
    _homeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 0, 0)];
//    [self.view addSubview:_homeView];
    //初始化总高
    _totleHeight = 0;
    //商品详细第一部分 轮转图
    [self createBannerView];
    //创建介绍
    [self createIntroductView];
    //创建介绍富文本
    [self createDetailView];
    //创建底部责任条款
    [self createResponsibility];
    //最后重设_homeView的大小
    _homeView.size = CGSizeMake(SCREEN_WIDTH, _totleHeight);
    
}

- (void)createBannerView
{
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (int i=0; i<_shopModel.MasterImg.count; i++) {
        NSString *imageStr = [_shopModel.MasterImg[i] objectForKey:@"Url"];
        [imageArray addObject:imageStr];
    }
    
    _lunzhuanView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, SCREEN_WIDTH) imageURLStringsGroup:imageArray];
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

/*
 介绍视图
 */
- (void)createIntroductView
{
    GZGShopIntroduction *introView = [[GZGShopIntroduction alloc]init];
    introView.origin = CGPointMake(0, _totleHeight);
    [introView initNewView:_shopModel.ProductName productIntro:_shopModel.ProductIntro moneyPriceAndIntegralPrice:[NSString stringWithFormat:@"%@积分+%@元",_shopModel.IntegralPrice,_shopModel.MoneyPrice] proTagList:_shopModel.proTagList];
    [_homeView addSubview:introView];
    _totleHeight = _totleHeight + introView.height;
}

 - (void)createDetailView
{
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (int i=0; i<_shopModel.IntroImg.count; i++) {
        NSString *imageStr = [_shopModel.IntroImg[i] objectForKey:@"Url"];
        [imageArray addObject:imageStr];
    }
    UIView *imageArrayView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 0)];
    [_homeView addSubview:imageArrayView];
    for (int i=0; i<imageArray.count; i++) {
        UIImageView *shouImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, i*SCREEN_WIDTH/2, SCREEN_WIDTH, SCREEN_WIDTH/2)];
        [shouImageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:[UIImage imageNamed:@"Img_default"]];
        shouImageView.clipsToBounds = YES;
        [imageArrayView addSubview:shouImageView];
    }
    imageArrayView.height = imageArray.count*SCREEN_WIDTH/2;
    _totleHeight = _totleHeight +imageArrayView.height;
    
//    _text = [[UITextView alloc]initWithFrame:CGRectMake(10, _totleHeight, SCREEN_WIDTH -20, SCREEN_HEIGHT -_totleHeight)];
//    [_homeView addSubview:_text];
//    _text.editable = NO;
//    if(self.string)
//    {
//        _text.text = self.string;
//    }
//    else
//    {
//        _text.text = @"一.活动时间 \n     每周一到周一: 18:45-19:45 \n     每周六:18:45-19:20 \n     锁定宁波电视台都市文体频道《讲大道》、《宁波老话》栏目。  \n二.参与方式 \n     1.屏幕右上方出现“摇一摇”提示，摇动手机即可参与。 \n     2.摇动即有奖，进入积分商城将积分独欢礼品。 \n三.得分规则 \n     每成功摇动1次可获得随机数额积分,最高可获得500个积分。  \n四.兑换奖品 \n     积分可在商城兑换奖品，由快递发送。 \n     部分奖品需上门自取。 \n五.活动说明 \n     活动细则详询“点看宁波”客服，苹果公司不是该游戏的发起者，也没有任何方式参与该活动，“点看宁波”保留对本次活动的最终解释权。";
//    }
//
//
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_text.text];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle setLineSpacing:3];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _text.text.length)];
//
//    _text.attributedText = attributedString;
//    _text.textColor = RGBCOLOR(150, 150, 150);
//    [_text setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
//    [_text sizeToFit];
//    _totleHeight = _totleHeight +_text.height;
}

- (void)createResponsibility
{
    //这里创建免责条款等
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, SCREEN_WIDTH/15*4+30)];
    textView.backgroundColor = [UIColor whiteColor];
    [_homeView addSubview:textView];
    
    UIImageView *shopWarningView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_WIDTH/15*4)];
    shopWarningView.image = [UIImage imageNamed:@"shop_warning"];
    shopWarningView.contentMode = UIViewContentModeScaleAspectFit;
    [textView addSubview:shopWarningView];
    _totleHeight = _totleHeight +textView.height+60;
}

/*
 兑换
 */
- (void)exchangeView
{
    UIView *buy = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49-64, SCREEN_WIDTH, 49)];
    buy.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buy];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor =RGBCOLOR(220, 220, 220);
    [buy addSubview:line];
    
    // 单价
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    priceLabel.x = 15;
    priceLabel.size = CGSizeMake(200, 20);
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.numberOfLines = 1;
    priceLabel.centerY = buy.height/2;
    [buy addSubview:priceLabel];
    
//    NSString *priceStr = @"单价:188 积分";
    NSString *priceStr = [NSString stringWithFormat:@"单价:%@ 积分+%@元",_shopModel.IntegralPrice,_shopModel.MoneyPrice];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:RGBCOLOR(255, 128, 0)
                    range:NSMakeRange(3, _shopModel.IntegralPrice.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:RGBCOLOR(255, 128, 0)
                range:NSMakeRange(7+_shopModel.IntegralPrice.length, _shopModel.MoneyPrice.length)];
    priceLabel.attributedText = attrStr;
    
    //购买按钮
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
    buyBtn.centerY = buy.height/2;
    buyBtn.right = SCREEN_WIDTH - 13;
    [buy addSubview:buyBtn];
    buyBtn.layer.cornerRadius = 3.0;
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    //判断是否下架
    NSString *enable = _shopModel.Enable;
    if ([enable isEqualToString:@"0"]){
        [buyBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
        [buyBtn setBackgroundColor:RGBACOLOR(238, 149, 96, 1)];
    }else if ([enable isEqualToString:@"1"]){
        [buyBtn setTitle:@"已下架" forState:UIControlStateNormal];
        [buyBtn setBackgroundColor:RGBACOLOR(192, 192, 192, 1)];
        buyBtn.enabled = NO;
    }
    
    [buyBtn addTarget:self action:@selector(exchangeNow) forControlEvents:UIControlEventTouchUpInside];
}

/*
 兑换按钮
 */
- (void)exchangeNow
{
    
    //产生毛玻璃效果盖在最顶层
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //必须给effcetView的frame赋值,因为UIVisualEffectView是一个加到UIIamgeView上的子视图.
    _effectView.frame = self.view.bounds;
    [self.view addSubview:_effectView];
    
    //将view显示出来
    [self.view addSubview:self.shopView];
    
    //计算上移动大小 加入动画效果
    [UIView animateWithDuration:0.35 animations:^{
        self.shopView.centerY = (SCREEN_HEIGHT-64)/2;
    }];
        
}

#pragma mark - lazyInit
- (XMBuyShopView*)shopView
{
    if (!_shopView){
        _shopView = [[XMBuyShopView alloc]init];
        _shopView.shopModel = _shopModel;
        __block SSJFShopDetailViewController *blockSelf = self;
        //取消按钮 响应
        _shopView.cancelBtnBlock = ^{
            [UIView animateWithDuration:0.15 animations:^{
                blockSelf.shopView.y = SCREEN_HEIGHT;
            } completion:^(BOOL finished) {
                [blockSelf.shopView removeFromSuperview];
            }];
            [blockSelf.effectView removeFromSuperview];
        };
        
        //支付按钮响应
        _shopView.payBtnBlock = ^{
            [UIView animateWithDuration:0.15 animations:^{
                blockSelf.shopView.y = SCREEN_HEIGHT;
            } completion:^(BOOL finished) {
                [blockSelf.shopView removeFromSuperview];
                blockSelf.shopView = nil;
            }];
            [blockSelf.effectView removeFromSuperview];
        };
        
        //地址按钮响应
//        _shopView.adressBtnBlock = ^{
//            XMMeAddressEmpty *addressVC = [[XMMeAddressEmpty alloc]init];
//            addressVC.isChooseId = YES;
//            [blockSelf.navigationController pushViewController:addressVC animated:YES];
//        };
        
        //优惠券按钮响应
//        _shopView.couponsBlock = ^{
////            XMMeCoupon *couponVc =[[XMMeCoupon alloc]init];
////            [blockSelf.navigationController pushViewController:couponVc animated:YES];
//        };
    }
    return _shopView;
}

/*
 NSSttring
 */
- (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

@end
