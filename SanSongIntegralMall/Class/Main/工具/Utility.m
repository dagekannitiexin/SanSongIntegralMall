//
//  Utility.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "Utility.h"
#import "DesUtil.h"
#import "GTMBase64.h"
#import "NSData+AES.h"
#import "Base64.h"

@implementation Utility

+(NSString*)accessNSDiconary:(NSDictionary *)dic
{
    
    NSString *jsonString = [NSString jsonStringWithDictionary:dic];
    NSString * Key = @"sftintegrallMall";//sftintegrall   dkdb610
    NSString *iv = @"N3nLasdhgypjZu3r";
    NSData *data1 = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //加密
    data1 = [data1 AES128EncryptWithKey:Key iv:iv];
    NSData *data3 = [GTMBase64 encodeData:data1];
    NSString *str3 = [[NSString alloc] initWithData:data3 encoding:NSUTF8StringEncoding];
    return   str3;
    
}

+(NSDictionary *)getHttpHead
{
    NSMutableDictionary *dicc = [[NSMutableDictionary alloc]init];
    NSDate * Now = [NSDate date];
    NSString * Key = @"hijkappnbtv2015abcd";
    NSString * Uuid = @"123";
    NSString * Date = [NSString stringWithFormat:@"%ld", (long)[Now timeIntervalSince1970]];
    NSString * Device = DeviceID;
    NSString * authkey = [NSString stringWithFormat:@"%@|%@|%@",Device,Key,Date];
    NSLog(@"authkey = %@",authkey);
    NSString *token = USER_TOKEN;
//    NSString * Tcze = [token authCodeEncoded:authkey];
//    Tcze = [Tcze stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    Tcze = [Tcze stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    [dicc setValue:Device forKey:@"pragma-device"];
    [dicc setValue:token forKey:@"pragma-tcze"];
    [dicc setValue:Uuid forKey:@"pragma-uuid"];
    [dicc setValue:Date forKey:@"pragma-date"];
    [dicc setValue:@"dknbios" forKey:@"User-Agent"];
    
    return dicc;
    
}

@end
