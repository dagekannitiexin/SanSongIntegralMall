//
//  XMNavigationController.m
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/29.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMNavigationController.h"
#import "SSJFQuickNavgitonViewController.h" //功能快捷键

@interface XMNavigationController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate,CAAnimationDelegate>{
    int i;
}

@property(nonatomic,strong)SSJFQuickNavgitonViewController *AdfunVc;
@property(nonatomic,assign)BOOL IsShowTabbar;
@end

@implementation XMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 处理自定义导航控制器返回控件之后的返回手势失效
    self.interactivePopGestureRecognizer.delegate = self;
}

// 拦截所有push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if(self.childViewControllers.count > 0) { // 如果push进来的不是第一个则要设置统一的返回按钮
        // 隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"commoditydetail_detail_ic_back_2_nor"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackClick)];
    }else {
        [self addrightitem:viewController];
        
    }
    
    // 一定要在最后在执行父类的push操作, 这样让第一次的根控制器Push进来的时候childViewController为0, 并且让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}

// 返回事件
- (void)navigationBackClick {
    
    [self popViewControllerAnimated:YES];
}


#pragma maek - 快捷导航栏的动画效果
- (BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

+ (void)initialize {
    
    // 当导航栏使用MRNavigationControlelr时才设定改主题
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[XMNavigationController class]]];
    
    // 设置背景图片
    navigationBar.barTintColor = RGBACOLOR(250, 250, 250, 1);
//    navigationBar.backgroundColor = MRRedBg;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [navigationBar setTitleTextAttributes:attrs];
    [navigationBar setTintColor:RGBACOLOR(127, 127, 127, 1)];
    [navigationBar setTranslucent:NO];
    [navigationBar setShadowImage:[[UIImage alloc]init]];
}

-(void)addrightitem:(UIViewController *)viewController
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed: @"home_Black" ] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Additionalfunction:)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 18, 18);
    UIBarButtonItem* itembutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    viewController.navigationItem.rightBarButtonItem = itembutton;
}

-(void)Additionalfunction:(UIButton *)btn
{
    btn.userInteractionEnabled = NO;
    [self SetHidentabbarWithAnmation:btn];
    
}

-(void)SetHidentabbarWithAnmation:(UIButton*)btn
{
    
    if(!_IsShowTabbar)
    {
        
        [self AddRemoveAdfunView:btn];
        _IsShowTabbar = YES;
        
        
        
    }
    else
    {
        [self AddRemoveAdfunView:btn];
        _IsShowTabbar = NO;
        
        
    }
    
}

-(void)AddRemoveAdfunView:(UIButton*)btn
{
    if (i == 0) {
        CATransition *  tran=[CATransition animation];
        tran.type = @"rippleEffect";
        [self.view.layer addAnimation:tran forKey:@"kongyu"];
        _AdfunVc = [[SSJFQuickNavgitonViewController alloc]init];
        [self pushViewController: _AdfunVc animated:YES];
        tran.duration=0.7;
        tran.delegate=self;
        [self.view.layer addAnimation:tran forKey:@"ads"];
        i = 1;
        
    }
    else
    {
        CATransition *  tran=[CATransition animation];
        tran.type = @"rippleEffect";
        [self.view.layer addAnimation:tran forKey:@"kongyu"];
        [self popToRootViewControllerAnimated:YES];
        tran.duration=0.7;
        tran.delegate=self;
        [self.view.layer addAnimation:tran forKey:@"ads"];
        i = 0;
        
    }
    btn.userInteractionEnabled = YES;
}

-(void)pop
{
    if (i == 0) {
        CATransition *  tran=[CATransition animation];
        tran.type = @"rippleEffect";
        [self.view.layer addAnimation:tran forKey:@"kongyu"];
        _AdfunVc = [[SSJFQuickNavgitonViewController alloc]init];
        [self pushViewController: _AdfunVc animated:YES];
        tran.duration=0.7;
        tran.delegate=self;
        [self.view.layer addAnimation:tran forKey:@"ads"];
        i = 1;
        
    }
    else
    {
        CATransition *  tran=[CATransition animation];
        tran.type = @"rippleEffect";
        [self.view.layer addAnimation:tran forKey:@"kongyu"];
        [self popToRootViewControllerAnimated:YES];
        tran.duration=0.7;
        tran.delegate=self;
        [self.view.layer addAnimation:tran forKey:@"ads"];
        i = 0;
    }
    
}

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return self.childViewControllers.count > 1;
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDefault;
//}

@end
