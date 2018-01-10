//
//  SSJFLoginView.h
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SSJFLoginView;

@protocol SSJFLoginViewDelegate <NSObject>

// 登录
- (void)keepNewFeatrueView:(nullable SSJFLoginView *)keepNewFeatrueView didLogin:(nullable UIButton *)loginButton;
// 注册
- (void)keepNewFeatrueView:(nullable SSJFLoginView *)keepNewFeatrueView didRegister:(nullable UIButton *)registerButton;

@end

typedef void (^loginBtn) (void);

@interface SSJFLoginView : UIView

@property (nonatomic ,copy) loginBtn _Nullable wechatLoginBtnBlock;
@property (nonatomic ,copy) loginBtn _Nullable qqLoginBtnBlock;
@property (nonatomic ,copy) loginBtn _Nullable weiboLoginBtnBlock;

@property (nonatomic, weak, nullable) id <SSJFLoginViewDelegate> delegate;

@end
