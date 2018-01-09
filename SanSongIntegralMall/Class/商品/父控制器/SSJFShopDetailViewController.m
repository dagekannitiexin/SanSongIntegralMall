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

@interface SSJFShopDetailViewController ()<SDCycleScrollViewDelegate>{
    SDCycleScrollView *_lunzhuanView;
    UITableView       *_tableView;
    UIView            *_homeView;
    UITextView        *_text;
    CGFloat            _totleHeight;
}
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详细";
    //创建主视图 并且将其嵌入tableView内
    [self createView];
    [self initTableView];
    //创建底部兑换界面
    [self exchangeView];
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
    _text = [[UITextView alloc]initWithFrame:CGRectMake(10, _totleHeight, SCREEN_WIDTH -20, SCREEN_HEIGHT -_totleHeight)];
    [_homeView addSubview:_text];
    _text.editable = NO;
    if(self.string)
    {
        _text.text = self.string;
    }
    else
    {
        _text.text = @"一.活动时间 \n     每周一到周一: 18:45-19:45 \n     每周六:18:45-19:20 \n     锁定宁波电视台都市文体频道《讲大道》、《宁波老话》栏目。  \n二.参与方式 \n     1.屏幕右上方出现“摇一摇”提示，摇动手机即可参与。 \n     2.摇动即有奖，进入积分商城将积分独欢礼品。 \n三.得分规则 \n     每成功摇动1次可获得随机数额积分,最高可获得500个积分。  \n四.兑换奖品 \n     积分可在商城兑换奖品，由快递发送。 \n     部分奖品需上门自取。 \n五.活动说明 \n     活动细则详询“点看宁波”客服，苹果公司不是该游戏的发起者，也没有任何方式参与该活动，“点看宁波”保留对本次活动的最终解释权。";
    }
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_text.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _text.text.length)];
    
    _text.attributedText = attributedString;
    _text.textColor = RGBCOLOR(150, 150, 150);
    [_text setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    [_text sizeToFit];
    _totleHeight = _totleHeight +_text.height;
}

- (void)createResponsibility
{
    //这里创建免责条款等
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 300)];
    textView.backgroundColor = [UIColor grayColor];
    [_homeView addSubview:textView];
    
}

/*
 兑换
 */
- (void)exchangeView
{
    UIView *buy = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
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
    
    NSString *priceStr = @"单价:188 积分";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:RGBCOLOR(255, 128, 0)
                    range:NSMakeRange(3, 4)];
    priceLabel.attributedText = attrStr;
    
    //购买按钮
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 110, 30)];
    buyBtn.centerY = buy.height/2;
    buyBtn.right = SCREEN_WIDTH - 13;
    [buy addSubview:buyBtn];
    buyBtn.layer.cornerRadius = 3.0;
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [buyBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [buyBtn setBackgroundColor:RGBACOLOR(238, 149, 96, 1)];
    [buyBtn addTarget:self action:@selector(exchangeNow) forControlEvents:UIControlEventTouchUpInside];
}

/*
 兑换按钮
 */
- (void)exchangeNow
{
    NSLog(@"立即兑换成功");
    //产生毛玻璃效果盖在最顶层
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //必须给effcetView的frame赋值,因为UIVisualEffectView是一个加到UIIamgeView上的子视图.
    _effectView.frame = self.view.bounds;
    [self.view addSubview:_effectView];
    //将view显示出来
    [self.view addSubview:self.shopView];
    //计算上移动大小
    [UIView animateWithDuration:0.35 animations:^{
        self.shopView.centerY = SCREEN_HEIGHT/2;
    }];
}

#pragma mark - lazyInit
- (XMBuyShopView*)shopView
{
    if (!_shopView){
        _shopView = [[XMBuyShopView alloc]init];
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
            }];
            [blockSelf.effectView removeFromSuperview];
        };
        //地址按钮响应
        _shopView.adressBtnBlock = ^{
            XMMeAddressEmpty *addressVC = [[XMMeAddressEmpty alloc]init];
            [blockSelf.navigationController pushViewController:addressVC animated:YES];
        };
        
        //优惠券按钮响应
        _shopView.couponsBlock = ^{
//            XMMeCoupon *couponVc =[[XMMeCoupon alloc]init];
//            [blockSelf.navigationController pushViewController:couponVc animated:YES];
        };
    }
    return _shopView;
}
@end
