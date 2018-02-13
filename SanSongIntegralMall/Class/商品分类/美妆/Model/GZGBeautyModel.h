//
//  GZGBeautyModel.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/2/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeadvDetailModellBea;//轮播图
@class HomeProDetailModelBea;//产品模块


@interface GZGBeautyModel : NSObject
@property(nonatomic,strong)NSArray  <HomeadvDetailModellBea *>* homeadv;
@property(nonatomic,strong)NSArray  <HomeProDetailModelBea *>* proList;
@end

/*
 轮播图
 */
@interface HomeadvDetailModellBea : NSObject
@property(nonatomic,strong)NSString * AdID;
@property(nonatomic,strong)NSString * AdActionUrl;
@property(nonatomic,strong)NSString * IsExternalLink;
@property(nonatomic,strong)NSString * AdPosId;
@property(nonatomic,strong)NSString * AdName;
@property(nonatomic,strong)NSString * AdDescription;
@property(nonatomic,strong)NSString * ImageUrl;
@end



/*
 产品列表
 */
@interface HomeProDetailModelBea : NSObject
@property(nonatomic,strong)NSString * ProductID;
@property(nonatomic,strong)NSString * ProductName;
@property(nonatomic,strong)NSString * ProductIntro;
@property(nonatomic,strong)NSString * MoneyPrice;
@property(nonatomic,strong)NSString * IntegralPrice;
@property(nonatomic,strong)NSString * ProTypeID;
@property(nonatomic,strong)NSString * Showing;
@property(nonatomic,strong)NSString * SaleID;
@property(nonatomic,strong)NSString * TagsId;
@property(nonatomic,strong)NSString * proTagList;
@property(nonatomic,strong)NSString * Num;
@end
