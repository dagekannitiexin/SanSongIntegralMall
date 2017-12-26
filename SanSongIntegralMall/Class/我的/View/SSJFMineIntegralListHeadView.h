//
//  SSJFMineIntegralListHeadView.h
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSJFMineIntegralListHeadView : UIView
typedef void (^btnMineOrder)(void);

@property (nonatomic, copy)btnMineOrder btnMineOrderBlock;
@end
