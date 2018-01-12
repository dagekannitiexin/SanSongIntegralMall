//
//  XMBuyShopView.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMBuyShopView.h"
#import "UIImageView+WebCache.h"
#import "buyDetailModel.h"

@interface XMBuyShopView(){
    NSString *_choosePayWay; //用于保存选择的数据
    UIImageView *_zhifubaoImg; //切换选中的支付宝样式
    UIImageView *_selectedZhifubao; //切换选中状态
    UIImageView *_weixinImg; //切换选中的微信样式
    UIImageView *_selectedWeiXin; //切换选中状态
}

@property (nonatomic ,strong)UIView *orderViewOne;
@property (nonatomic ,strong)UIView *orderViewTwo;
@property (nonatomic ,strong)UIView *orderViewThree;
@property (nonatomic ,strong)UIButton *cancelBtn; //取消返回按钮
@property (nonatomic ,strong)UILabel *titleLabel; //标题
@property (nonatomic ,strong)buyDetailModel *buyModel;
@end

@implementation XMBuyShopView

- (void)setShopModel:(ShopDetailModel *)shopModel
{
    if (!_shopModel){
        _shopModel = shopModel;
        //创建导航栏 和底部确认栏
        [self createEditNavView];
        
        //创建第一步详细部分
        [self editTheOrder];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.size = CGSizeMake(SCREEN_WIDTH-30, 400);
        //设置初始位置
        self.centerX = SCREEN_WIDTH/2;
        self.centerY = SCREEN_HEIGHT/2;
        self.layer.cornerRadius = 12.0;
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark -创建订单  One
/*
 创建订单
 */
- (void)editTheOrder{
    _orderViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 55, self.width, 270+75)];
    _orderViewOne.backgroundColor = [UIColor whiteColor];
    [self addSubview:_orderViewOne];
    
    //创建详细
    [self createDetailView];
}

- (void)createEditNavView{
    //导航栏 取消and 编辑订单
    UIView * editNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 55)];
    [self addSubview:editNavView];
    
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 40, 20)];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal
     ];
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    _cancelBtn.tag = 101;
    [editNavView addSubview:_cancelBtn];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    _titleLabel.center = editNavView.center;
    _titleLabel.text = @"编辑订单";
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [editNavView addSubview:_titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(12, 54, editNavView.width-24, 1)];
    lineView.backgroundColor = XMGaryColor;
    [editNavView addSubview:lineView];
}

- (void)createDetailView{
    //设置homeView
    UIScrollView *scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _orderViewOne.width, 270)];
    scrView.backgroundColor = [UIColor whiteColor];
    scrView.showsVerticalScrollIndicator = FALSE;
    scrView.showsHorizontalScrollIndicator = FALSE;
    scrView.alwaysBounceHorizontal = YES;
    scrView.layer.masksToBounds = YES;
    [_orderViewOne addSubview:scrView];
    
    UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(_orderViewOne.width-68-15, 20, 68, 68)];
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_shopModel.ImageUrl]] placeholderImage:[UIImage imageNamed:@"Img_default"]];
    [scrView addSubview:iconImg];
 
    UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, iconImg.left-20, 15)];
    desc.text = [NSString stringWithFormat:@"%@",_shopModel.ProductIntro];
    desc.font = [UIFont fontWithName:@"Helvetica" size:14];
    [scrView addSubview:desc];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(15, desc.bottom+13, desc.width, 15)];
    price.text = [NSString stringWithFormat:@"%@元",_shopModel.NewPrice];
    price.font = [UIFont fontWithName:@"Helvetica" size:14];
    [scrView addSubview:price];
    
    UILabel *info = [[UILabel alloc]initWithFrame:CGRectMake(15, price.bottom+15, desc.width, 11)];
    info.text = @"江浙沪包邮 | 库存充足";
    info.textColor =XMHeigtGaryColor;
    info.font = [UIFont systemFontOfSize:10];
    [scrView addSubview:info];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, info.bottom+20, _orderViewOne.width-30, 150)];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    imgView.image = [UIImage imageNamed:@"Img_default"];
    [scrView addSubview:imgView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, scrView.height-1, scrView.width, 0.5)];
    lineView.backgroundColor = XMGaryColor;
    [scrView addSubview:lineView];
    
    UIView *footViewOne =[[UIView alloc]initWithFrame:CGRectMake(0, scrView.bottom, self.width, 75)];
    [_orderViewOne addSubview:footViewOne];
    
    UIButton * determine = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width-30, 44)];
    determine.centerX = footViewOne.centerX;
    determine.centerY = 75/2;
    determine.backgroundColor = RGBACOLOR(209, 88, 84, 1);
    [determine setTitle:[NSString stringWithFormat:@"%@元确认",_shopModel.NewPrice] forState:UIControlStateNormal];
    [determine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    determine.layer.cornerRadius = 7.0;
    determine.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [determine addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footViewOne addSubview:determine];
}

