//
//  SSJFLoginViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFLoginViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SSJFLoginView.h"
#import "XMLoginPhone.h"
#import <UMSocialCore/UMSocialCore.h>

@interface SSJFLoginViewController ()<SSJFLoginViewDelegate>{
    
}

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;

@property (nonatomic, strong) SSJFLoginView *loginView;

@end

@implementation SSJFLoginViewController

- (void)dealloc
{
    NSLog(@"登录控制器释放");
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"LaunchTour" ofType:@"mp4"];
    
    self.moviePlayerController.contentURL = [[NSURL alloc] initFileURLWithPath:moviePath];
    
    [self.moviePlayerController play];
    [self.moviePlayerController.view bringSubviewToFront:self.loginView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.moviePlayerController stop];
    self.moviePlayerController = nil;
    self.loginView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    
}

#pragma mark - NSNotificationCenter
- (void)playbackStateChanged
{
    MPMoviePlaybackState playbackState = [self.moviePlayerController playbackState];
//    if (playbackState == MPMoviePlaybackStateStopped || playbackState == MPMoviePlaybackStatePaused) {
//        [self.moviePlayerController play];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - setter and getter
- (MPMoviePlayerController *)moviePlayerController
{
    if (!_moviePlayerController) {
        _moviePlayerController = [[MPMoviePlayerController alloc] init];
        _moviePlayerController.movieSourceType = MPMovieSourceTypeFile;
        _moviePlayerController.controlStyle = MPMovieControlStyleNone;
        _moviePlayerController.view.frame = [UIScreen mainScreen].bounds;
        [_moviePlayerController setFullscreen:YES];
        [_moviePlayerController setShouldAutoplay:YES];
        [_moviePlayerController setRepeatMode:MPMovieRepeatModeOne];
        [self.view addSubview:self.moviePlayerController.view];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
    }
    return _moviePlayerController;
}

- (SSJFLoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[SSJFLoginView alloc] init];
        _loginView.delegate = self;
        _loginView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        __block SSJFLoginViewController *blockSelf = self;
        _loginView.wechatLoginBtnBlock = ^{
            [blockSelf loginWay:[@"1001" intValue]];
        };
        _loginView.qqLoginBtnBlock = ^{
            [blockSelf loginWay:[@"1002" intValue]];
        };
        _loginView.weiboLoginBtnBlock = ^{
            [blockSelf loginWay:[@"1003" intValue]];
        };
        [self.moviePlayerController.view addSubview:_loginView];
    }
    return _loginView;
}

