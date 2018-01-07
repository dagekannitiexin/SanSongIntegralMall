//
//  AppDelegate.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "XMTabBarController.h"
#import "JPUSHService.h"
#import "UIAlertView+Blocks.h"
#import "XMNavigationController.h"
#import "SSJFLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    // 设置窗口的根控制器
    [self setRootView];
    //****************************************************************************
    //提示框初始化
    [SVProgressHUD setCornerRadius:8.0];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setMinimumDismissTimeInterval:0.1f];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@""]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@""]];
    //********************************************************************
    
    
    //创建网络
    self.engine = [[RESTfulEngine alloc]initWithHostName:kBaseURL];
    
    //监控step状态
    [self addObserverAndNotification];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)addObserverAndNotification{
    [[ModelLocator sharedInstance] addObserver:self forKeyPath:@"step" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if(object ==[ModelLocator sharedInstance] && [keyPath isEqualToString:@"step"]){
        
        if([[ModelLocator sharedInstance].step isEqualToString:@"-1"]){
            
            NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
            NSDictionary *dictionary = [de dictionaryRepresentation];
            for(NSString* key in [dictionary allKeys]){
                [de removeObjectForKey:key];
                [de synchronize];
            }
            [JPUSHService setTags:nil aliasInbackground:@""];
        }
        else if ([[ModelLocator sharedInstance].step isEqualToString:@"-2"])
        {
            NSDictionary *dictionary = [USER_DEFAULT dictionaryRepresentation];
            for(NSString* key in [dictionary allKeys]){
                [USER_DEFAULT removeObjectForKey:key];
                [USER_DEFAULT synchronize];
            }
            [JPUSHService setTags:nil aliasInbackground:@""];
            
            [UIAlertView showAlertViewWithTitle:@"异常登录" message:@"您的帐号在其他设备上登录，为了您的帐号安全，请即时修改密码  ！" cancelButtonTitle:nil otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex) {
                
                UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
                UIViewController *topVC = appRootVC;
                if (topVC.presentedViewController) {
                    topVC = topVC.presentedViewController;
                    UINavigationController * nav =(UINavigationController*)topVC;
                    [nav dismissViewControllerAnimated:YES completion:nil];
                    
                }
                else
                {
                    SSJFLoginViewController *land = [[SSJFLoginViewController alloc]init];
                    XMNavigationController *nav = [[XMNavigationController alloc]initWithRootViewController:land];
                    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
                    
                }
                
            } onCancel:^{
                
            }];
            
        }
        else if ([[ModelLocator sharedInstance].step isEqualToString:@"1"])
        {
            //登陆状态
            
        }
        else if ([[ModelLocator sharedInstance].step isEqualToString:@"0"])
        {
            
            SSJFLoginViewController *land = [[SSJFLoginViewController alloc]init];
            XMNavigationController *nav = [[XMNavigationController alloc]initWithRootViewController:land];
            [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
            
        }
        else if ([[ModelLocator sharedInstance].step isEqualToString:@"2"])
        {
            //去更新
            
        }
    }
}

//切换
- (void)setRootView{
    if ([USER_TOKEN isEqualToString:@"(null)"]||USER_TOKEN==nil||[USER_TOKEN isEqualToString:@"(null)"]){
        [ModelLocator sharedInstance].step = @"0";//未登录
        [JPUSHService setTags:nil aliasInbackground:@""];//登录
        
        SSJFLoginViewController *land = [[SSJFLoginViewController alloc]init];
        XMNavigationController *nav = [[XMNavigationController alloc]initWithRootViewController:land];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }else {
        [ModelLocator sharedInstance].step = @"1";
        [JPUSHService setTags:nil aliasInbackground:[NSString stringWithFormat:@"%@",[USER_DEFAULT objectForKey:@"id"]]];//登录
        
        self.window.rootViewController = [[XMTabBarController alloc] init];
        [self.window makeKeyAndVisible];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
