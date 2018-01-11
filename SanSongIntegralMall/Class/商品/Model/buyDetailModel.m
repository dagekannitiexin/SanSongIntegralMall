//
//  buyDetailModel.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "buyDetailModel.h"

@implementation buyDetailModel

+ (NSDictionary *)objectClassInArray{
    return @{ @"address" : [addressModel class],@"proinfo" :[proinfoModel class] };
}

@end

@implementation addressModel

@end

@implementation proinfoModel

@end
