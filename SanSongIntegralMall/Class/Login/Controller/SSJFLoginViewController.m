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

@interface SSJFLoginViewController ()<SSJFLoginViewDelegate>{
    
}

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;

@property (nonatomic, strong) SSJFLoginView *loginView;

@end

@implementation SSJFLoginViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"LaunchTour" ofType:@"mp4"];
    
    self.moviePlayerController.contentURL = [[NSURL alloc] initFileURLWithPath:moviePath];
    
    [self.moviePlayerController play];
//    [self.view addSubview:self.moviePlayerController.view];
    [self.moviePlayerController.view bringSubviewToFront:self.loginView];
}

#pragma mark - NSNotificationCenter
- (void)playbackStateChanged
{
    MPMoviePlaybackState playbackState = [self.moviePlayerController playbackState];
    if (playbackState == MPMoviePlaybackStateStopped || playbackState == MPMoviePlaybackStatePaused) {
        [self.moviePlayerController play];
    }
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
@end