#pragma mark - KeepNewFeatrueViewDelegate
// 登录
- (void)keepNewFeatrueView:(nullable SSJFLoginView *)keepNewFeatrueView didLogin:(nullable UIButton *)loginButton
{
    NSLog(@"登录");
    XMLoginPhone *login = [[XMLoginPhone alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}
// 注册
- (void)keepNewFeatrueView:(nullable SSJFLoginView *)keepNewFeatrueView didRegister:(nullable UIButton *)registerButton
{
    NSLog(@"注册");
    XMLoginPhone *login = [[XMLoginPhone alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}

- (void)loginWay:(NSInteger)choose
{
    switch (choose) {
        case 1001:
        {
            NSLog(@"使用微信登录");
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    //1 授权信息
                    NSLog(@"Wechat uid: %@", resp.uid);
                    NSLog(@"Wechat openid: %@", resp.openid);
                    NSLog(@"Wechat unionid: %@", resp.unionId);
                    NSLog(@"Wechat accessToken: %@", resp.accessToken);
                    NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
                    NSLog(@"Wechat expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"Wechat name: %@", resp.name);
                    NSLog(@"Wechat iconurl: %@", resp.iconurl);
                    NSLog(@"Wechat gender: %@", resp.unionGender);
                    
                    NSNumber *sex = [NSNumber new];
                    if ([resp.unionGender isEqualToString:@"男"]){
                        sex = [NSNumber numberWithInteger:1];
                    }else {
                        sex = [NSNumber numberWithInteger:0];
                    }
                    
                    // 第三方平台SDK源数据
                    NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
                    
                    //统一调用一个方法
                    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
                    [requestInfo setValue:resp.uid forKey:@"ThirdID"];
                    [requestInfo setValue:@"1" forKey:@"ThirdType"];
                    [requestInfo setValue:resp.accessToken forKey:@"Unionid"];
                    [requestInfo setValue:resp.name forKey:@"Nickname"];
                    [requestInfo setValue:sex forKey:@"Sex"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"province"] forKey:@"Province"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"city"] forKey:@"City"];
                    [requestInfo setValue:@"中国" forKey:@"Country"];
                    [requestInfo setValue:resp.iconurl forKey:@"HeadImageUrl"];
                    [requestInfo setValue:nil forKey:@"Privilege"];
                    [self postInfo:requestInfo LoginType:@"微信"];
                }
            }];
        }
            break;
        case 1002:
        {
            NSLog(@"使用QQ登录");
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    // 授权信息
                    NSLog(@"QQ uid: %@", resp.uid);
                    NSLog(@"QQ openid: %@", resp.openid);
                    NSLog(@"QQ unionid: %@", resp.unionId);
                    NSLog(@"QQ accessToken: %@", resp.accessToken);
                    NSLog(@"QQ expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"QQ name: %@", resp.name);
                    NSLog(@"QQ iconurl: %@", resp.iconurl);
                    NSLog(@"QQ gender: %@", resp.unionGender);
                    NSNumber *sex = [NSNumber new];
                    if ([resp.unionGender isEqualToString:@"男"]){
                        sex = [NSNumber numberWithInteger:1];
                    }else {
                        sex = [NSNumber numberWithInteger:0];
                    }
                    // 第三方平台SDK源数据
                    NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                    //统一调用一个方法
                    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
                    [requestInfo setValue:resp.uid forKey:@"ThirdID"];
                    [requestInfo setValue:@"3" forKey:@"ThirdType"];
                    [requestInfo setValue:resp.accessToken forKey:@"Unionid"];
                    [requestInfo setValue:resp.name forKey:@"Nickname"];
                    [requestInfo setValue:sex forKey:@"Sex"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"province"] forKey:@"Province"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"city"] forKey:@"City"];
                    [requestInfo setValue:@"中国" forKey:@"Country"];
                    [requestInfo setValue:resp.iconurl forKey:@"HeadImageUrl"];
                    [requestInfo setValue:nil forKey:@"Privilege"];
                    [self postInfo:requestInfo LoginType:@"QQ"];
                }
            }];
        }
            break;
        case 1003:
        {
            NSLog(@"使用微博登录");
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    // 授权信息
                    NSLog(@"Sina uid: %@", resp.uid);
                    NSLog(@"Sina accessToken: %@", resp.accessToken);
                    NSLog(@"Sina refreshToken: %@", resp.refreshToken);
                    NSLog(@"Sina expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"Sina name: %@", resp.name);
                    NSLog(@"Sina iconurl: %@", resp.iconurl);
                    NSLog(@"Sina gender: %@", resp.unionGender);
                    NSNumber *sex = [NSNumber new];
                    if ([resp.unionGender isEqualToString:@"男"]){
                        sex = [NSNumber numberWithInteger:1];
                    }else {
                        sex = [NSNumber numberWithInteger:0];
                    }
                    // 第三方平台SDK源数据
                    NSLog(@"Sina originalResponse: %@", resp.originalResponse);
                    //统一调用一个方法
                    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
                    [requestInfo setValue:resp.uid forKey:@"ThirdID"];
                    [requestInfo setValue:@"2" forKey:@"ThirdType"];
                    [requestInfo setValue:resp.accessToken forKey:@"Unionid"];
                    [requestInfo setValue:resp.name forKey:@"Nickname"];
                    [requestInfo setValue:sex forKey:@"Sex"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"province"] forKey:@"Province"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"city"] forKey:@"City"];
                    [requestInfo setValue:@"中国" forKey:@"Country"];
                    [requestInfo setValue:resp.iconurl forKey:@"HeadImageUrl"];
                    [requestInfo setValue:nil forKey:@"Privilege"];
                    [self postInfo:requestInfo LoginType:@"新浪"];
                    
                }
            }];
        }
            break;
        default:
            break;
}
}

/*
 上传用户信息
 */
- (void)postInfo:(NSMutableDictionary *)resp LoginType:(NSString*)type{
    
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/Login/LoginByThird"];
    [SSJF_AppDelegate.engine sendRequesttoSSJF:resp portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        NSString *reflag = [aDictronaryBaseObjects objectForKey:@"ReFlag"];
        NSDictionary *rdt = [aDictronaryBaseObjects objectForKey:@"Rdt"];
        if ([reflag isEqualToString:@"1"]){
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            NSDictionary *data = [rdt objectForKey:@"ReData"];
            NSUserDefaults * de =[NSUserDefaults standardUserDefaults];
            [de setObject:[data objectForKey:@"token"] forKey:@"token"];
            [de synchronize];
            [ModelLocator sharedInstance].step = @"1";
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [SSJF_AppDelegate setRootView];
        }else {
            [SVProgressHUD showInfoWithStatus:[rdt objectForKey:@"ErrorMessage"]];
        }
    } onError:^(NSError *engineError) {
        [SVProgressHUD showErrorWithStatus:@"登录失败请检查网络"];
    }];
}
@end
