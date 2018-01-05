//
//  SSJFHomeModel.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SSJFHomeModel.h"
//@class UserInfoDetailModel;//用户
//@class HomeadvDetailModel;//轮播图
//@class ActivityDetailModel;//测试活动
//@class HomeProDetailModel1;//产品模块1

@implementation SSJFHomeModel
+ (NSDictionary *)objectClassInArray{
    return @{ @"userinfo" : [UserInfoDetailModel class] , @"homeadv":[HomeadvDetailModel class],@"integralact":[ActivityDetailModel class],@"homepro1":[HomeProDetailModel1 class],@"homepro3":[HomeProDetailModel3 class],@"homepro4":[HomeProDetailModel4 class],@"homepro5":[HomeProDetailModel5 class]};
}
@end

@implementation UserInfoDetailModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"Description": @"description"};
}

@end

@implementation HomeadvDetailModel

@end

@implementation ActivityDetailModel

@end

@implementation HomeProDetailModel1

@end

@implementation HomeProDetailModel3

@end

@implementation HomeProDetailModel4

@end

@implementation HomeProDetailModel5

@end
