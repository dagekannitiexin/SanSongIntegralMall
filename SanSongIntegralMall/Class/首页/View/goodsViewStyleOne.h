//
//  goodsViewStyleOne.h
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/30.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectDetail) (void);
@interface goodsViewStyleOne : UIView
@property (nonatomic ,copy) selectDetail selectDetailBlock;
@property (weak, nonatomic) IBOutlet UILabel *ProductName;
@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UIImageView *Imageurl;

@end
