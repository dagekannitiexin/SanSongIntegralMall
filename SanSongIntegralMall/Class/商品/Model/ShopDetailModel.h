//
//  ShopDetailModel.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/10.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetailModel : NSObject

@property (nonatomic, strong) NSString *ProductID;
@property (nonatomic, strong) NSString *ProductName;
@property (nonatomic, strong) NSString *ProductIntro;
@property (nonatomic, strong) NSString *MoneyPrice;
@property (nonatomic, strong) NSString *IntegralPrice;
@property (nonatomic, strong) NSString *Showing;
@property (nonatomic, strong) NSString *SaleID;
@property (nonatomic, strong) NSString *TagsId;
@property (nonatomic, strong) NSArray *proTagList;
@property (nonatomic, strong) NSArray *MasterImg;
@property (nonatomic, strong) NSArray *IntroImg;
@property (nonatomic, strong) NSDictionary *saleActVml;
@property (nonatomic, strong) NSString *Enable;
@end


