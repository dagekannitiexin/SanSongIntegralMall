//
//  Utility.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "Utility.h"
#import "DesUtil.h"
#import "AESCipher.h"

@implementation Utility

+(NSString*)accessNSDiconary:(NSDictionary *)dic
{
    
    NSString *jsonString = [NSString jsonStringWithDictionary:dic];
    NSString * Key = @"sftintegrallMall";//sftintegrall   dkdb610
    NSString * Tcze = aesEncryptString(jsonString, Key);
    return   Tcze;
    
}

@end
