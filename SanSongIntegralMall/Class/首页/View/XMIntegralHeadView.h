//
//  XMIntegralHeadView.h
//  XuanMaoShopping
//
//  Created by apple on 2017/11/7.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMIntegralHeadView : UIView
/*背景色*/
@property (weak, nonatomic) IBOutlet UIImageView *backImg;

/*积分*/
@property (weak, nonatomic) IBOutlet UILabel *interalNum;

/*签到按钮*/
@property (weak, nonatomic) IBOutlet UIButton *qiandao;

/*标语*/
@property (weak, nonatomic) IBOutlet UILabel *dayTitle;

@end
