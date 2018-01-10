//
//  ShopDetailModel.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class proSaleModel;//打折活动

@interface ShopDetailModel : NSObject

@property (nonatomic, strong) NSString *ProductID;
@property (nonatomic, strong) NSString *ProductName;
@property (nonatomic, strong) NSString *ProductIntro;
@property (nonatomic, strong) NSString *StartTime;
@property (nonatomic, strong) NSString *EndTime;
@property (nonatomic, strong) NSString *Price;
@property (nonatomic, strong) NSString *NewPrice;
@property (nonatomic, strong) NSString *ImageUrl;
@property (nonatomic, strong) NSString *SaleActivityType;
@property (nonatomic, strong) NSString *SaleType;
@property (nonatomic, strong) NSString *Enable;
@property (nonatomic, strong) NSArray <proSaleModel *>*proSale;

@end


@interface proSaleModel : NSObject

@property (nonatomic, strong) NSString *SaleID;
@property (nonatomic, strong) NSString *SaleName;
@property (nonatomic, strong) NSArray  *FavContent;

@end
