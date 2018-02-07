//
//  GZGRecommendModel.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/2/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeadvDetailModell;//轮播图
@class HomeProDetailModel;//产品模块
@class HomeProDetailtype;//产品类型
@class HomeProDetailList;//产品列表

@interface GZGRecommendModel : NSObject
@property(nonatomic,strong)NSArray  <HomeadvDetailModell *>* homeadv;
@property(nonatomic,strong)NSArray  <HomeProDetailModel *>* actListVml;
@end

/*
 轮播图
 */
@interface HomeadvDetailModell : NSObject
@property(nonatomic,strong)NSString * AdID;
@property(nonatomic,strong)NSString * AdActionUrl;
@property(nonatomic,strong)NSString * AdName;
@property(nonatomic,strong)NSString * AdDescription;
@property(nonatomic,strong)NSString * ImageUrl;
@end


/*
 产品模块
 */
@interface HomeProDetailModel : NSObject
@property (nonatomic, strong) HomeProDetailtype *typeList;
@property (nonatomic, strong) NSArray  <HomeProDetailList *> *proList;
@end

/*
 产品类型
 */
@interface HomeProDetailtype : NSObject
@property(nonatomic,strong)NSString * HomeType;
@property(nonatomic,strong)NSString * TypeID;
@property(nonatomic,strong)NSString * TypeName;
@end

/*
 产品列表
 */
@interface HomeProDetailList : NSObject
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
