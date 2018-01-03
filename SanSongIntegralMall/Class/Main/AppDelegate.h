//
//  AppDelegate.h
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTfulEngine.h"
#define SSJF_AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** 后台连接管理*/
@property (strong, nonatomic) RESTfulEngine *engine;
- (void)setRootView;
@end

