//
//  GZJShopResultOfThePayment.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "XMBaseViewController.h"
#import "IsPaymentModel.h"
#import "GZJOrderOverRecommedShopModel.h"

@interface GZJShopResultOfThePayment : XMBaseViewController

@property (nonatomic , strong)IsPaymentModel *isPaymentModel;
@property (nonatomic , strong)GZJOrderOverRecommedShopModel *rderRecommedShopModel;
@property (nonatomic , assign)BOOL   isPayfor;//是否支付成功
@end
