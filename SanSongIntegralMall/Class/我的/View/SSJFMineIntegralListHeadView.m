//
//  SSJFMineIntegralListHeadView.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFMineIntegralListHeadView.h"

@interface SSJFMineIntegralListHeadView()
@property (weak, nonatomic) IBOutlet UIView *iconView; //背景圆环
@property (weak, nonatomic) IBOutlet UILabel *integralNum;//积分数值
@property (weak, nonatomic) IBOutlet UIButton *jifenBtn;//积分商城按钮
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;//订单按钮

@end
@implementation SSJFMineIntegralListHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.width = SCREEN_WIDTH;
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    self.iconView.clipsToBounds = YES;
    
    self.jifenBtn.layer.borderWidth = 1.0;
    self.jifenBtn.layer.borderColor = RGBACOLOR(133, 133, 133, 0.6).CGColor;
    self.jifenBtn.layer.cornerRadius = 5.0;
    
    self.orderBtn.layer.borderWidth = 1.0;
    self.orderBtn.layer.borderColor = RGBACOLOR(133, 133, 133, 0.6).CGColor;
    self.orderBtn.layer.cornerRadius = 5.0;
}

@end
