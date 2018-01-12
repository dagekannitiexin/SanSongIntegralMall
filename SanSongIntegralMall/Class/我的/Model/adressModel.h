//
//  adressModel.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReDataAdressModel;//数组

@interface adressModel : NSObject
@property (nonatomic, strong) NSArray <ReDataAdressModel *>*ReData;
@property (nonatomic, strong) NSString *ErrorMessage;
@property (nonatomic, strong) NSString *IdData;
@end


@interface ReDataAdressModel : NSObject
@property (nonatomic, strong) NSString *AddressID;
@property (nonatomic, strong) NSString *ReceiveName;
@property (nonatomic, strong) NSString *Telphone;
@property (nonatomic, strong) NSString *Province;
@property (nonatomic, strong) NSString *Town;
@property (nonatomic, strong) NSString *District;
@property (nonatomic, strong) NSString *Address;
@property (nonatomic, strong) NSString *IsDefault;
@end
