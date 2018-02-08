//
//  buyDetailModel.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReDataModel;//数组
@class addressModel;//地址
@class proinfoModel;//产品

@interface buyDetailModel : NSObject
@property (nonatomic, strong) NSArray <ReDataModel *>*ReData;
@property (nonatomic, strong) NSString *ErrorMessage;
@property (nonatomic, strong) NSString *IdData;
@end

@interface ReDataModel : NSObject
@property (nonatomic, strong) proinfoModel *proVml;
@property (nonatomic, strong) addressModel *address;
@property (nonatomic, strong) NSString  *SumMoneyPrice;
@property (nonatomic, strong) NSString  *SumIntegralPrice;
@end


@interface addressModel : NSObject

@property (nonatomic, strong) NSString *AddressID;
@property (nonatomic, strong) NSString *ReceiveName;
@property (nonatomic, strong) NSString *Telphone;
@property (nonatomic, strong) NSString *Province;
@property (nonatomic, strong) NSString *Town;
@property (nonatomic, strong) NSString *District;
@property (nonatomic, strong) NSString *Address;
@property (nonatomic, strong) NSString *IsDefault;

@end

@interface proinfoModel : NSObject

@property (nonatomic, strong) NSString *ProductID;
@property (nonatomic, strong) NSString *ProductName;
@property (nonatomic, strong) NSString *ProductIntro;
@property (nonatomic, strong) NSString *MoneyPrice;
@property (nonatomic, strong) NSString *IntegralPrice;
@property (nonatomic, strong) NSString *ProTypeID;
@property (nonatomic, strong) NSString *Showing;
@property (nonatomic, strong) NSString *SaleID;
@property (nonatomic, strong) NSString *TagsId;
@property (nonatomic, strong) NSArray  *proTagList;
@property (nonatomic, strong) NSString *Num;
@end
