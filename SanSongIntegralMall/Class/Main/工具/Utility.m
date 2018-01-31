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
#import "WebViewController.h"
#import "WebViewBannerController.h"

@implementation Utility

+(void)goVcForItemId:(NSString *)itemid WithURL:(NSString *)url WithType:(NSString *)type WithNavGation:(UINavigationController *)nav
{
    if ([type isEqualToString:@"banner"]){
        WebViewBannerController *web = [[WebViewBannerController alloc]init];
        web.urlStr = url;
        web.title = @"公主家";
        web.fd_prefersNavigationBarHidden = YES;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"美妆鉴赏"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"美妆心得大赛";
        web.urlStr = url;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"专题栏"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"公主家";
        web.urlStr = url;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"变美视频"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"变美视频";
        web.urlStr = url;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"大牌试用"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"大牌试用";
        web.urlStr = url;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"专题"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"SoFullTeam首富团官微";
        web.urlStr = url;
        
        [nav pushViewController:web animated:YES];
        return;
    }
}

+ (NSString *)getH5token:(NSString*)url
{
    return url;  //假装加密了 回头设置
}

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
    [dicc setValue:Device forKey:@"pragma-device"];
    [dicc setValue:token forKey:@"pragma-tcze"];
    [dicc setValue:Uuid forKey:@"pragma-uuid"];
    [dicc setValue:Date forKey:@"pragma-date"];
    [dicc setValue:@"dknbios" forKey:@"User-Agent"];
    
    return dicc;
    
}

@end
