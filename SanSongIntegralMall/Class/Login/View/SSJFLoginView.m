//
//  SSJFLoginView.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFLoginView.h"

@interface SSJFLoginView()

@property (nonatomic, strong) UIImageView *imageView; //图标
@property (nonatomic, strong) UIButton *registerButton; //注册按钮
@property (nonatomic, strong) UIButton *loginButton; //登录按钮

@property (nonatomic, strong) UIButton *wechatButton; //微信登录按钮
@property (nonatomic, strong) UIButton *QQButton; //QQ登录按钮
@property (nonatomic, strong) UIButton *weiboButton; //微博登录按钮
@end

@implementation SSJFLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imageView];
        [self addSubview:self.registerButton];
        [self addSubview:self.loginButton];
        [self addSubview:self.wechatButton];
        [self addSubview:self.QQButton];
        [self addSubview:self.weiboButton];
        
    }
    return self;
}

#pragma mark - delegateSettting
- (void)registerClick:(UIButton *)registerButton
{
    if ([self.delegate respondsToSelector:@selector(keepNewFeatrueView:didRegister:)]) {
        [self.delegate keepNewFeatrueView:self didRegister:registerButton];
    }
}

- (void)login:(UIButton *)loginButton
{
    if ([self.delegate respondsToSelector:@selector(keepNewFeatrueView:didLogin:)]) {
        [self.delegate keepNewFeatrueView:self didLogin:loginButton];
    }
}

#pragma mark - setter and getter
- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImage *image = [UIImage imageNamed:@"proncessGoIcon"];
        _imageView = [[UIImageView alloc] initWithImage:image];
        CGFloat X = ([UIScreen mainScreen].bounds.size.width - image.size.width) * 0.5;
        CGFloat Y = [UIScreen mainScreen].bounds.size.height * 0.15;
        _imageView.frame = CGRectMake(X, Y, image.size.width, image.size.height);
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = 18;
        CGFloat X = margin;
        CGFloat H = 45;
        CGFloat W = ([UIScreen mainScreen].bounds.size.width - 3 * margin) * 0.5;
        CGFloat Y = [UIScreen mainScreen].bounds.size.height - H - 80;

        _loginButton.frame = CGRectMake(X, Y, W, H);
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor whiteColor]];
        [_loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setBackgroundColor:RGBACOLOR(255, 255, 255, 0.3)];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        _loginButton.layer.cornerRadius = 20.0f;
        
    }
    return _loginButton;
}

- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = 18;
        CGFloat X = CGRectGetMaxX(self.loginButton.frame) + margin;
        CGFloat H = 45;
        CGFloat W = ([UIScreen mainScreen].bounds.size.width - 3 * margin) * 0.5;
        CGFloat Y = [UIScreen mainScreen].bounds.size.height - H - 80;
        _registerButton.frame = CGRectMake(X, Y, W, H);
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
        [_registerButton setBackgroundColor:[UIColor whiteColor]];
        [_registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_registerButton addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.layer.cornerRadius = 20.0f;
        _registerButton.alpha = 1;
    }
    return _registerButton;
}

- (UIButton *)wechatButton
{
    if (!_wechatButton) {
        _wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = (SCREEN_WIDTH - 3*60)/4;
        CGFloat W = 60;
        CGFloat H = 20;
        _wechatButton.frame = CGRectMake(margin, SCREEN_HEIGHT-30-20, W, H);
        [_wechatButton setTitle:@"微信" forState:UIControlStateNormal];
        [_wechatButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _wechatButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_wechatButton setImage:[UIImage imageNamed:@"auth_wechat"] forState:UIControlStateNormal];
        _weiboButton.tag = 101;
        [_weiboButton addTarget:self action:@selector(loginBtnChoose:) forControlEvents:UIControlEventTouchUpInside];
        _wechatButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    }
    return _wechatButton;
}

- (UIButton *)QQButton
{
    if (!_QQButton) {
        _QQButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = (SCREEN_WIDTH - 3*60)/4;
        CGFloat W = 60;
        CGFloat H = 20;
        _QQButton.frame = CGRectMake(_wechatButton.right+margin, SCREEN_HEIGHT-30-20, W, H);
        [_QQButton setTitle:@"QQ" forState:UIControlStateNormal];
        [_QQButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _QQButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_QQButton setImage:[UIImage imageNamed:@"auth_QQ"] forState:UIControlStateNormal];
        _QQButton.tag = 102;
        [_QQButton addTarget:self action:@selector(loginBtnChoose:) forControlEvents:UIControlEventTouchUpInside];
        _QQButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    }
    return _QQButton;
}

- (UIButton *)weiboButton
{
    if (!_weiboButton) {
        _weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat margin = (SCREEN_WIDTH - 3*60)/4;
        CGFloat W = 60;
        CGFloat H = 20;
        _weiboButton.frame = CGRectMake(_QQButton.right+margin, SCREEN_HEIGHT-30-20, W, H);
        [_weiboButton setTitle:@"微博" forState:UIControlStateNormal];
        [_weiboButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _weiboButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_weiboButton setImage:[UIImage imageNamed:@"auth_weibo"] forState:UIControlStateNormal];
        _weiboButton.tag = 103;
        [_weiboButton addTarget:self action:@selector(loginBtnChoose:) forControlEvents:UIControlEventTouchUpInside];
        _weiboButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0);
    }
    return _weiboButton;
}

- (void)loginBtnChoose:(UIButton *)sender
{
    if (sender.tag == 101){
        if (self.wechatLoginBtnBlock)
        {
            self.wechatLoginBtnBlock();
        }
    }else if (sender.tag == 102){
        if (self.qqLoginBtnBlock)
        {
            self.qqLoginBtnBlock();
        }
    }else if (sender.tag ==103){
        if (self.weiboLoginBtnBlock)
        {
            self.weiboLoginBtnBlock();
        }
    }
}
@end
