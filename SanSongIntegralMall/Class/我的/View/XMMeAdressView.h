//
//  XMMeAdressView.h
//  XuanMaoShopping
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXTextView.h"



@interface XMMeAdressView : UIView<UITextViewDelegate>

@property (nonatomic,strong) NSArray *selections; //!< 选择的三个下标
@property (nonatomic,copy) NSString *pushAddress; //!< 展示的地址

@property (weak, nonatomic) IBOutlet XXTextView *addressDetail;//详细地址

@property (weak, nonatomic) IBOutlet UITextField *address;//省市区县

@property (weak, nonatomic) IBOutlet UITextField *phone;//电话号码

@property (weak, nonatomic) IBOutlet UITextField *name; //姓名

@property (weak, nonatomic) IBOutlet UIView *tagVIew;

@end
