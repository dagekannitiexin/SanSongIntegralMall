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

/** 字典生成accesstoken */
+ (NSString *)accessNSDiconary:(NSDictionary *)dic;
/** 获取http头文件 */
+ (NSDictionary*)getHttpHead;

@end
