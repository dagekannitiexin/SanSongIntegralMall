//
//  SSJFBindingViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SSJFBindingViewController.h"

@interface SSJFBindingViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UITextField *number;
@property (nonatomic, strong)UITextField *code;
@property (nonatomic, strong)UIButton *verificationCodeBtn;
@property (nonatomic, strong)UIButton *tureBtn;
/** 计时器 */
@property (nonatomic, strong) NSTimer  *timer;
@property (nonatomic, assign) NSInteger timeInt;
@end

@implementation SSJFBindingViewController

- (void)dealloc
{
    NSLog(@"绑定手机控制器销毁了");
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 关闭定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机号码";
    [self initView];
    [self turesBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView
{
    UIView *bgViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 55)];
    bgViewOne.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgViewOne];
    
    _number = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30-100, 20)];
    _number.font = [UIFont systemFontOfSize:14];
    _number.textAlignment = NSTextAlignmentLeft;
    _number.textColor = [UIColor blackColor];
    _number.clearButtonMode=UITextFieldViewModeWhileEditing;
    _number.placeholder = @"请输入手机号";
    [_number becomeFirstResponder];
    _number.keyboardType = UIKeyboardTypePhonePad;
    _number.delegate = self;
    _number.centerY = bgViewOne.height/2;
    [bgViewOne addSubview:_number];
    
    _verificationCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-15-100, 0, 100, 35)];
    _verificationCodeBtn.tag = 101;
    _verificationCodeBtn.centerY = bgViewOne.height/2;
    [_verificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateDisabled];
    [_verificationCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_verificationCodeBtn setTitleColor:RGBACOLOR(204, 204, 204, 1) forState:UIControlStateDisabled];
    _verificationCodeBtn.layer.borderWidth = 1;
    _verificationCodeBtn.layer.borderColor = RGBACOLOR(204, 204, 204, 1).CGColor;
    _verificationCodeBtn.layer.cornerRadius = 3.0;
    _verificationCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_verificationCodeBtn addTarget:self action:@selector(getVerification) forControlEvents:UIControlEventTouchUpInside];
    _verificationCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _verificationCodeBtn.enabled = NO;
    
    [bgViewOne addSubview:_verificationCodeBtn];
    
    
    //增加分界线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH-15, 1)];
    lineView.backgroundColor = RGBACOLOR(217, 217, 217, 0.33);
    [bgViewOne addSubview:lineView];
    
    UIView *bgViewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, bgViewOne.bottom, SCREEN_WIDTH, 55)];
    bgViewTwo.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgViewTwo];
    
    _code = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 20)];
    _code.tag = 102;
    _code.font = [UIFont systemFontOfSize:14];
    _code.textAlignment = NSTextAlignmentLeft;
    _code.textColor = [UIColor blackColor];
    _code.clearButtonMode=UITextFieldViewModeWhileEditing;
    _code.placeholder = @"请输入验证码";
    _code.keyboardType = UIKeyboardTypePhonePad;
    _code.delegate = self;
    _code.centerY = bgViewTwo.height/2;
    [bgViewTwo addSubview:_code];
    
    //增加分界线
    UIView *lineViewTwo = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH-15, 1)];
    lineViewTwo.backgroundColor = RGBACOLOR(217, 217, 217, 0.33);
    [bgViewTwo addSubview:lineViewTwo];
}

- (void)turesBtn
{
    _tureBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 110+45+64, SCREEN_WIDTH-30, 50)];
    _tureBtn.centerX = SCREEN_WIDTH/2;
    [_tureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_tureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tureBtn setTitleColor:RGBACOLOR(255, 255, 255, 0.3) forState:UIControlStateDisabled];
    [_tureBtn setBackgroundColor:RGBACOLOR(166, 53, 51, 1)];
    _tureBtn.layer.cornerRadius = 4.0;
    _tureBtn.enabled = NO;
    [_tureBtn addTarget:self action:@selector(tureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tureBtn];
}

#pragma mark - uitextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = [NSString stringWithFormat:@"%@%@",textField.text,string];
    if (text.length >0){
        //处于编辑状态下 按钮就可以点击了
        _tureBtn.enabled = YES;
    }
    
    if (text.length ==11){
        _verificationCodeBtn.enabled = YES;
    }else if (text.length >11){
        return NO;
    }
    return YES;
}

/*倒计时*/
- (void)createTimer
{
    // 计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(loadTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)loadTimerAction
{
    _timeInt --;
    if (_timeInt>0){
        self.verificationCodeBtn.titleLabel.text = [NSString stringWithFormat:@"%lds",(long)_timeInt];
    }else {
        // 关闭定时器
        [self.timer invalidate];
        self.timer = nil;
        // 显示按钮 隐藏倒计时label 重置时间 60s
        self.verificationCodeBtn.enabled = YES;
        self.verificationCodeBtn.titleLabel.text = [NSString stringWithFormat:@"获取验证码"];
    }
    
}

/*
 获取验证码
 */
- (void)getVerification
{
    //设置常用参数
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setValue:_number.text forKey:@"telNumber"];
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/Login/GetMessageCode"];
    [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"GET" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        if ([[aDictronaryBaseObjects objectForKey:@"ReFlag"]isEqualToString:@"1"])
        {
            _timeInt = 60;
            _verificationCodeBtn.enabled = NO;
            [self createTimer];
        }
    } onError:^(NSError *engineError) {
        NSLog(@"no");
    }];
}

/*
 上传验证码
 */
- (void)tureClick
{
    //参数
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setValue:self.number.text forKey:@"tel"];
    [requestInfo setValue:self.code.text forKey:@"code"];
    
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/User/BindTel"];
    [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        if ([[aDictronaryBaseObjects objectForKey:@"ReFlag"] isEqualToString:@"1"]){
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } onError:^(NSError *engineError) {
        NSLog(@"no");
    }];
}
@end
