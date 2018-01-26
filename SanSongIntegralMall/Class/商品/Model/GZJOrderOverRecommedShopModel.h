//
//  GZJOrderOverRecommedShopModel.h
//  SanSongIntegralMall
//
//  Created by 林林尤达 on 2018/1/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderOverlPro;

@interface GZJOrderOverRecommedShopModel : NSObject
@property (nonatomic ,strong)NSArray  <OrderOverlPro *>*pro;
@end


@interface OrderOverlPro : NSObject
@property (nonatomic ,strong)NSString *ProductID;
@property (nonatomic ,strong)NSString *ProductName;
@property (nonatomic ,strong)NSString *ProductIntro;
@property (nonatomic ,strong)NSString *Price;
@property (nonatomic ,strong)NSString *CutPrice;
@property (nonatomic ,strong)NSString *SaleID;
@property (nonatomic ,strong)NSString *SaleActivityType;
@property (nonatomic ,strong)NSString *SaleType;
@property (nonatomic ,strong)NSString *ImageID;
@property (nonatomic ,strong)NSString *ActivityType;
@property (nonatomic ,strong)NSString *Imageurl;
@property (nonatomic ,strong)NSString *theSaletype;
@end
