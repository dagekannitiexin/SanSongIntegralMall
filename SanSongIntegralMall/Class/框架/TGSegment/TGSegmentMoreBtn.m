//
//  TGSegmentMoreBtn.m
//  TGSegment
//
//  Created by targetcloud on 2017/4/18.
//  Copyright © 2017年 targetcloud. All rights reserved.
//

#import "TGSegmentMoreBtn.h"
@interface TGSegmentMoreBtn()
@property (nonatomic, assign) CGFloat radio;
@end

@implementation TGSegmentMoreBtn

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.imageView.contentMode = UIViewContentModeScaleAspectFit;//UIViewContentModeScaleAspectFill
    }
    return self;
}

-(CGFloat)radio {
    return 0.2;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    return CGRectMake(0, 1, contentRect.size.width * self.radio, contentRect.size.height);
    return CGRectMake(0, 0, 0, 0);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((contentRect.size.width-15*1.2)/2,(contentRect.size.height -8*1.2)/2+4,15*1.2,8*1.2);
}

@end
