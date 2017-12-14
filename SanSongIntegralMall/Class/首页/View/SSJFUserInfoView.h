//
//  SSJFUserInfoView.h
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/14.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSJFUserInfoView : UIView

typedef void (^touchView) (NSString *str);
@property (weak, nonatomic) IBOutlet UIImageView *IconImg; //头像
@property (weak, nonatomic) IBOutlet UILabel *Name; //昵称
@property (weak, nonatomic) IBOutlet UIImageView *MemberIcon;//会员图像
@property (weak, nonatomic) IBOutlet UILabel *MemberLeves;//会员等级
@property (weak, nonatomic) IBOutlet UILabel *Integral;//积分

@property (nonatomic,copy)touchView touchViewBlock;


@end
