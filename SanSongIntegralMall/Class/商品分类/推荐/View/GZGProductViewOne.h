//
//  GZGProductViewOne.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectDetail) (void);
@interface GZGProductViewOne : UIView
@property (nonatomic ,copy) selectDetail selectDetailBlock;
@property (nonatomic ,strong)NSString *headImgString;
@property (nonatomic ,strong)NSString *nameLabelString;
@property (nonatomic ,strong)NSString *priceLabelString;
@end
