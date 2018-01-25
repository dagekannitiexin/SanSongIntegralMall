//
//  NomalBtnOne.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NomalBtnOne.h"

@implementation NomalBtnOne

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self)
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = RGBACOLOR(51, 51, 51, 1);
        self.layer.cornerRadius = 3.0;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGBACOLOR(192, 192, 192, 1).CGColor;
    }
    
    return self;
}


@end
