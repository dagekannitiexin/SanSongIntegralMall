//
//  SSJFGetIntegralFromCommodity.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SSJFGetIntegralFromCommodity.h"
#import "QQLBXScanViewController.h"
#import "Global.h"
#import "StyleDIY.h"
#import "SSJFInPutsixteenNum.h"

@interface SSJFGetIntegralFromCommodity ()

@property (nonatomic ,strong)UIImageView *proncessGoIcon;
@property (nonatomic ,strong)UIButton    *sweepQrCode;
@property (nonatomic ,strong)UIButton    *manuallyEnter;
@end

@implementation SSJFGetIntegralFromCommodity

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = NO;
    self.title = @"获取商品积分";
    [self createBackView];//背景板
    [self addChoseeBtn];//加入按钮
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createBackView
{
    UIImageView *imView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH/3*2)];
    imView.image = [UIImage imageNamed:@"getIntergrolBg"];
    imView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imView];
    
    self.proncessGoIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, imView.bottom+20, SCREEN_WIDTH/3, SCREEN_WIDTH/15*3)];
    self.proncessGoIcon.centerX = self.view.width/2;
    self.proncessGoIcon.image = [UIImage imageNamed:@"proncessGoIcon"];
    [self.view addSubview:self.proncessGoIcon];
}

- (void)addChoseeBtn
{
    _sweepQrCode = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat margin = 40;
    CGFloat X = margin;
    CGFloat H = 50;
    CGFloat W = ([UIScreen mainScreen].bounds.size.width - 2 * margin);
    CGFloat Y = _proncessGoIcon.bottom +15;
    
    _sweepQrCode.frame = CGRectMake(X, Y, W, H);
    [_sweepQrCode setTitle:@"扫码加分" forState:UIControlStateNormal];
    [_sweepQrCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_sweepQrCode setBackgroundColor:RGBACOLOR(246, 206, 205, 1)];
    [_sweepQrCode addTarget:self action:@selector(sweepQrCodeClick) forControlEvents:UIControlEventTouchUpInside];
    _sweepQrCode.titleLabel.font = [UIFont systemFontOfSize:18];
    _sweepQrCode.titleLabel.textAlignment = NSTextAlignmentCenter;
    _sweepQrCode.layer.cornerRadius = 25.0f;
    [self.view addSubview:_sweepQrCode];
    
    _manuallyEnter = [UIButton buttonWithType:UIButtonTypeCustom];
    _manuallyEnter.frame = CGRectMake(X, _sweepQrCode.bottom+20, W, H);
    [_manuallyEnter setTitle:@"手动输入" forState:UIControlStateNormal];
    [_manuallyEnter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_manuallyEnter setBackgroundColor:[UIColor whiteColor]];
    [_manuallyEnter addTarget:self action:@selector(manuallyEnterClick) forControlEvents:UIControlEventTouchUpInside];
    _manuallyEnter.layer.borderWidth = 2.0;
    _manuallyEnter.layer.borderColor = RGBACOLOR(142, 142, 142, 1).CGColor;
    _manuallyEnter.titleLabel.font = [UIFont systemFontOfSize:18];
    _manuallyEnter.titleLabel.textAlignment = NSTextAlignmentCenter;
    _manuallyEnter.layer.cornerRadius = 25.0f;
    [self.view addSubview:_manuallyEnter];
}

/*
 扫描二维码
 */
- (void)sweepQrCodeClick
{
        //添加一些扫码或相册结果处理
        QQLBXScanViewController *vc = [QQLBXScanViewController new];
        vc.libraryType = [Global sharedManager].libraryType;
        vc.scanCodeType = [Global sharedManager].scanCodeType;
    
        vc.style = [StyleDIY qqStyle];
    
        //镜头拉远拉近功能
        vc.isVideoZoom = YES;
        [self.navigationController pushViewController:vc animated:YES];
}

/*
 手动输入
 */
- (void)manuallyEnterClick
{
    SSJFInPutsixteenNum *VC = [[SSJFInPutsixteenNum alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
@end