/*
 取消按钮
 */
- (void)cancelClick:(UIButton *)seder{
    
    if (seder.tag ==101){
        if (self.cancelBtnBlock)
        {
            self.cancelBtnBlock();
        }
    }else if (seder.tag == 102){
        [UIView animateWithDuration:0.25 animations:^{
            self.size = CGSizeMake(SCREEN_WIDTH-30, 400);
            self.centerY = SCREEN_HEIGHT/2;
        } completion:^(BOOL finished) {
            self.size = CGSizeMake(SCREEN_WIDTH-30, 400);
        }];
        _orderViewTwo.hidden = YES;
        _cancelBtn.titleLabel.text = @"取消";
        _cancelBtn.tag = 101;
        _titleLabel.text = @"编辑订单";
        _orderViewOne.hidden = NO;
    }else if (seder.tag == 103){
        [UIView animateWithDuration:0.25 animations:^{
            self.size = CGSizeMake(SCREEN_HEIGHT-30, 455);
            self.centerY = SCREEN_HEIGHT/2;
        } completion:^(BOOL finished) {
            self.size = CGSizeMake(SCREEN_WIDTH-30, 455);
        }];
        _orderViewThree.hidden = YES;
        _cancelBtn.titleLabel.text = @"返回";
        _cancelBtn.tag = 102;
        _titleLabel.text  = @"确认订单";
        _orderViewTwo.hidden = NO;
    }
    
}

/*
 点击确认按钮
 */
- (void)determineBtnClick{
    //请求网络
        //查看首页
        NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/OrderDetail/ConfirmList"];
        //设置常用参数
        NSMutableDictionary *dic =[NSMutableDictionary dictionary];
        [dic setValue:_shopModel.ProductID forKey:@"ProductId"];
        [dic setValue:@"2" forKey:@"Num"];
        NSMutableArray *shopArray = [NSMutableArray arrayWithObjects:dic, nil];
        NSString *jsonStr = [NSString jsonStringWithArray:shopArray];
        NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
        [requestInfo setValue:jsonStr forKey:@""];
        [SVProgressHUD showWithStatus:@"生成订单中"];
        __weak XMBuyShopView *weakSelf = self;
        [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
            NSString *reflag =  [NSString stringWithFormat:@"%@",[aDictronaryBaseObjects objectForKey:@"ReFlag"]];
            NSDictionary *rdt = [aDictronaryBaseObjects objectForKey:@"Rdt"];
            if (reflag){
                if ([reflag isEqualToString:@"1"]){
                    [SVProgressHUD dismiss];
                    //给模型赋值
                    weakSelf.buyModel = [buyDetailModel mj_objectWithKeyValues:rdt];
                    //此处有动画
                    [UIView animateWithDuration:0.15 animations:^{
                        self.size = CGSizeMake(SCREEN_WIDTH-30, 455);
                        self.centerY = SCREEN_HEIGHT/2;
                    } completion:^(BOOL finished) {
                        self.size = CGSizeMake(SCREEN_WIDTH-30, 455);
                    }];
                    //隐藏第一个界面 并且底部也隐藏
                    self.orderViewOne.hidden = YES;
                    //产生订单给用户 待确认
                    [self createDetermineViewTwo];
            }
            }else {
                [SVProgressHUD showInfoWithStatus:[rdt objectForKey:@"ErrorMessage"]];
            }
    
        } onError:^(NSError *engineError) {
            [SVProgressHUD dismiss];
            NSLog(@"no");
        }];
}

