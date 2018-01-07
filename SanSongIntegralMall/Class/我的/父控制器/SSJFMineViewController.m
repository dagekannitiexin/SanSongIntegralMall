//
//  SSJFMineViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFMineViewController.h"
#import "PersonHeadCell.h"

static CGFloat FirstCellHeight = 100;
static CGFloat CellHeight = 44;
@interface SSJFMineViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UITableView *_tableView;
}
@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,strong) NSArray *detailArray;
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
        self.detailArray =@[@[@"",@"白金会员",@"大哥看你贴心",@""],@[@"1785****557",@"未绑定",@"未绑定",@"未绑定"]];
    }
    return _detailArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    //查看更多促销活动
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/User/GetUserInfo"];
    
    __weak SSJFMineViewController *weakSelf = self;
    [SSJF_AppDelegate.engine sendRequesttoSSJF:nil portPath:netPath Method:@"GET" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        NSDictionary *Rdt = [aDictronaryBaseObjects objectForKey:@"Rdt"];
        NSDictionary *info = [Rdt objectForKey:@"ReData"];
        NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
        [de setObject:[info objectForKey:@"Telphone"] forKey:@"Telphone"];
        [de setObject:[info objectForKey:@"WechatID"] forKey:@"WechatID"];
        [de setObject:[info objectForKey:@"BlogID"] forKey:@"BlogID"];
        [de setObject:[info objectForKey:@"QQID"] forKey:@"QQID"];
        [de setObject:[info objectForKey:@"UserName"] forKey:@"username"];
        [de setObject:[info objectForKey:@"Integral"] forKey:@"integral"];
        [de setObject:[info objectForKey:@"LevelIntegral"] forKey:@"LevelIntegral"];
        [de setObject:[info objectForKey:@"UserLevel"] forKey:@"UserLevel"];
        [de setObject:[info objectForKey:@"blogname"] forKey:@"blogname"];
        [de setObject:[info objectForKey:@"qqname"] forKey:@"qqname"];
    } onError:^(NSError *engineError) {
        NSLog(@"no");
    }];
    
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
        cell.IConBtn.image = [UIImage imageNamed:@"Img_default"];
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
        cell.detailTextLabel.text = self.detailArray[indexPath.section][indexPath.row];
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
    
    //刷新tableview
    [_tableView reloadData];
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
