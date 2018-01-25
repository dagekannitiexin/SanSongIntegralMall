//
//  IsPaymentModel.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IsPaymentModel : NSObject

@property (nonatomic , strong)NSString *OrderCode;
@property (nonatomic , strong)NSString *ProductId;
@property (nonatomic , strong)NSString *ProductName;
@property (nonatomic , strong)NSString *OriginalPrice;
@property (nonatomic , strong)NSString *Num;
@property (nonatomic , strong)NSString *FarePrice;
@property (nonatomic , strong)NSString *CutRatePrice;
@property (nonatomic , strong)NSString *Bid;
@property (nonatomic , strong)NSString *UserId;
@property (nonatomic , strong)NSString *CartId;
@property (nonatomic , strong)NSString *TransactionStatus;
@property (nonatomic , strong)NSString *Receiver;
@property (nonatomic , strong)NSString *ReceiverAddress;
@property (nonatomic , strong)NSString *ReceiverTel;
@property (nonatomic , strong)NSString *Memo;
@property (nonatomic , strong)NSString *CreateTime;

@end
