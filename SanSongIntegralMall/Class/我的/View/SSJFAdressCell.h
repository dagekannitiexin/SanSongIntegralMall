//
//  SSJFAdressCell.h
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/12.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^upDateBtn) (void);

@interface SSJFAdressCell : UITableViewCell

@property (nonatomic ,copy) upDateBtn upDateBtnBlock;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *adressDetail;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UIImageView *isDefault;
@property (nonatomic ,assign)BOOL isChosse;
@end
