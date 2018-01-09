//
//  XMMeAddressEmptyDetailPresent.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/19.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeAddressEmptyDetailPresent.h"
#import "XMMeAdressView.h"

@interface XMMeAddressEmptyDetailPresent (){
    UIImageView *_cricleImg;
}
@property (nonatomic, assign)BOOL isNomalAddress; //是否设置默认地址
@property (nonatomic, strong)XMMeAdressView *adressView;
@property (nonatomic, strong)XXTextView *textView;
@end

@implementation XMMeAddressEmptyDetailPresent

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fd_prefersNavigationBarHidden = NO;
    self.title = @"填写收货地址";
    
    [self creatnavigationbar];
    
    [self createAdressView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatnavigationbar
{
    //添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"Back Chevron"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"Back Helight"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftViewItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem =leftViewItem;
    
    
    UIButton *resavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
    [resavBtn setTitle:@"保存" forState:UIControlStateNormal];
    [resavBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    resavBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [resavBtn addTarget:self action:@selector(resaveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightViewItem = [[UIBarButtonItem alloc]initWithCustomView:resavBtn];
    self.navigationItem.rightBarButtonItem = rightViewItem;
}

- (void)createAdressView
{
    _adressView = [[NSBundle mainBundle]loadNibNamed:@"XMMeAdressView" owner:nil options:nil].lastObject;
    _adressView.origin = CGPointMake(0, 0);
    _adressView.width = SCREEN_WIDTH;
    [self.view addSubview:_adressView];
    
    _textView = [[XXTextView alloc]initWithFrame:CGRectMake(67, 150, SCREEN_WIDTH -70-15, 78)];
    _textView.xx_placeholder = @"详细地址";
    _textView.xx_placeholderColor = XMPalceHolderColor;
    _textView.xx_placeholderFont = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:_textView];
    
    //加入设置为默认收货地址
    UIView *setNomalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 135, 17)];
    setNomalView.backgroundColor = [UIColor clearColor];
    setNomalView.center = CGPointMake(self.view.centerX, _adressView.bottom+30);
    [self.view addSubview:setNomalView];
    
    _cricleImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 17, 17)];
    _cricleImg.image = [UIImage imageNamed:@"iconAddressCheckNormal"];
    [setNomalView addSubview:_cricleImg];
    
    UILabel *setNamal = [[UILabel alloc]initWithFrame:CGRectMake(_cricleImg.right+7, 0, 120, 17)];
    setNamal.text  = @"设为默认收货地址";
    setNamal.textColor = [UIColor blackColor];
    setNamal.font = [UIFont systemFontOfSize:14];
    [setNomalView addSubview:setNamal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nomalAddress)];
    [setNomalView addGestureRecognizer:tap];
    
}

#pragma mark - brnClick
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resaveBtnClick
{
    [self.view resignFirstResponder];
    NSLog(@"点击保存啦");
    if (!_adressView.name.text.length){
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setImageViewSize:CGSizeMake(0, 0)];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showInfoWithStatus:@"请填写姓名"];
        return;
    }
    if (!(_adressView.phone.text.length ==11)){
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setImageViewSize:CGSizeMake(0, 0)];
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showInfoWithStatus:@"请填写姓名"];
        return;
    }
    if (!_adressView.address.text.length){
        return;
    }
    if (!_adressView.address.text.length){
        return;
    }
    
}

- (void)nomalAddress
{
    if (self.isNomalAddress){
        _cricleImg.image = [UIImage imageNamed:@"iconAddressCheckNormal"];
        self.isNomalAddress = NO;
    }else {
        _cricleImg.image = [UIImage imageNamed:@"iconAddressCheckSelected"];
        self.isNomalAddress = YES;
    }
    
}
@end

