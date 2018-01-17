//
//  XMMeCellStyleOne.h
//  XuanMaoShopping
//
//  Created by apple on 17/9/7.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMMeCellStyleOne : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/*
 iconImg
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

/*
 只有一些特殊cell有
 */
@property (weak, nonatomic) IBOutlet UILabel *detailfootLabel;


@end
