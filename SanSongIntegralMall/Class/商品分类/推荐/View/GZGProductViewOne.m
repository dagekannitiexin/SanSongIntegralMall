//
//  GZGProductViewOne.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GZGProductViewOne.h"

@implementation GZGProductViewOne

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //frame 随着屏幕大小变化
        [self initView];
    }
    return self;
    
}

- (void)initView
{
    UIImageView *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    headImg.image = [UIImage imageNamed:@"Img_default"];
    headImg.contentMode = UIViewContentModeScaleAspectFill;
    headImg.clipsToBounds = YES;
    [self addSubview:headImg];
    
    UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, headImg.bottom+8, self.width, 38)];
    nameLabel.numberOfLines = 2;
    NSString * text = @"水性可撕系列指甲油";
    //设置字间距
    NSDictionary *dic = @{NSKernAttributeName:@1.f
                          };
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4.0f];//行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [nameLabel setAttributedText:attributedString];
    nameLabel.textColor = GZGTextColor;
    nameLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:nameLabel];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, nameLabel.bottom+7, self.width, 17)];
    priceLabel.font = [UIFont systemFontOfSize:13];
    priceLabel.numberOfLines = 1;
    priceLabel.text = @"200分+20元";
    priceLabel.textColor = GZGPriceColor;
    [self addSubview:priceLabel];
}
@end
