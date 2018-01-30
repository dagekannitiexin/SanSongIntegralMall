//
//  Utility.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject


/** 进入视图 */
+(void)goVcForItemId:(NSString *)itemid WithURL:(NSString *)url WithType:(NSString *)type WithNavGation:(UINavigationController *)nav;
/** url加密 */
+ (NSString *)getH5token:(NSString*)url;

/** 字典生成accesstoken */
+ (NSString *)accessNSDiconary:(NSDictionary *)dic;
/** 获取http头文件 */
+ (NSDictionary*)getHttpHead;

@end
