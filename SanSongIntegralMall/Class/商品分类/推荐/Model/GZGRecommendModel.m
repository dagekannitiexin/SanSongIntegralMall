//
//  GZGRecommendModel.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/2/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GZGRecommendModel.h"

@implementation GZGRecommendModel
+ (NSDictionary *)objectClassInArray{
    return @{ @"homeadv" : [HomeadvDetailModell class],@"actListVml" :[HomeProDetailModel class]};
}
@end

@implementation HomeadvDetailModell

@end

@implementation HomeProDetailModel
+ (NSDictionary *)objectClassInArray{
    return @{ @"typeList" : [HomeProDetailtype class],@"proList" :[HomeProDetailList class]};
}
@end

@implementation HomeProDetailtype

@end

@implementation HomeProDetailList

@end
