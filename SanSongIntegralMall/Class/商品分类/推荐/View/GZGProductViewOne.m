//
//  GZGProductViewOne.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/2/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GZGProductViewOne.h"
#import "UIImageView+WebCache.h"

@interface GZGProductViewOne()
@property (nonatomic ,strong)UIImageView *headImg;
@property (nonatomic ,strong)UILabel *nameLabel;
@property (nonatomic ,strong)UILabel *priceLabel;
@end

@implementation GZGProductViewOne

- (void)setHeadImgString:(NSString *)headImgString
{
    if (!_headImgString){
        _headImgString = headImgString;
    }
}

- (void)setNameLabelString:(NSString *)nameLabelString
{
    if (!_nameLabelString){
        _nameLabelString = nameLabelString;
    }
}

//在设置完最后一个属性
- (void)setPriceLabelString:(NSString *)priceLabelString
{
    if (!_priceLabelString){
        _priceLabelString = priceLabelString;
        //frame 随着屏幕大小变化
        [self initView];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shopSelect)];
        [self addGestureRecognizer:tap];
    }
    return self;
    
}

/*
 点击进入商品详细
 */
- (void)shopSelect
{
    if (self.selectDetailBlock){
        
        self.selectDetailBlock();
    }
}

- (void)initView
{
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    NSString *urlString = _headImgString;
    urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    [_headImg sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"Img_default"]];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self addSubview:_headImg];
    
    _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, _headImg.bottom+8, self.width, 38)];
    _nameLabel.numberOfLines = 2;
    //设置字间距
    NSDictionary *dic = @{NSKernAttributeName:@1.f
                          };
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:_nameLabelString attributes:nil];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4.0f];//行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_nameLabelString length])];
    [_nameLabel setAttributedText:attributedString];
    _nameLabel.textColor = GZGTextColor;
    _nameLabel.font = [UIFont systemFontOfSize:13];
    [_nameLabel sizeToFit];
    [self addSubview:_nameLabel];
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _nameLabel.bottom+5, self.width, 17)];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.numberOfLines = 1;
    _priceLabel.text = _priceLabelString;
    _priceLabel.textColor = GZGPriceColor;
    [self addSubview:_priceLabel];
    
}
@end
