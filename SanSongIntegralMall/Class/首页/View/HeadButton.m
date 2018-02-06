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
        [self setTitleColor:GZGGaryTextColor forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        self.titleLabel.textColor = GZGGaryTextColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

// 比例设置为  img  90*90  label 90*30  距离15    1:3
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((self.width -25)/2, 0, 25, 25);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0,35,70,13);
}
@end
