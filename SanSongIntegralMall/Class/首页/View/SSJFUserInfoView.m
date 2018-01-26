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
    
    self.Name.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapLogin = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginBtn)];
    [self.Name addGestureRecognizer:tapLogin];
    
    self.MemberIcon.contentMode = UIViewContentModeScaleAspectFill;
    
}
/*
 设置会员图标
 */
- (void)setMemberStr:(NSString *)memberStr
{
    if (!_memberStr){
        _memberStr = memberStr;
        if ([_memberStr isEqualToString:@"0"]) {//积分会员
            self.MemberIcon.image = [UIImage imageNamed:@"core_point"];
        }else if ([_memberStr isEqualToString:@"1"]){//白银会员
            self.MemberIcon.image = [UIImage imageNamed:@"core_silver"];
        }else if ([_memberStr isEqualToString:@"2"]){//黄金会员
            self.MemberIcon.image = [UIImage imageNamed:@"core_golden"];
        }else if ([_memberStr isEqualToString:@"3"]){//白金会员
            self.MemberIcon.image = [UIImage imageNamed:@"core_platina"];
        }else if ([_memberStr isEqualToString:@"4"]){//钻石会员
            self.MemberIcon.image = [UIImage imageNamed:@"core_niello"];
        }else if ([_memberStr isEqualToString:@"5"]){//黑金会员
            self.MemberIcon.image = [UIImage imageNamed:@"core_silver"];
        }
    }
}

/*
 点击登录
 */
- (void)loginBtn
{
    if (self.touchViewBlock)
    {
        self.touchViewBlock(@"Login");
    }
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
