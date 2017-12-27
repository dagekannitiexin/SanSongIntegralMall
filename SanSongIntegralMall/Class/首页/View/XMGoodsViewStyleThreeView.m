//
//  XMGoodsViewStyleThreeView.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/4.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMGoodsViewStyleThreeView.h"

@implementation XMGoodsViewStyleThreeView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = RGBACOLOR(240, 240, 240, 1).CGColor;
}

@end
