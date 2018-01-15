//
//  NewButton.m
//  MZYY(Doctor)
//
//  Created by cuikefeng on 15/7/30.
//  Copyright (c) 2015年 PengLin. All rights reserved.
//

#import "NewButton.h"
#define kImageRatio 0.7
@implementation NewButton

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        self.titleLabel.textColor = [UIColor grayColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }

    return self;
}

-(CGRect) titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * kImageRatio -5;
    CGFloat titleHeight = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, contentRect.size.width, titleHeight);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * kImageRatio);
}
@end
