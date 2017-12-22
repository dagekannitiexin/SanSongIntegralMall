//
//  SSJFUserInfoView.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFUserInfoView.h"


@implementation SSJFUserInfoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.width = SCREEN_WIDTH;
    //设置控件属性
    self.IconImg.layer.cornerRadius = self.IconImg.width/2;
    self.IconImg.clipsToBounds = YES;
    self.IconImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconClick)];
    [self.IconImg addGestureRecognizer:tapIcon];
    
    self.Integral.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapIntegral = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIntegralClick)];
    [self.Integral addGestureRecognizer:tapIntegral];
    
    
}

/*
 点击icon的手势方法
 */
- (void)tapIconClick
{
    if (self.touchViewBlock)
    {
        self.touchViewBlock(@"Icon");
    }
}

/*
 点击积分的手势方法
 */
- (void)tapIntegralClick
{
    if (self.touchViewBlock)
    {
        self.touchViewBlock(@"Integral");
    }
}
@end
