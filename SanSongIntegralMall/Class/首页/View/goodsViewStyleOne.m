//
//  goodsViewStyleOne.m
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/30.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "goodsViewStyleOne.h"

@implementation goodsViewStyleOne

- (void)awakeFromNib
{
    [super awakeFromNib];
    //设置边角
    self.layer.cornerRadius = 5;
    //设置背景颜色
    self.backgroundColor = XMBgColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shopSelect)];
    [self addGestureRecognizer:tap];
    
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


@end
