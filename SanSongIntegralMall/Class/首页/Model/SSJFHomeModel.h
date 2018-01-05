//
//  SSJFHomeModel.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfoDetailModel;//用户
@class HomeadvDetailModel;//轮播图
@class ActivityDetailModel;//测试活动
@class HomeProDetailModel1;//产品模块1
@class HomeProDetailModel3;//产品模块3
@class HomeProDetailModel4;//产品模块4
@class HomeProDetailModel5;//产品模块5

@interface SSJFHomeModel : NSObject

@property(nonatomic,strong)UserInfoDetailModel * userinfo;
@property(nonatomic,strong)NSArray  <HomeadvDetailModel *>* homeadv;
@property(nonatomic,strong)NSArray  <ActivityDetailModel *>* integralact;
@property(nonatomic,strong)NSArray  <HomeProDetailModel1 *>* homepro1;
@property(nonatomic,strong)NSArray  <HomeProDetailModel3 *>* homepro3;
@property(nonatomic,strong)NSArray  <HomeProDetailModel4 *>* homepro4;
@property(nonatomic,strong)NSArray  <HomeProDetailModel5 *>* homepro5;

@end

/*
 用户
 */
@interface UserInfoDetailModel : NSObject

@property(nonatomic,strong)NSString  * ImageUrl;
@property(nonatomic,strong)NSString  * UserName;
@property(nonatomic,strong)NSString  * Integral;
@property(nonatomic,strong)NSString  * UserLevelSort;
@property(nonatomic,strong)NSString  * UserLevel;

@end

/*
 轮播图
 */
@interface HomeadvDetailModel : NSObject
@property(nonatomic,strong)NSString * AdID;
@property(nonatomic,strong)NSString * AdActionUrl;
@property(nonatomic,strong)NSString * AdName;
@property(nonatomic,strong)NSString * ImageID;
@property(nonatomic,strong)NSString * ImageUrl;
@end

/*
 测试活动
 */
@interface ActivityDetailModel : NSObject
@property(nonatomic,strong)NSString * SaleID;
@property(nonatomic,strong)NSString * SaleName;
@property(nonatomic,strong)NSString * StartTime;
@property(nonatomic,strong)NSString * EndTime;
@property(nonatomic,strong)NSString * SaleImgID;
@property(nonatomic,strong)NSString * AllowUser;
@property(nonatomic,strong)NSString * SaleImgUrl;
@end

/*
 产品模块1
 */
@interface HomeProDetailModel1 : NSObject
@property(nonatomic,strong)NSString * ProductID;
@property(nonatomic,strong)NSString * ProductName;
@property(nonatomic,strong)NSString * Price;
@property(nonatomic,strong)NSString * CutPrice;
@property(nonatomic,strong)NSString * SaleID;
@property(nonatomic,strong)NSString * SaleActivityType;
@property(nonatomic,strong)NSString * SaleType;
@property(nonatomic,strong)NSString * ImageID;
@property(nonatomic,strong)NSString * ActivityType;
@property(nonatomic,strong)NSString * Imageurl;
@property(nonatomic,strong)NSString * theSaletype;
@end

/*
 产品模块3
 */
@interface HomeProDetailModel3 : NSObject
@property(nonatomic,strong)NSString * ProductID;
@property(nonatomic,strong)NSString * ProductName;
@property(nonatomic,strong)NSString * Price;
@property(nonatomic,strong)NSString * CutPrice;
@property(nonatomic,strong)NSString * SaleID;
@property(nonatomic,strong)NSString * SaleActivityType;
@property(nonatomic,strong)NSString * SaleType;
@property(nonatomic,strong)NSString * ImageID;
@property(nonatomic,strong)NSString * ActivityType;
@property(nonatomic,strong)NSString * Imageurl;
@property(nonatomic,strong)NSString * theSaletype;
@end


/*
 产品模块4
 */
@interface HomeProDetailModel4 : NSObject
@property(nonatomic,strong)NSString * ProductID;
@property(nonatomic,strong)NSString * ProductName;
@property(nonatomic,strong)NSString * Price;
@property(nonatomic,strong)NSString * CutPrice;
@property(nonatomic,strong)NSString * SaleID;
@property(nonatomic,strong)NSString * SaleActivityType;
@property(nonatomic,strong)NSString * SaleType;
@property(nonatomic,strong)NSString * ImageID;
@property(nonatomic,strong)NSString * ActivityType;
@property(nonatomic,strong)NSString * Imageurl;
@property(nonatomic,strong)NSString * theSaletype;
@end

/*
 产品模块5
 */
@interface HomeProDetailModel5 : NSObject
@property(nonatomic,strong)NSString * ProductID;
@property(nonatomic,strong)NSString * ProductName;
@property(nonatomic,strong)NSString * Price;
@property(nonatomic,strong)NSString * CutPrice;
@property(nonatomic,strong)NSString * SaleID;
@property(nonatomic,strong)NSString * SaleActivityType;
@property(nonatomic,strong)NSString * SaleType;
@property(nonatomic,strong)NSString * ImageID;
@property(nonatomic,strong)NSString * ActivityType;
@property(nonatomic,strong)NSString * Imageurl;
@property(nonatomic,strong)NSString * theSaletype;
@end
