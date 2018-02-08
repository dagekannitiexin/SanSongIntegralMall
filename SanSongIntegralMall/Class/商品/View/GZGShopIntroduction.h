//
//  GZGShopIntroduction.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/2/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GZGShopIntroduction : UIView

/*
 传入商品名称 商品介绍 商品价格 商品标签
 */
- (void)initNewView:(NSString *)ProductName productIntro:(NSString *)ProductIntro moneyPriceAndIntegralPrice:(NSString *)price proTagList:(NSArray *)ProTagList;
@end
