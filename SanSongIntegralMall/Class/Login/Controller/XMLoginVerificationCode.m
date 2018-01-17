//
//  XMLoginVerificationCode.m
//  XuanMaoShopping
//
//  Created by apple on 2017/9/21.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMLoginVerificationCode.h"
#import "WLUnitField.h"
#import "XMTabBarController.h"

@interface XMLoginVerificationCode ()<WLUnitFieldDelegate>

@property (nonatomic, strong) UILabel  *timeLabel;
/*号码后4位*/
@property (nonatomic, strong) UILabel  *describeLabel;
@property (nonatomic, strong) UIButton *loadTimeAgain;
/** 计时器 */
@property (nonatomic, strong) NSTimer  *timer;
@property (nonatomic, assign) NSInteger timeInt;
@property (nonatomic,strong) NSString *fourNum;
//验证码
@property (nonatomic,strong) WLUnitField *unitField;

@property (nonatomic ,strong)NSString *phonenNumber;
@property (nonatomic ,strong)NSString *openId;
@property (nonatomic ,strong)NSString *code;
@end

@implementation XMLoginVerificationCode

- (void)extracted {
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_prefersNavigationBarHidden = YES;
    _timeInt = 60;
    //创建导航栏
    [self creatnavigationbar];
    
    [self initHomeView];
    
    [self createTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self extracted];
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
    titleLabel.text = @"输入验证码";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:23];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    //提示已经发送了信息
    _describeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+18, SCREEN_WIDTH, 12)];
    _describeLabel.text = [NSString stringWithFormat:@"我已经为你尾号为%@的手机发送验证码",self.fourNum];
    
    _describeLabel.font = [UIFont systemFontOfSize:12];
    _describeLabel.textColor = XMHeigtGaryColor;
    _describeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_describeLabel];
    
    //倒计时
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _describeLabel.bottom +18, 90, 12)];
    _timeLabel.centerX = self.view.centerX;
    _timeLabel.text = @"60s";
    _timeLabel.textColor = RGBACOLOR(210, 86, 81, 1);
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_timeLabel];
    
    
    //重新获取
    _loadTimeAgain = [[UIButton alloc]initWithFrame:CGRectMake(0, _describeLabel.bottom +18, 90, 12)];
    _loadTimeAgain.centerX = self.view.centerX;
    _loadTimeAgain.titleLabel.font = [UIFont systemFontOfSize:13];
    [_loadTimeAgain setTitle:@"重新获取" forState:UIControlStateNormal];
    [_loadTimeAgain setTitleColor:RGBACOLOR(210, 86, 81, 1) forState:UIControlStateNormal];
    [_loadTimeAgain addTarget:self action:@selector(loadAgain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loadTimeAgain];
    _loadTimeAgain.hidden = YES;
    
    //验证码
    _unitField = [[WLUnitField alloc]initWithFrame:CGRectMake(0,_loadTimeAgain.bottom+20, 250, 53.5)];
    _unitField.inputUnitCount = 6;
    _unitField.centerX = self.view.centerX;
    _unitField.borderRadius = 6.0;
    _unitField.cursorColor = [UIColor blueColor];
    _unitField.trackTintColor = [UIColor lightGrayColor];
    _unitField.autoResignFirstResponderWhenInputFinished = YES;
    [_unitField becomeFirstResponder];
    _unitField.delegate =self;
    [self.view addSubview:_unitField];
    
}

- (void)createTimer
{
    // 计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(loadTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - brnClick
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadAgain
{
    //隐藏按钮 显示倒计时label
    self.loadTimeAgain.hidden = YES;
    self.timeLabel.hidden = NO;
    //重开定时器 并且加入循环池
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(loadTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)loadTimerAction
{
    _timeInt --;
    if (_timeInt>0){
        self.timeLabel.text = [NSString stringWithFormat:@"%lds",(long)_timeInt];
    }else {
        // 关闭定时器
        [self.timer invalidate];
        self.timer = nil;
        // 显示按钮 隐藏倒计时label 重置时间 60s
        self.timeLabel.hidden = YES;
        self.loadTimeAgain.hidden = NO;
        _timeInt = 60;
        self.timeLabel.text = [NSString stringWithFormat:@"%lds",(long)_timeInt];
    }
    
}

- (void)setNumberOfPhone:(NSString *)numberOfPhone setOpenId:(NSString*)openId
{
    self.phonenNumber = numberOfPhone;
    self.openId = openId;
    if(numberOfPhone.length ==11){
        //截取后四位
        NSString *FourNum = [numberOfPhone substringFromIndex:7];
        self.fourNum = FourNum;
    }
}

#pragma mark - delegate
- (BOOL)unitField:(WLUnitField *)uniField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%@",string);
    NSLog(@"******>%@",uniField.text);
    NSString *allString = [uniField.text stringByAppendingString:string];
    if (allString.length ==6){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //参数
            NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
            [requestInfo setValue:self.phonenNumber forKey:@"tel"];
            [requestInfo setValue:_unitField.text forKey:@"code"];
            
            NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/Login/LoginByTel"];
            [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                NSDictionary *info = [aDictronaryBaseObjects objectForKey:@"Rdt"];
                NSDictionary *data = [info objectForKey:@"ReData"];
                NSUserDefaults * de =[NSUserDefaults standardUserDefaults];
                [de setObject:[data objectForKey:@"token"] forKey:@"token"];
                [de synchronize];
                
                // 登陆成功 用户的单独注册
//                [JPUSHService setTags:nil aliasInbackground:[NSString stringWithFormat:@"%@",[info objectForKey:@"id"]]];
                [_timer invalidate]; // 销毁timer
                _timer = nil; // 置nil
                [ModelLocator sharedInstance].step = @"1";
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                
                [SSJF_AppDelegate setRootView];
            } onError:^(NSError *engineError) {
                NSLog(@"no");
            }];
            
        });
        
    }
    
    return YES;
}



@end
