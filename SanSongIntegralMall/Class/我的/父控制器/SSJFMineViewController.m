//
//  SSJFMineViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFMineViewController.h"
#import "PersonHeadCell.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "XMMeAddressEmpty.h"
#import "XMMeSetting.h"
#import "SSJFBindingViewController.h"
#import <UMSocialCore/UMSocialCore.h>

static CGFloat FirstCellHeight = 100;
static CGFloat CellHeight = 44;
@interface SSJFMineViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UITableView *_tableView;
}
@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) NSArray *detailArray;
@property (nonatomic,strong) UserInfo* userInfo;
@end

@implementation SSJFMineViewController

-(NSArray *)listArray
{
    if (!_listArray) {
        self.listArray = @[@[@"修改头像",@"会员等级",@"昵称",@"收货地址"],@[@"手机",@"微信",@"微博",@"QQ",@"设置"]];
    }
    return _listArray;
}

- (NSArray*)detailArray
{
    if (!_detailArray){
        self.detailArray =@[@[USER_ICON,USER_USERLEVEL,USER_USERNAME,@""],@[USER_TELPHONE,USER_WEICHATNAME,USER_BLOGNAME,USER_QQNAME]];
    }
    return _detailArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    
    //查看更多促销活动
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/User/GetUserInfo"];
    [SVProgressHUD showWithStatus:@"正在加载中"];
    __weak SSJFMineViewController *weakSelf = self;
    [SSJF_AppDelegate.engine sendRequesttoSSJF:nil portPath:netPath Method:@"GET" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        [SVProgressHUD dismiss];
        NSDictionary *Rdt = [aDictronaryBaseObjects objectForKey:@"Rdt"];
        NSDictionary *info = [Rdt objectForKey:@"ReData"];
        weakSelf.userInfo = [UserInfo mj_objectWithKeyValues:info];
        
        NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
        [de setObject:_userInfo.Telphone forKey:@"Telphone"];
        [de setObject:_userInfo.WechatID forKey:@"WechatID"];
        [de setObject:_userInfo.BlogID forKey:@"BlogID"];
        [de setObject:_userInfo.QQID forKey:@"QQID"];
        [de setObject:_userInfo.ImageUrl forKey:@"avatar"];
        [de setObject:_userInfo.UserName forKey:@"username"];
        [de setObject:_userInfo.Integral forKey:@"integral"];
        [de setObject:_userInfo.LevelIntegral forKey:@"LevelIntegral"];
        [de setObject:_userInfo.UserLevel forKey:@"UserLevel"];
        [de setObject:_userInfo.weichatname forKey:@"weichatname"];
        [de setObject:_userInfo.blogname forKey:@"blogname"];
        [de setObject:_userInfo.qqname forKey:@"qqname"];
        [de synchronize];
        [_tableView reloadData];
    } onError:^(NSError *engineError) {
        NSLog(@"no");
    }];
    
}

