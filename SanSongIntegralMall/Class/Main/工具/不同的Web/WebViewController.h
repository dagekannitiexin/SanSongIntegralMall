//
//  WebViewController.h
//  Shopping
//
//  Created by 林林尤达 on 2017/8/7.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

/** 地址 */
@property (strong,nonatomic) NSString *urlStr;

/** web */
@property (strong,nonatomic) UIWebView *web;
@end
