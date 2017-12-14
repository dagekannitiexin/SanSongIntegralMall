//
//  HeadButton.m
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/29.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "HeadButton.h"

@implementation HeadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setTitleColor:RGBACOLOR(103, 103, 103, 1) forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        self.titleLabel.textColor = RGBACOLOR(45, 45, 52, 1);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

// 比例设置为  img  90*90  label 90*30  距离15    1:3
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, 50, 50);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0,58,50,13);
}
@end