- (void)initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = RGBCOLOR(246, 246, 249);
    _tableView.scrollEnabled = NO;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 5;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 && indexPath.row==0)
    {
        static NSString *identfire=@"PersonHeadCell";
        PersonHeadCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
        if (!cell) {
            NSBundle *bundle = [NSBundle mainBundle];
            NSArray *objs = [bundle loadNibNamed:@"PersonHeadCell" owner:self options:nil];
            cell = [objs lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.Title.text = self.listArray[indexPath.section][indexPath.row];
        cell.IConBtn.userInteractionEnabled = YES;
        if (USER_ICON){
            [cell.IConBtn sd_setImageWithURL:[NSURL URLWithString:USER_ICON] placeholderImage:[UIImage imageNamed:@"Img_default"]];
        }else {
            cell.IConBtn.image = [UIImage imageNamed:@"Img_default"];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChangeIcon)];
        [cell addGestureRecognizer:tap];
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MINECELL"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"MINECELL"];
            cell.textLabel.font =[UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        }
        
        cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
        
        if (indexPath.section ==0 && indexPath.row ==1){
            cell.detailTextLabel.text = USER_USERLEVEL;
        }else if (indexPath.section ==0 && indexPath.row ==2) {
            cell.detailTextLabel.text = USER_USERNAME;
        }else if (indexPath.section ==0 && indexPath.row ==3) {
            cell.detailTextLabel.text = @"";
        }else if (indexPath.section ==1 && indexPath.row ==0){
            if(USER_TELPHONE){
                cell.detailTextLabel.text = USER_TELPHONE;
            }else {
                cell.detailTextLabel.text = @"未绑定";
            }
            
        }else if (indexPath.section ==1 && indexPath.row ==1){
            if(USER_WEICHATNAME){
                cell.detailTextLabel.text = USER_WEICHATNAME;
            }else {
                cell.detailTextLabel.text = @"未绑定";
            }
            
        }else if (indexPath.section ==1 && indexPath.row ==2){
            if(USER_BLOGNAME){
                cell.detailTextLabel.text = USER_BLOGNAME;
            }else {
                cell.detailTextLabel.text = @"未绑定";
            }
        }else if (indexPath.section ==1 && indexPath.row ==3){
            if(USER_QQNAME){
                cell.detailTextLabel.text = USER_QQNAME;
            }else {
                cell.detailTextLabel.text = @"未绑定";
            }
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==1){
        return 35;
    }else {
        return 15;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==1){
        UIView *headView = [[UIView alloc] init];
        [headView setBackgroundColor:RGBCOLOR(246, 246, 249)];
        UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 35)];
        detail.text = @"账号绑定";
        detail.font = [UIFont systemFontOfSize:14];
        detail.textColor = RGBCOLOR(99, 99, 99);
        [headView addSubview:detail];
        return headView;
    }else{
        UIView *headView = [[UIView alloc] init];
        [headView setBackgroundColor:RGBCOLOR(246, 246, 249)];
        return headView;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==0){
        return 0;
    }else {
        return 15;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] init];
    [footView setBackgroundColor:RGBCOLOR(246, 246, 249)];
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 && indexPath.row ==0){
        return FirstCellHeight;
    }else {
        return CellHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section ==0 &&indexPath.row ==2){
        DetailViewController * detail = [[DetailViewController alloc]init];
        detail.title = _listArray[indexPath.section][indexPath.row];
        NSLog(@"%@",_listArray[indexPath.section][indexPath.row]);
        detail.Deatail = USER_USERNAME;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (indexPath.section ==0 && indexPath.row == 3){
        NSLog(@"设置地址");
        XMMeAddressEmpty *adress = [[XMMeAddressEmpty alloc]init];
        [self.navigationController pushViewController:adress animated:YES];
    }else if (indexPath.section ==1 && indexPath.row ==0){ //绑定手机号
        SSJFBindingViewController *VCbingding = [[SSJFBindingViewController alloc]init];
        [self.navigationController pushViewController:VCbingding animated:YES];
    }else if (indexPath.section ==1 && indexPath.row ==1){ //微信
        [self loginWay:[@"1001" intValue]];
    }else if (indexPath.section ==1 && indexPath.row ==2){ //微博
        [self loginWay:[@"1003" intValue]];
    }else if (indexPath.section ==1 && indexPath.row ==3){ //qq
        [self loginWay:[@"1002" intValue]];
    }else if (indexPath.section ==1 && indexPath.row ==4){ //设置
        XMMeSetting *VCSetting = [[XMMeSetting alloc]init];
        [self.navigationController pushViewController:VCSetting animated:YES];
    }
}

#pragma maek -action
-(void)ChangeIcon
{
    
    UIActionSheet * action  =[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选取",@"拍照", nil];
    [action showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        DMLog(@"从相册获取");
        self.pickType=@"2";
        UIImagePickerController *img=[[UIImagePickerController alloc]init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            img.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            img.allowsEditing=YES;
            img.delegate=self;
            [self presentViewController:img animated:YES completion:nil];
        }
    }
    else if(buttonIndex==1)
    {
        DMLog(@"拍照");
        self.pickType=@"1";
        UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"相机不可用" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alert show];
            return;
        }
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        DMLog(@"取消");
    }
    
}

-(void)saveImage:(UIImage *)image
{
    NSData *dateImage=UIImageJPEGRepresentation(image, 0.3);
    //上传照片请求
    __weak SSJFMineViewController *weakSelf = self;
    [SVProgressHUD show];
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/User/SetUserImage"];
    [SSJF_AppDelegate.engine sendRequesttoWeiBo:nil fileDate:dateImage portPath:netPath onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        [SVProgressHUD dismiss];
        NSLog(@"成功");
    } onError:^(NSError *engineError) {
        NSLog(@"失败");
    }];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([self.pickType isEqualToString:@"1"]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    }
    else if ([self.pickType isEqualToString:@"2"])
    {
        [picker dismissViewControllerAnimated:YES completion:nil];
        UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
    }
    
}

