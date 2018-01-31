//
//  SSJFInPutsixteenNum.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SSJFInPutsixteenNum.h"

@interface SSJFInPutsixteenNum ()<UITextFieldDelegate>

@property (nonatomic ,strong)UIButton *inputBtn;
@property (nonatomic ,strong)UITextField *inputField;
@property (nonatomic ,strong)NSString *inputString;
@end

@implementation SSJFInPutsixteenNum

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品扫码";
    self.inputString = @"";//初始化
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 64+55, SCREEN_WIDTH-50, 40)];
    titleLabel.text = @"获取商品码";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:40];
    titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, titleLabel.bottom+15, SCREEN_WIDTH-50, 60)];
    detailLabel.text = @"商品说明:  输入商品条形码上16位数字构成的码数能获取相应的积分";
    detailLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    detailLabel.numberOfLines = 2;
    detailLabel.textColor = RGBACOLOR(132, 132, 132, 1);
    [self.view addSubview:detailLabel];
    
    _inputField = [[UITextField alloc]initWithFrame:CGRectMake(25, detailLabel.bottom +80, SCREEN_WIDTH-50, 20)];
    _inputField.font = [UIFont systemFontOfSize:14];
    _inputField.textAlignment = NSTextAlignmentLeft;
    _inputField.textColor = [UIColor blackColor];
 _inputField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _inputField.placeholder = @"请输入商品的16位码号";
    [_inputField becomeFirstResponder];
    _inputField.keyboardType = UIKeyboardTypePhonePad;
    _inputField.delegate = self;
    [self.view addSubview:_inputField];
    
    //增加分界线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(25, _inputField.bottom+15, SCREEN_WIDTH-50, 1)];
    lineView.backgroundColor = XMLowBottomLine;
    [self.view addSubview:lineView];
    
    _inputBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat margin = 40;
    CGFloat X = margin;
    CGFloat H = 50;
    CGFloat W = ([UIScreen mainScreen].bounds.size.width - 2 * margin);
    CGFloat Y = lineView.bottom +20;
    
    _inputBtn.frame = CGRectMake(X, Y, W, H);
    [_inputBtn setTitle:@"立即获取" forState:UIControlStateNormal];
    [_inputBtn setTitleColor:RGBACOLOR(130, 130, 130, 1) forState:UIControlStateDisabled];
    [_inputBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_inputBtn setBackgroundImage:[UIImage imageNamed:@"btnGradientYellowNormal"] forState:UIControlStateNormal];
    [_inputBtn setBackgroundImage:[UIImage imageNamed:@"btnCommonHighlighted"] forState:UIControlStateDisabled];
//    [_inputBtn setBackgroundColor:RGBACOLOR(206, 206, 206, 1)];
    [_inputBtn addTarget:self action:@selector(goToInput) forControlEvents:UIControlEventTouchUpInside];
    _inputBtn.enabled = NO;
    _inputBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _inputBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _inputBtn.layer.cornerRadius = 25.0f;
    _inputBtn.clipsToBounds = YES;
    [self.view addSubview:_inputBtn];
}

#pragma mark - uitextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""] || string == nil)
    {
        return YES;
    }
    self.inputString = [NSString stringWithFormat:@"%@%@",self.inputString,string];
    //判断按钮的
    if (self.inputString.length == 16){
        self.inputBtn.enabled = YES;
    }else if (self.inputString.length >16){
        return NO;
    }
    
    //增加空格
    textField.text = [self dealWithString:self.inputString];
    
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    self.inputString = @"";
    return YES;
}
//每隔4个字符添加一个空格的字符串算法
- (NSString *)dealWithString:(NSString *)number
{
    NSString *doneTitle = @"";
    int count = 0;
    for (int i = 0; i < number.length; i++) {
        
        count++;
        doneTitle = [doneTitle stringByAppendingString:[number substringWithRange:NSMakeRange(i, 1)]];
        if (count == 4) {
            doneTitle = [NSString stringWithFormat:@"%@ ", doneTitle];
            count = 0;
        }
    }
    return doneTitle;
}

/*
 立即输入
 */
- (void)goToInput
{
    //查看首页
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/Home/SweepCode"];
    //设置常用参数
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setValue:self.inputString forKey:@""];
    [SVProgressHUD showWithStatus:@"正在数据库拔羊毛中"];
    __weak SSJFInPutsixteenNum *weakSelf = self;
    [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        if ([[aDictronaryBaseObjects objectForKey:@"ReFlag"]isEqualToString:@"1"]){
            NSDictionary *rdt = [aDictronaryBaseObjects objectForKey:@"Rdt"];
            NSString *intergral = [rdt objectForKey:@"ReData"];
            [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"获取了%@积分",intergral]];
        }
        
        
    } onError:^(NSError *engineError) {
        NSLog(@"no");
    }];
}
@end
