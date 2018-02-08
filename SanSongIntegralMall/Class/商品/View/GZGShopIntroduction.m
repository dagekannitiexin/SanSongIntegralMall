//
//  GZGShopIntroduction.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/2/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GZGShopIntroduction.h"

@implementation GZGShopIntroduction

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initNewView:(NSString *)ProductName productIntro:(NSString *)ProductIntro moneyPriceAndIntegralPrice:(NSString *)price proTagList:(NSArray *)ProTagList
{
    self.width = SCREEN_WIDTH;
    //名称
    UILabel *ProductNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEN_WIDTH-78, 40)];
    ProductNameLabel.textColor = GZGTextColor;
    ProductNameLabel.font = [UIFont fontWithName:@"Helvetica-Regular" size:16];
    ProductNameLabel.numberOfLines = 2;
    ProductNameLabel.text = ProductName;
    [ProductNameLabel sizeToFit];
    ProductNameLabel.width = SCREEN_WIDTH-78;
    [self addSubview:ProductNameLabel];
    
    //描述
    UILabel *productIntroLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, ProductNameLabel.bottom+5, SCREEN_WIDTH-78, 0)];
    productIntroLabel.textColor = XMPalceHolderColor;
    productIntroLabel.font = [UIFont systemFontOfSize:14];
    productIntroLabel.numberOfLines = 1;
    productIntroLabel.text = ProductIntro;
    [productIntroLabel sizeToFit];
    productIntroLabel.width = SCREEN_WIDTH-78;
    [self addSubview:productIntroLabel];
    
    //价格
    UILabel *PriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, productIntroLabel.bottom+12, SCREEN_WIDTH-78, 0)];
    PriceLabel.textColor = GZGPriceColor;
    PriceLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    PriceLabel.numberOfLines = 1;
    PriceLabel.text = price;
    [PriceLabel sizeToFit];
    PriceLabel.width = SCREEN_WIDTH-78;
    [self addSubview:PriceLabel];
    
    //虚线
    UIImageView *xuxianImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-78, 20, 0.5, 95)];
    xuxianImg.image = [UIImage imageNamed:@"mine_profile_Line"];
    xuxianImg.clipsToBounds = YES;
    [self addSubview:xuxianImg];
    
    //用户评价
    UILabel *troLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 78, 20)];
    troLabel.text = @"用户评价";
    troLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightLight];
    troLabel.textAlignment = NSTextAlignmentCenter;
    troLabel.textColor = GZGPriceColor;
    troLabel.centerY = xuxianImg.centerY;
    troLabel.centerX = SCREEN_WIDTH-78/2;
    [self addSubview:troLabel];
    //评价数量
    UILabel *numSay = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 78, 20)];
    numSay.text = @"999+";
    numSay.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:26];//又粗又斜
    numSay.textAlignment = NSTextAlignmentCenter;
    numSay.textColor = GZGPriceColor;
    numSay.centerY = troLabel.centerY-25;
    numSay.centerX = troLabel.centerX;
    [self addSubview:numSay];

    //查看评价
    UIButton *look = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    look.centerY = troLabel.centerY+25;
    look.centerX = troLabel.centerX;
    [look setTitle:@"查看" forState:UIControlStateNormal];
    [look setTitleColor:GZGTextColor forState:UIControlStateNormal];
    look.titleLabel.font = [UIFont systemFontOfSize:12];
    look.layer.borderWidth = 0.5;
    look.layer.borderColor = RGBACOLOR(127, 127, 127, 1).CGColor;
    look.layer.cornerRadius = 2.0f;
    look.clipsToBounds = YES;
    [self addSubview:look];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, xuxianImg.bottom+20, self.width, 10)];
    lineView.backgroundColor = LYBgColor;
    [self addSubview:lineView];
    
    self.height = lineView.bottom;

}

@end