#pragma mark -三方绑定
- (void)loginWay:(NSInteger)choose
{
    switch (choose) {
        case 1001:
        {
            NSLog(@"使用微信登录");
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    //1 授权信息
                    NSLog(@"Wechat uid: %@", resp.uid);
                    NSLog(@"Wechat openid: %@", resp.openid);
                    NSLog(@"Wechat unionid: %@", resp.unionId);
                    NSLog(@"Wechat accessToken: %@", resp.accessToken);
                    NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
                    NSLog(@"Wechat expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"Wechat name: %@", resp.name);
                    NSLog(@"Wechat iconurl: %@", resp.iconurl);
                    NSLog(@"Wechat gender: %@", resp.unionGender);
                    
                    NSNumber *sex = [NSNumber new];
                    if ([resp.unionGender isEqualToString:@"男"]){
                        sex = [NSNumber numberWithInteger:1];
                    }else {
                        sex = [NSNumber numberWithInteger:0];
                    }
                    
                    // 第三方平台SDK源数据
                    NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
                    
                    //统一调用一个方法
                    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
                    [requestInfo setValue:resp.uid forKey:@"ThirdID"];
                    [requestInfo setValue:@"1" forKey:@"ThirdType"];
                    [requestInfo setValue:resp.openid forKey:@"Unionid"];
                    [requestInfo setValue:resp.name forKey:@"Nickname"];
                    [requestInfo setValue:sex forKey:@"Sex"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"province"] forKey:@"Province"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"city"] forKey:@"City"];
                    [requestInfo setValue:@"中国" forKey:@"Country"];
                    [requestInfo setValue:resp.iconurl forKey:@"HeadImageUrl"];
                    [requestInfo setValue:nil forKey:@"Privilege"];
                    [self postInfo:requestInfo LoginType:@"微信"];
                }
            }];
        }
            break;
        case 1002:
        {
            NSLog(@"使用QQ登录");
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    // 授权信息
                    NSLog(@"QQ uid: %@", resp.uid);
                    NSLog(@"QQ openid: %@", resp.openid);
                    NSLog(@"QQ unionid: %@", resp.unionId);
                    NSLog(@"QQ accessToken: %@", resp.accessToken);
                    NSLog(@"QQ expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"QQ name: %@", resp.name);
                    NSLog(@"QQ iconurl: %@", resp.iconurl);
                    NSLog(@"QQ gender: %@", resp.unionGender);
                    NSNumber *sex = [NSNumber new];
                    if ([resp.unionGender isEqualToString:@"男"]){
                        sex = [NSNumber numberWithInteger:1];
                    }else {
                        sex = [NSNumber numberWithInteger:0];
                    }
                    // 第三方平台SDK源数据
                    NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                    //统一调用一个方法
                    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
                    [requestInfo setValue:resp.uid forKey:@"ThirdID"];
                    [requestInfo setValue:@"3" forKey:@"ThirdType"];
                    [requestInfo setValue:resp.openid forKey:@"Unionid"];
                    [requestInfo setValue:resp.name forKey:@"Nickname"];
                    [requestInfo setValue:sex forKey:@"Sex"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"province"] forKey:@"Province"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"city"] forKey:@"City"];
                    [requestInfo setValue:@"中国" forKey:@"Country"];
                    [requestInfo setValue:resp.iconurl forKey:@"HeadImageUrl"];
                    [requestInfo setValue:nil forKey:@"Privilege"];
                    [self postInfo:requestInfo LoginType:@"QQ"];
                }
            }];
        }
            break;
        case 1003:
        {
            NSLog(@"使用微博登录");
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    // 授权信息
                    NSLog(@"Sina uid: %@", resp.uid);
                    NSLog(@"Sina accessToken: %@", resp.accessToken);
                    NSLog(@"Sina refreshToken: %@", resp.refreshToken);
                    NSLog(@"Sina expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"Sina name: %@", resp.name);
                    NSLog(@"Sina iconurl: %@", resp.iconurl);
                    NSLog(@"Sina gender: %@", resp.unionGender);
                    NSNumber *sex = [NSNumber new];
                    if ([resp.unionGender isEqualToString:@"男"]){
                        sex = [NSNumber numberWithInteger:1];
                    }else {
                        sex = [NSNumber numberWithInteger:0];
                    }
                    // 第三方平台SDK源数据
                    NSLog(@"Sina originalResponse: %@", resp.originalResponse);
                    //统一调用一个方法
                    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
                    [requestInfo setValue:resp.uid forKey:@"ThirdID"];
                    [requestInfo setValue:@"2" forKey:@"ThirdType"];
                    [requestInfo setValue:resp.uid forKey:@"Unionid"];
                    [requestInfo setValue:resp.name forKey:@"Nickname"];
                    [requestInfo setValue:sex forKey:@"Sex"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"province"] forKey:@"Province"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"city"] forKey:@"City"];
                    [requestInfo setValue:@"中国" forKey:@"Country"];
                    [requestInfo setValue:resp.iconurl forKey:@"HeadImageUrl"];
                    [requestInfo setValue:nil forKey:@"Privilege"];
                    [self postInfo:requestInfo LoginType:@"新浪"];
                    
                }
            }];
        }
            break;
        default:
            break;
    }
}

/*
 上传用户信息
 */
- (void)postInfo:(NSMutableDictionary *)resp LoginType:(NSString*)type{
    
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/User/BindThird"];
    [SSJF_AppDelegate.engine sendRequesttoSSJF:resp portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        NSString *reflag = [aDictronaryBaseObjects objectForKey:@"ReFlag"];
        NSDictionary *rdt = [aDictronaryBaseObjects objectForKey:@"Rdt"];
        if ([reflag isEqualToString:@"1"]){
            [SVProgressHUD showSuccessWithStatus:@"登录成功"];
            
        }else {
            [SVProgressHUD showInfoWithStatus:[rdt objectForKey:@"ErrorMessage"]];
        }
    } onError:^(NSError *engineError) {
        [SVProgressHUD showErrorWithStatus:@"登录失败请检查网络"];
    }];
}
@end
