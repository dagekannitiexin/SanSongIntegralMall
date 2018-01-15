//
//  XMMeAddressEmptyDetail.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeAddressEmptyDetail.h"
#import "XMMeAdressView.h"


@interface XMMeAddressEmptyDetail (){
    UIImageView *_cricleImg;
    NSInteger   _IsDefault;
    
}
//修改地址获取的信息
@property (nonatomic, assign)BOOL isNomalAddress; //是否设置默认地址

@property (nonatomic, strong)NSString *AddressID; //地址的id
@property (nonatomic, strong)NSString *ReceiveName;
@property (nonatomic, strong)NSString *Telphone;
@property (nonatomic, strong)NSString *Province;
@property (nonatomic, strong)NSString *Town;
@property (nonatomic, strong)NSString *District;
@property (nonatomic, strong)NSString *Address;
@property (nonatomic, strong)NSString *IsDefaulte;

@property (nonatomic, strong)XMMeAdressView *adressView;
@property (nonatomic, strong)XXTextView *textView;

@end

@implementation XMMeAddressEmptyDetail

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化
    _IsDefault = 0;//不是默认植
    self.title = @"填写收货地址";
    
    [self creatnavigationbar];
    [self createAdressView];
    
    //判断是新增状态还是修改状态
    if (_isupdate){
        [self upDateAdress];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatnavigationbar
{
    //添加返回按钮
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
//    [backBtn setImage:[UIImage imageNamed:@"Back Chevron"] forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"Back Helight"] forState:UIControlStateHighlighted];
//    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftViewItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem =leftViewItem;
    
    
    UIButton *resavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
    [resavBtn setTitle:@"保存" forState:UIControlStateNormal];
    [resavBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    resavBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [resavBtn addTarget:self action:@selector(resaveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightViewItem = [[UIBarButtonItem alloc]initWithCustomView:resavBtn];
    self.navigationItem.rightBarButtonItem = rightViewItem;
}

- (void)createAdressView
{
    _adressView = [[NSBundle mainBundle]loadNibNamed:@"XMMeAdressView" owner:nil options:nil].lastObject;
    _adressView.origin = CGPointMake(0, 64);
    _adressView.width = SCREEN_WIDTH;
    [self.view addSubview:_adressView];
    
    _textView = [[XXTextView alloc]initWithFrame:CGRectMake(67, 150+64, SCREEN_WIDTH -70-15, 78)];
    _textView.xx_placeholder = @"详细地址";
    _textView.xx_placeholderColor = XMPalceHolderColor;
    _textView.xx_placeholderFont = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:_textView];
    
    //加入设置为默认收货地址
    UIView *setNomalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 135, 40)];
    setNomalView.backgroundColor = [UIColor clearColor];
    setNomalView.center = CGPointMake(self.view.centerX, _adressView.bottom+30);
    [self.view addSubview:setNomalView];
    
    _cricleImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 35)];
    _cricleImg.image = [UIImage imageNamed:@"iconAddressCheckNormal"];
    _cricleImg.centerY = 20;
    [setNomalView addSubview:_cricleImg];
    
    UILabel *setNamal = [[UILabel alloc]initWithFrame:CGRectMake(_cricleImg.right+7, 0, 120, 17)];
    setNamal.text  = @"设为默认收货地址";
    setNamal.centerY = 40/2;
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
        [SVProgressHUD showInfoWithStatus:@"请填写姓名"];
        return;
    }
    if (!(_adressView.phone.text.length ==11)){
        [SVProgressHUD showInfoWithStatus:@"请填写号码"];
        return;
    }
    if (!_adressView.address.text.length){
        [SVProgressHUD showInfoWithStatus:@"请填写地址"];
        return;
    }
    if (!_textView.text.length){
        [SVProgressHUD showInfoWithStatus:@"请填写详细地址"];
        return;
    }
    
    // 保持的的方法 一个是更新，一个是新增
    if (_isupdate){
        //修改
        [self upDateOldAdress];
    }else {
        //新增
        [self addNewAdress];
    }
    
    
}
/*
 新增地址
 */
- (void)addNewAdress
{
    //参数
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setValue:_adressView.name.text forKey:@"ReceiveName"];
    [requestInfo setValue:_adressView.phone.text forKey:@"Telphone"];
    [requestInfo setValue:_adressView.selections[0] forKey:@"Province"];
    [requestInfo setValue:_adressView.selections[1] forKey:@"Town"];
    [requestInfo setValue:_adressView.selections[2] forKey:@"District"];
    [requestInfo setValue:_textView.text forKey:@"Address"];
    [requestInfo setValue:[NSString stringWithFormat:@"%ld",(long)_isNomalAddress] forKey:@"IsDefault"];
    //条件完成可以请求
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/Address/CreateUserShippingAddress"];
    [SVProgressHUD showWithStatus:@"正在保存ing"];
    
    __weak XMMeAddressEmptyDetail *weakSelf = self;
    [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        if ([[aDictronaryBaseObjects objectForKey:@"ReFlag"] isEqualToString:@"1"]){
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
    } onError:^(NSError *engineError) {
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
    }];
}

/*
 修改地址
 */
- (void)upDateOldAdress
{
    //参数
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setValue:self.AddressID forKey:@"AddressID"];
    [requestInfo setValue:_adressView.name.text forKey:@"ReceiveName"];
    [requestInfo setValue:_adressView.phone.text forKey:@"Telphone"];
    [requestInfo setValue:_textView.text forKey:@"Address"];
    
    
    if ([self.Province isEqualToString:_adressView.selections[0]])
    {
        [requestInfo setValue:_adressView.selections[0] forKey:@"Province"];
        [requestInfo setValue:_adressView.selections[1] forKey:@"Town"];
        [requestInfo setValue:_adressView.selections[2] forKey:@"District"];
        
    }else {
        [requestInfo setValue:self.Province forKey:@"Province"];
        [requestInfo setValue:self.Town forKey:@"Town"];
        [requestInfo setValue:self.District forKey:@"District"];
    }
    
    [requestInfo setValue:[NSString stringWithFormat:@"%ld",(long)_isNomalAddress] forKey:@"IsDefault"];
    //条件完成可以请求
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/Address//setAddress"];
    [SVProgressHUD showWithStatus:@"正在修改地址"];
    
    __weak XMMeAddressEmptyDetail *weakSelf = self;
    [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        if ([[aDictronaryBaseObjects objectForKey:@"ReFlag"] isEqualToString:@"1"]){
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
        }
        
    } onError:^(NSError *engineError) {
            [SVProgressHUD showErrorWithStatus:@"修改失败"];
    }];
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


#pragma maek -- 更新地址方法 就是保存方法改变了 设置两种状态的
- (void)upDateAdress
{
    self.AddressID = _model.ReData[_indexPath.row].AddressID;
    self.ReceiveName = _model.ReData[_indexPath.row].ReceiveName;
    self.Telphone = _model.ReData[_indexPath.row].Telphone;
    self.Province = _model.ReData[_indexPath.row].Province;
    self.Town = _model.ReData[_indexPath.row].Town;
    self.District = _model.ReData[_indexPath.row].District;
    self.Address = _model.ReData[_indexPath.row].Address;
    self.IsDefaulte = _model.ReData[_indexPath.row].IsDefault;
    
    self.adressView.name.text = self.ReceiveName;
    self.adressView.phone.text = self.Telphone;
    self.adressView.address.text = [NSString stringWithFormat:@"%@%@%@",self.Province,self.Town,self.District];
    self.textView.text = self.Address;
}
@end
