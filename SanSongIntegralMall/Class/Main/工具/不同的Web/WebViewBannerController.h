//
//  WebViewBannerController.h
//  XuanMaoShopping
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewBannerController : UIViewController<UIWebViewDelegate>

/** 地址 */
@property (strong,nonatomic) NSString *urlStr;

/** web */
@property (strong,nonatomic) UIWebView *web;

@end
