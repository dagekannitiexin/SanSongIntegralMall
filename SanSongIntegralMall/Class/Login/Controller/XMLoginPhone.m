//
//  XMLoginPhone.m
//  XuanMaoShopping
//
//  Created by apple on 2017/9/20.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMLoginPhone.h"
#import "XMLoginVerificationCode.h"

@interface XMLoginPhone ()<UITextFieldDelegate>

@property (nonatomic,strong)UIButton *nextBtn;
/*输入电话*/
@property (nonatomic,strong)UITextField *numTextField;
@end

@implementation XMLoginPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    //创建导航栏
    [self creatnavigationbar];
    
    [self initHomeView];
    
}

- (void)creatnavigationbar
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    //添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 31.5, 12.5, 21)];
    [backBtn setImage:[UIImage imageNamed:@"Back Chevron"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"Back Helight"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
}

- (void)initHomeView
{
    //填写你的手机号码
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 106, SCREEN_WIDTH, 23)];
    titleLabel.centerX = self.view.centerX;
    titleLabel.text = @"填写你的手机号";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:23];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //uitextfiled
    _numTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+65, 255, 30)];
    _numTextField.centerX = self.view.centerX;
    _numTextField.font = [UIFont systemFontOfSize:20];
    _numTextField.textAlignment = NSTextAlignmentCenter;
    _numTextField.textColor = [UIColor blackColor];
    _numTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    [_numTextField becomeFirstResponder];
    _numTextField.keyboardType = UIKeyboardTypePhonePad;
    _numTextField.delegate = self;
    [self.view addSubview:_numTextField];
    
    //设置底线
    //增加分界线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _numTextField.bottom+0.5, 255, 1)];
    lineView.centerX = self.view.centerX;
    lineView.backgroundColor = XMLowBottomLine;
    [self.view addSubview:lineView];
    
    //下一步按钮
    _nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, lineView.bottom+50, 60, 60)];
    _nextBtn.centerX = self.view.centerX;
    [_nextBtn setImage:[UIImage imageNamed:@"btnRedRoundDisable"] forState:UIControlStateDisabled];
    [_nextBtn setImage:[UIImage imageNamed:@"btnRedRoundNormal"] forState:UIControlStateNormal];
    _nextBtn.enabled = NO;
    [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
}

#pragma mark - brnClick
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)nextBtnClick
{

    
    //设置常用参数
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setValue:_numTextField.text forKey:@"telNumber"];
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/smartapi/api/Login/GetMessageCode"];
    [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"GET" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        if ([[aDictronaryBaseObjects objectForKey:@"ReFlag"]isEqualToString:@"1"])
        {
            XMLoginVerificationCode *vc = [[XMLoginVerificationCode alloc]init];
            [vc setNumberOfPhone:_numTextField.text setOpenId:self.openid];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } onError:^(NSError *engineError) {
        NSLog(@"no");
    }];
}
#pragma mark - uitextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length == 10){
        self.nextBtn.enabled = YES;
        return YES;
    }else if (textField.text.length >10){
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.nextBtn.enabled = NO;
    return YES;
}
@end
