//
//  XMMeSetting.m
//  XuanMaoShopping
//
//  Created by apple on 2017/9/18.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeSetting.h"
#import "XMMeCellStyleOne.h"
#import "XMNavigationController.h"

@interface XMMeSetting ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_titleArray;
    NSMutableArray *_imageArray;
}

@end

@implementation XMMeSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self creatnavigationbar];
    //新建tableview
    [self createTableView];
    
    _titleArray = [NSMutableArray arrayWithObjects:@"清理缓存",@"鼓励一下",@"隐私和协议",@"加入我们",@"退出登录", nil];
    _imageArray = [NSMutableArray arrayWithObjects:@"iconCleanCach",@"iconSettingSore",@"iconSettingPrivacy",@"iconSettingAbout",@"iconSettingLogout", nil];
    NSLog(@"jdoafj");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)creatnavigationbar
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    //添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"commoditydetail_detail_ic_back_2_nor"] forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"Back Helight"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    // 添加title视图
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 175, 44)];
    titleLabel.centerX = navView.centerX;
    titleLabel.centerY = 20+22;
    titleLabel.text = @"设置";
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

- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"XMMeCellStyleOne" bundle:nil] forCellReuseIdentifier:@"CellDefault"];
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}


#pragma mark - UITableViewDelegate UITableVIewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1){
        return 2;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 12)];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellDefault";
    XMMeCellStyleOne *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[XMMeCellStyleOne alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.section ==0){
        cell.titleLabel.text = _titleArray[0];
        cell.iconImg.image = [UIImage imageNamed:_imageArray[0]];
        cell.detailfootLabel.hidden = NO;
        cell.detailfootLabel.text = @"已经使用 90.2MB";
        cell.detailfootLabel.font = [UIFont systemFontOfSize:12];
    }else if (indexPath.section ==1){
        if (indexPath.row ==0){
            cell.titleLabel.text = _titleArray[1];
            cell.iconImg.image = [UIImage imageNamed:_imageArray[1]];
        }else{
            cell.titleLabel.text = _titleArray[2];
            cell.iconImg.image = [UIImage imageNamed:_imageArray[2]];
        }
    }else if (indexPath.section ==2){
        cell.titleLabel.text = _titleArray[3];
        cell.iconImg.image = [UIImage imageNamed:_imageArray[3]];
    }else if (indexPath.section ==3){
        cell.titleLabel.text = _titleArray[4];
        cell.iconImg.image = [UIImage imageNamed:_imageArray[4]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0){
        //选中效果消失
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //清空缓存 跳出弹框
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:@"确定清理缓存么？" preferredStyle:UIAlertControllerStyleActionSheet];
        //添加按钮
        __weak typeof (alter)weakAlter = alter;
        [weakAlter addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"缓存清除啦");
        }]];
        
        [weakAlter addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alter animated:YES completion:nil];
        
    }else if (indexPath.section ==1){
        if (indexPath.row==0){
            //鼓励一下，跳转到appstore
            //https://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/jie-zou-da-shi/id493901993?mt=8"]];
        }else {
            //隐私和协议  待定接口
            #warning 隐私和协议  待定接口
        }
    }else if (indexPath.section ==2){
        //加入我们  跳转网页
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://shoufutuan.gotoip11.com/cn/index.php"]];
        
    }else if (indexPath.section ==3){
        //退出登录
        //选中效果消失
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //清空缓存 跳出弹框
        UIAlertController *alterOutSign = [UIAlertController alertControllerWithTitle:nil message:@"确认退出登录" preferredStyle:UIAlertControllerStyleActionSheet];
        //添加按钮
        __weak typeof (alterOutSign)weakAlter = alterOutSign;
        [weakAlter addAction:[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"退出登录");
            //查看首页
            NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/Login/LoginOut"];
            //设置常用参数
            NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
            [requestInfo setValue:USER_TOKEN forKey:@""];
            [SVProgressHUD showWithStatus:@"退出登录中"];
            __weak XMMeSetting *weakSelf = self;
            [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
                if ([[aDictronaryBaseObjects objectForKey:@"ReFlag"] isEqualToString:@"1"]){
                    [ModelLocator sharedInstance].step = @"-1";
                    [SSJF_AppDelegate setRootView];
                }else {
                    [SVProgressHUD showErrorWithStatus:@"退出登录失败"];
                }
            } onError:^(NSError *engineError) {
                [SVProgressHUD showErrorWithStatus:@"退出登录失败"];
            }];
        }]];
        
        [weakAlter addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alterOutSign animated:YES completion:nil];
    }
}
@end
