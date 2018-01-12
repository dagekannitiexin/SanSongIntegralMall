//
//  SSJFAdressCell.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SSJFAdressCell.h"

@implementation SSJFAdressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.width =SCREEN_WIDTH;
    [self.setBtn addTarget:self action:@selector(chooseUpDate) forControlEvents:UIControlEventTouchUpInside];
}

- (void)chooseUpDate
{
    if (self.upDateBtnBlock){
        self.upDateBtnBlock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
