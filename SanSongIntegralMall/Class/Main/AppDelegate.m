//
//  AppDelegate.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "XMTabBarController.h"
#import "UIAlertView+Blocks.h"
#import "XMNavigationController.h"
#import "SSJFLoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#define USHARE_DEMO_APPKEY  @"5a5338158f4a9d64710000ab"
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
    
    //UM设置
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:USHARE_DEMO_APPKEY];
    
    [self configUSharePlatforms];
    
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
//            [JPUSHService setTags:nil aliasInbackground:@""];
        }
        else if ([[ModelLocator sharedInstance].step isEqualToString:@"-2"])
        {
            NSDictionary *dictionary = [USER_DEFAULT dictionaryRepresentation];
            for(NSString* key in [dictionary allKeys]){
                [USER_DEFAULT removeObjectForKey:key];
                [USER_DEFAULT synchronize];
            }
//            [JPUSHService setTags:nil aliasInbackground:@""];
            
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
//        [JPUSHService setTags:nil aliasInbackground:@""];//登录
        
        SSJFLoginViewController *land = [[SSJFLoginViewController alloc]init];
        XMNavigationController *nav = [[XMNavigationController alloc]initWithRootViewController:land];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }else {
        [ModelLocator sharedInstance].step = @"1";
//        [JPUSHService setTags:nil aliasInbackground:[NSString stringWithFormat:@"%@",[USER_DEFAULT objectForKey:@"id"]]];//登录
        
        self.window.rootViewController = [[XMTabBarController alloc] init];
        [self.window makeKeyAndVisible];
    }
    
}

/* um设置*/
- (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdfe30886341374ad" appSecret:@"b65ee69946fce8de5a516f40946a90ec" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106534712"/*设置QQ平台的appID*/  appSecret:@"dXmYsvYfPjrVpLPs" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     https://sns.whalecloud.com/sina2/callback
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"4027029158"  appSecret:@"7bb2b03fcad981b6491b443ae4e5164b" redirectURL:@"http://www.weibo.com"];
    
}

/* 回调*/
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
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
