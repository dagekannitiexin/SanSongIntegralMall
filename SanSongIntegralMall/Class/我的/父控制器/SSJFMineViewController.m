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
        self.listArray = @[@[@"修改头像",@"会员等级",@"昵称",@"收货地址"],@[@"手机",@"微信",@"微博",@"QQ"]];
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
            return 4;
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
@end
