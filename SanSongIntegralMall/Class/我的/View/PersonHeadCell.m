//
//  PersonHeadCell.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "PersonHeadCell.h"

@implementation PersonHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.IConBtn.layer.masksToBounds = YES;
    self.IConBtn.layer.cornerRadius = self.IConBtn.height/2;
    self.IConBtn.clipsToBounds = YES;
    self.IConBtn.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
