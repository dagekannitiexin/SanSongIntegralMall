//
//  DetailViewController.h
//  点看宁波
//
//  Created by wbq on 16/1/19.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 详情变化 */
@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *TextFiled;
@property(strong,nonatomic)NSString * Deatail;
@property (strong, nonatomic) IBOutlet UIView *TextView;

@end
