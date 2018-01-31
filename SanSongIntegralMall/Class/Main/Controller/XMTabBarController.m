//
//  XMTabBarController.m
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/29.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMTabBarController.h"
#import "XMNavigationController.h"
#import "SSJFHomeViewController.h"
#import "SSJFLeisureFunViewController.h"
#import "SSJFClassification.h"
#import "SSJFMineViewController.h"
#import "SignPresentingAnimator.h"
#import "SignDismissingAnimator.h"

@interface XMTabBarController ()<UITabBarDelegate,UIViewControllerTransitioningDelegate>

@end

@implementation XMTabBarController
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [SignPresentingAnimator new];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [SignDismissingAnimator new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    [self addChildController:[[SSJFHomeViewController alloc]init] imageName:@"commoditydetail_ic_details_home_black" selectedImage:@"commoditydetail_ic_details_home_black_pressed" title:@"首页"];
    
    [self addChildController:[[SSJFLeisureFunViewController alloc]init] imageName:@"homepage_ic_menu_topic_nor" selectedImage:@"homepage_ic_menu_topic_pressed" title:@"闲趣"];

    [self addChildController:[[SSJFClassification alloc]init] imageName:@"homepage_ic_menu_sort_nor" selectedImage:@"homepage_ic_menu_sort_pressed" title:@"分类"];
    
    [self addChildController:[[SSJFMineViewController alloc]init] imageName:@"homepage_ic_menu_me_nor" selectedImage:@"homepage_ic_menu_me_pressed" title:@"个人"];

    
}

/**
 *	@brief	设置TabBarItem主题
 */

+ (void)initialize {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = MRGlobalBg;
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

/**
 *	@brief	添加子控制器
 *
 *	@param 	childVC 	子控制期器
 *	@param 	image 	默认图片
 *	@param 	selectedImage 	选中图片
 *	@param 	title 	标题
 */
- (void)addChildController:(UIViewController *)childVC imageName:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    // 设置文字和图片
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage mr_imageOriginalWithName:image];
    childVC.tabBarItem.selectedImage = [UIImage mr_imageOriginalWithName:selectedImage];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBACOLOR(181, 38, 45, 1)} forState:UIControlStateSelected];     
    // 包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    XMNavigationController *nav = [[XMNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
