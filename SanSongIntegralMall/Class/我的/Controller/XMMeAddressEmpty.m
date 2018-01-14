//
//  XMMeAddressEmpty.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeAddressEmpty.h"
#import "XMMeAddressEmptyDetail.h"
#import "SSJFAdressCell.h"
#import "adressModel.h"

@interface XMMeAddressEmpty ()<UITableViewDelegate,UITableViewDataSource>{
    UIView *_emptyView;
    UITableView *_tableView;
    
}
@property (nonatomic , strong)adressModel *model;
@end

@implementation XMMeAddressEmpty

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.fd_prefersNavigationBarHidden = YES;
    // Do any additional setup after loading the view.
//    [self creatnavigationbar];
    self.title = @"管理收货地址";
    
    [self initNetWork];
    
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [_tableView registerNib:[UINib nibWithNibName:@"SSJFAdressCell" bundle:nil] forCellReuseIdentifier:@"SSJFAdressCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

//initNetWork
- (void)initNetWork
{
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/Address/GetUserShippingAddressList"];
    [SVProgressHUD showWithStatus:@"正在加载中"];
    __weak XMMeAddressEmpty *weakSelf = self;
    [SSJF_AppDelegate.engine sendRequesttoSSJF:nil portPath:netPath Method:@"GET" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        [SVProgressHUD dismiss];
        if ([[aDictronaryBaseObjects objectForKey:@"ReFlag"]isEqualToString:@"1"])
        {
            //给模型赋值
            weakSelf.model = [adressModel mj_objectWithKeyValues:[aDictronaryBaseObjects objectForKey:@"Rdt"]];
            [self createTableView];
        }else {
            //无数据
            [weakSelf createEmptyView];
        }
        //新增收货地址
        [self addAddressBtn];
    } onError:^(NSError *engineError) {
        NSLog(@"no");
        //新增收货地址
        [self addAddressBtn];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatnavigationbar
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    //添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"Back Chevron"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"Back Helight"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    // 添加title视图
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 175, 44)];
    titleLabel.centerX = navView.centerX;
    titleLabel.centerY = 20+22;
    titleLabel.text = @"管理收货地址";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [navView addSubview:titleLabel];
    
    
    //添加底线
    UIView * bottomline = [[UIView alloc]initWithFrame:CGRectMake(0, navView.height-0.5, SCREEN_WIDTH, 0.5)];
    bottomline.backgroundColor = XMBottomLine;
    [navView addSubview:bottomline];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- initView
- (void)createEmptyView
{
    _emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _emptyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_emptyView];
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"bgAddressEmpty"];
    bgView.size = CGSizeMake(190, 190);
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    bgView.y = 140*KHeight_Scale;
    [_emptyView addSubview:bgView];
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    messageLabel.y = bgView.bottom;
    messageLabel.text = @"暂无收货地址";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textColor = XMGaryColor;
    [_emptyView addSubview:messageLabel];
    
}


- (void)addAddressBtn
{
    UIButton *addNewAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50)];
    addNewAddressBtn.backgroundColor = RGBACOLOR(208, 88, 84, 1);
    [addNewAddressBtn setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [addNewAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [addNewAddressBtn setImage:[UIImage imageNamed:@"iconSubAdd"] forState:UIControlStateNormal];
    [addNewAddressBtn setImage:[UIImage imageNamed:@"iconSubAdd"] forState:UIControlStateHighlighted];
    
    [addNewAddressBtn addTarget:self action:@selector(addNewAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addNewAddressBtn];
}

- (void)addNewAddressBtnClick
{
    XMMeAddressEmptyDetail *VC = [[XMMeAddressEmptyDetail alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - uitableViewDelegate  UITAbleViewDateSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.ReData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SSJFAdressCell";
    SSJFAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[SSJFAdressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.name.text  = [NSString stringWithFormat:@"%@",_model.ReData[indexPath.row].ReceiveName];
    cell.phone.text = [NSString stringWithFormat:@"%@",_model.ReData[indexPath.row].Telphone];
    cell.adressDetail.text  = [NSString stringWithFormat:@"%@%@%@%@",_model.ReData[indexPath.row].Province,_model.ReData[indexPath.row].Town,_model.ReData[indexPath.row].District,_model.ReData[indexPath.row].Address];
    //判断是否是默认的地址
    if (![_model.ReData[indexPath.row].IsDefault isEqualToString:@"1"]){
        cell.isDefault.hidden = YES;
    }
    cell.upDateBtnBlock = ^{
        //修改地址  与新增收货地址一致
        XMMeAddressEmptyDetail *VC = [[XMMeAddressEmptyDetail alloc]init];
        VC.model = self.model;
        VC.indexPath = indexPath;
        VC.isupdate = YES;
        [self.navigationController pushViewController:VC animated:YES];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