#pragma mark -创建订单  Two

- (void)createDetermineViewTwo{
    //创建第一步
    _orderViewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 55, self.width, 455-55)];
    _orderViewTwo.backgroundColor = [UIColor whiteColor];
    [self addSubview:_orderViewTwo];
    
    //修改导航栏 和底部确认栏
    _cancelBtn.titleLabel.text = @"返回";
    _cancelBtn.tag = 102;
    _titleLabel.text = @"确认订单";
    //创建详细
    [self createDetailViewTwo];
}

- (void)createDetailViewTwo{
    //第一部分 地址icon 姓名 电话 详细地址 选择按钮
    UIView *adressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:adressView];
    
    //增加手势
    UITapGestureRecognizer *addressTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseAdress)];
    [adressView addGestureRecognizer:addressTap];
    
    UIImageView *adressImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    adressImg.image = [UIImage imageNamed:@"iconTradeLocation"];
    [adressView addSubview:adressImg];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(adressImg.right+15, 15, 55, 16)];
    name.text = [NSString stringWithFormat:@"%@",_buyModel.ReData[0].address.ReceiveName];
    name.textColor = [UIColor blackColor];
    name.font = [UIFont systemFontOfSize:15];
    [adressView addSubview:name];
    
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(name.right+5, name.y, 150, 15)];
    phone.text = [NSString stringWithFormat:@"%@",_buyModel.ReData[0].address.Telphone];
    phone.textColor = [UIColor blackColor];
    phone.font = [UIFont systemFontOfSize:15];
    [adressView addSubview:phone];
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(name.x, name.bottom+10, adressView.width-name.right-15, 16)];
    address.font = [UIFont systemFontOfSize:14];
    address.text = [NSString stringWithFormat:@"%@%@%@%@",_buyModel.ReData[0].address.Province,_buyModel.ReData[0].address.Town,_buyModel.ReData[0].address.District,_buyModel.ReData[0].address.Address];
    address.textColor = XMHeigtGaryColor;
    [adressView addSubview:address];
    
    //箭头
    UIImageView *next = [[UIImageView alloc]initWithFrame:CGRectMake(adressView.width-15-24, 0, 24, 24)];
    next.centerY = adressView.height/2;
    next.image = [UIImage imageNamed:@"btnAdditionNormal"];
    [adressView addSubview:next];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, adressView.width-24, 1)];
    lineView.backgroundColor = XMGaryColor;
    [adressView addSubview:lineView];
    
    //第二部分 商品icon 描述商品 商品选择尺码 数量
    UIView *shoppingView = [[UIView alloc]initWithFrame:CGRectMake(0, adressView.bottom, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:shoppingView];
    
    UIImageView *shoppingImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    shoppingImg.image = [UIImage imageNamed:@"iconTradeChannel"];
    [shoppingView addSubview:shoppingImg];
    
    UILabel *shoppingDesc = [[UILabel alloc]initWithFrame:CGRectMake(shoppingImg.right+15, 15, shoppingView.width -shoppingImg.right -30-30, 16)];
    shoppingDesc.text = [NSString stringWithFormat:@"%@",_buyModel.ReData[0].proinfo.ProductIntro];
    shoppingDesc.textColor = [UIColor blackColor];
    shoppingDesc.font = [UIFont systemFontOfSize:15];
    [shoppingView addSubview:shoppingDesc];
    
    UILabel *shoppingSize = [[UILabel alloc]initWithFrame:CGRectMake(shoppingDesc.x, shoppingDesc.bottom+10, shoppingView.width-shoppingDesc.x-15, 16)];
    shoppingSize.font = [UIFont systemFontOfSize:14];
    shoppingSize.text = @"CM2209S阴霾蓝/均码 x1";
    shoppingSize.textColor = XMHeigtGaryColor;
    [shoppingView addSubview:shoppingSize];
    
    UIView *lineShoppingView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, shoppingView.width-24, 1)];
    lineShoppingView.backgroundColor = XMGaryColor;
    [shoppingView addSubview:lineShoppingView];
    //第三部分 优惠券icon 优惠券描述 优惠券选择
    UIView *couponsView = [[UIView alloc]initWithFrame:CGRectMake(0, shoppingView.bottom, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:couponsView];
    
    UITapGestureRecognizer *couponsTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(couponsBtnClick)];
    [couponsView addGestureRecognizer:couponsTap];
    
    UIImageView *couponsImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    couponsImg.image = [UIImage imageNamed:@"iconTradeCoupon"];
    [couponsView addSubview:couponsImg];
    
    UILabel *couponsLabel = [[UILabel alloc]initWithFrame:CGRectMake(couponsImg.right+15, 0, shoppingView.width-shoppingDesc.x-15, 16)];
    couponsLabel.centerY = couponsView.height/2;
    couponsLabel.font = [UIFont systemFontOfSize:15];
    couponsLabel.text = @"暂无可用优惠券";
    couponsLabel.textColor = [UIColor blackColor];
    [couponsView addSubview:couponsLabel];
    
    //箭头
    UIImageView *nextCoupons = [[UIImageView alloc]initWithFrame:CGRectMake(adressView.width-15-24, 0, 24, 24)];
    nextCoupons.centerY = adressView.height/2;
    nextCoupons.image = [UIImage imageNamed:@"btnAdditionNormal"];
    [couponsView addSubview:nextCoupons];
    
    UIView *lineCouponsView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, couponsView.width-24, 1)];
    lineCouponsView.backgroundColor = XMGaryColor;
    [couponsView addSubview:lineCouponsView];
    
    //第四部分 实际付款icon 文字 阿拉伯数字价格 运费描述
    UIView *payForView = [[UIView alloc]initWithFrame:CGRectMake(0, couponsView.bottom, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:payForView];
    
    UIImageView *payForImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    payForImg.image = [UIImage imageNamed:@"iconTradePay"];
    [payForView addSubview:payForImg];
    
    UILabel *payForLabel = [[UILabel alloc]initWithFrame:CGRectMake(payForImg.right+15, 0, payForView.width-shoppingDesc.x-15, 16)];
    payForLabel.centerY = payForView.height/2;
    payForLabel.font = [UIFont systemFontOfSize:15];
    payForLabel.text = @"实付款";
    payForLabel.textColor = [UIColor blackColor];
    [payForView addSubview:payForLabel];
    
    UILabel *payForMoney = [[UILabel alloc]initWithFrame:CGRectMake(payForView.width-15-50, 15, 50, 16)];
    payForMoney.text = [NSString stringWithFormat:@"¥%@",_buyModel.ReData[0].proinfo.NewPrice];
    //@"¥136"
    payForMoney.textColor = [UIColor redColor];
    payForMoney.font = [UIFont systemFontOfSize:15];
    [payForView addSubview:payForMoney];
    
    UILabel *payForFreight = [[UILabel alloc]initWithFrame:CGRectMake(payForView.width-15-60, payForMoney.bottom+5, 60, 16)];
    payForFreight.text = @"含运费7元";
    payForFreight.font = [UIFont systemFontOfSize:12];
    payForFreight.textColor = XMHeigtGaryColor;
    [payForView addSubview:payForFreight];
    
    
    UIView *linePayForView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, payForView.width-24, 1)];
    linePayForView.backgroundColor = XMGaryColor;
    [payForView addSubview:linePayForView];
    
    //第五部分 笔icon 添加备注 textView
    
    UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(0, payForView.bottom, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:remarkView];
    
    UIImageView *remarkImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    remarkImg.image = [UIImage imageNamed:@"iconTradeNote"];
    [remarkView addSubview:remarkImg];
    
    UITextField *remarkTextFile = [[UITextField alloc]initWithFrame:CGRectMake(remarkImg.right+15, 0, remarkView.width -remarkImg.right -15-10, 20)];
    remarkTextFile.centerY = remarkView.height/2;
    remarkTextFile.placeholder = @"添加备注...";
    remarkTextFile.font = [UIFont systemFontOfSize:14];
    remarkTextFile.clearButtonMode = UITextFieldViewModeWhileEditing;
    [remarkView addSubview:remarkTextFile];
    
    UIView *lineRemarkView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, remarkView.width-24, 1)];
    lineRemarkView.backgroundColor = XMGaryColor;
    [remarkView addSubview:lineRemarkView];
    
    //第六部分
    UIView *footView =[[UIView alloc]initWithFrame:CGRectMake(0, remarkView.bottom, self.width, 75)];
    [_orderViewTwo addSubview:footView];
    
    UIButton *determine = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _orderViewTwo.width-60, 44)];
    determine.centerX = footView.centerX;
    determine.centerY = 75/2;
    determine.backgroundColor = RGBACOLOR(209, 88, 84, 1);
    [determine setTitle:@"选择付款方式" forState:UIControlStateNormal];
    [determine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    determine.layer.cornerRadius = 7.0;
    determine.titleLabel.font = [UIFont systemFontOfSize:17];
    [determine addTarget:self action:@selector(chooseBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:determine];
}

- (void)chooseBuyBtnClick{
    //创建动画
    [UIView animateWithDuration:0.25 animations:^{
        self.size = CGSizeMake(SCREEN_WIDTH-30, 260);
        self.centerY = SCREEN_HEIGHT/2;
    } completion:^(BOOL finished) {
        self.size = CGSizeMake(SCREEN_WIDTH-30, 260);
    }];
    //隐藏第二个界面
    self.orderViewTwo.hidden = YES;
    [self createDetailViewThree];
}

/*
 选择地址
 */
- (void)chooseAdress
{
    if (self.adressBtnBlock)
    {
        self.adressBtnBlock();
    }
}

/*
 选择优惠券
 */
- (void)couponsBtnClick
{
    if (self.couponsBlock)
    {
        self.couponsBlock();
    }
}

#pragma mark - 支付界面
- (void)createDetailViewThree
{
    _orderViewThree = [[UIView alloc]initWithFrame:CGRectMake(0, 55, self.width, 205)];
    _orderViewThree.backgroundColor = [UIColor whiteColor];
    [self addSubview:_orderViewThree];
    
    //修改导航栏 和底部确认栏
    _cancelBtn.titleLabel.text = @"返回";
    _cancelBtn.tag = 103;
    _titleLabel.text = @"付款方式";
    
    //支付宝
    UIView *zhifubaoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _orderViewThree.width, 65)];
    [_orderViewThree addSubview:zhifubaoView];
    
    _zhifubaoImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 64, 22.5)];
    _zhifubaoImg.image = [UIImage imageNamed:@"iconAlipayNormal"];
    _zhifubaoImg.centerY = zhifubaoView.height/2;
    [zhifubaoView addSubview:_zhifubaoImg];
    
    _selectedZhifubao = [[UIImageView alloc]initWithFrame:CGRectMake(_orderViewThree.width-15-22.5,0, 22.5, 22.5)];
    _selectedZhifubao.centerY = zhifubaoView.height/2;
    _selectedZhifubao.image = [UIImage imageNamed:@"iconGrayCircle"];
    [zhifubaoView addSubview:_selectedZhifubao];
    
    UIView *lineZhiFuBaoView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, zhifubaoView.width-24, 1)];
    lineZhiFuBaoView.backgroundColor = XMGaryColor;
    [zhifubaoView addSubview:lineZhiFuBaoView];
    
    UITapGestureRecognizer *tapZhifubao = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosePayWayZhiFuBao)];
    
    [zhifubaoView addGestureRecognizer:tapZhifubao];
    
    //微信支付
    UIView *weixinView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, _orderViewThree.width, 65)];
    [_orderViewThree addSubview:weixinView];
    
    _weixinImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 83.3, 22.5)];
    _weixinImg.image = [UIImage imageNamed:@"iconWechatNormal"];
    _weixinImg.centerY = weixinView.height/2;
    [weixinView addSubview:_weixinImg];
    
    _selectedWeiXin = [[UIImageView alloc]initWithFrame:CGRectMake(_orderViewThree.width-15-22.5,0, 22.5, 22.5)];
    _selectedWeiXin.centerY = weixinView.height/2;
    _selectedWeiXin.image = [UIImage imageNamed:@"iconGrayCircle"];
    [weixinView addSubview:_selectedWeiXin];
    
    UIView *lineWeiXinView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, weixinView.width-24, 1)];
    lineWeiXinView.backgroundColor = XMGaryColor;
    [weixinView addSubview:lineWeiXinView];
    
    UITapGestureRecognizer *tapWeiXin = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choosePayWayWeiXin)];
    
    [weixinView addGestureRecognizer:tapWeiXin];
    //立即支付
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, self.width-30, 44)];
    payBtn.centerY = weixinView.bottom+75/2;
    payBtn.backgroundColor = RGBACOLOR(209, 88, 84, 1);
    [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.layer.cornerRadius = 7.0;
    payBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [payBtn addTarget:self action:@selector(payBtnSelect) forControlEvents:UIControlEventTouchUpInside];
    [_orderViewThree addSubview:payBtn];
    
}
//选择支付宝还是微信
- (void)choosePayWayZhiFuBao
{
    //当之前选择微信时  将微信恢复正常状态
    if ([_choosePayWay isEqualToString:@"微信"]){
        _weixinImg.image = [UIImage imageNamed:@"iconWechatNormal"];
        _selectedWeiXin.image = [UIImage imageNamed:@"iconGrayCircle"];
        _selectedWeiXin.highlighted = NO;
    }
    _zhifubaoImg.image = [UIImage imageNamed:@"iconAlipaySelected"];
    _selectedZhifubao.image = [UIImage imageNamed:@"iconCheckSelected"];
    _choosePayWay = [NSString stringWithFormat:@"支付宝"];
    _selectedZhifubao.highlighted = YES;
}

- (void)choosePayWayWeiXin
{
    //当之前选择微信时  将微信恢复正常状态
    if ([_choosePayWay isEqualToString:@"支付宝"]){
        _zhifubaoImg.image = [UIImage imageNamed:@"iconAlipayNormal"];
        _selectedZhifubao.image = [UIImage imageNamed:@"iconGrayCircle"];
        _selectedZhifubao.highlighted = NO;
    }
    _weixinImg.image = [UIImage imageNamed:@"iconWechatSelected"];
    _selectedWeiXin.image = [UIImage imageNamed:@"iconCheckSelected"];
    _choosePayWay = [NSString stringWithFormat:@"微信"];
    _selectedWeiXin.highlighted = YES;
}
/*
 支付按钮选择
 */
- (void)payBtnSelect
{
    if (_selectedWeiXin.highlighted){
        NSLog(@"去微信支付喽");
        if (self.payBtnBlock)
        {
            self.payBtnBlock();
        }
    }else if (_selectedZhifubao.highlighted){
        NSLog(@"去支付宝支付楼");
        if (self.payBtnBlock)
        {
            self.payBtnBlock();
        }
    }
}


@end
