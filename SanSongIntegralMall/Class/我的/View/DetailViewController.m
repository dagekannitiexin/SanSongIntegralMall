//
//  DetailViewController.m
//  点看宁波
//
//  Created by wbq on 16/1/19.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,strong)NSArray * SexArray;
@property(nonatomic,strong)NSArray * ConstellationArray;
@property(nonatomic,assign)NSInteger CurrentIndex;
@end

@implementation DetailViewController

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}



- (BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


-(NSArray *)SexArray
{
    if(_SexArray ==nil)
    {
        _SexArray = @[@"男",@"女"];
    }
    return _SexArray;

}

-(NSArray *)ConstellationArray
{
    if(_ConstellationArray ==nil)
    {
        _ConstellationArray = @[@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座"];
    }
    return _ConstellationArray;
    
}


-(void)nerwork
{
    if([self.TextFiled.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"不可提交空白内容"  ];
    }
    
    [SVProgressHUD show];
    NSUserDefaults * de =[NSUserDefaults standardUserDefaults];
    NSString * Uid = [de valueForKey:@"id"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:Uid forKey:@"tczeidt"];
  
    __weak DetailViewController *weakSelf = self;
    if([self.title isEqualToString:@"昵称"])
    {
        [dic setValue:self.TextFiled.text forKey:@"nickname"];
        
        
    }
    else if([self.title isEqualToString:@"性别"])
    {
        [dic setValue:[NSString stringWithFormat:@"%ld",self.CurrentIndex] forKey:@"sex"];
    }
    else if([self.title isEqualToString:@"年龄"])
    {
        
        if([self isAge:_TextFiled.text])
        {
            [dic setValue:self.TextFiled.text forKey:@"age"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的年龄"];
            return;
        }
        
        
        
        
    }
    else if([self.title isEqualToString:@"星座"])
    {
        [dic setValue:self.ConstellationArray[self.CurrentIndex] forKey:@"constellation"];
    }
    else if([self.title isEqualToString:@"职业"])
    {
        [dic setValue:self.TextFiled.text forKey:@"job"];
    }
    else if([self.title isEqualToString:@"兴趣爱好"])
    {
        [dic setValue:self.TextFiled.text forKey:@"interest"];
    }
    else if ([self.title isEqualToString:@"学校"])
    {
        
        [dic setValue:self.TextFiled.text forKey:@"school"];
        
        
    }
    else if ([self.title isEqualToString:@"故乡"])
    {
        
        [dic setValue:self.TextFiled.text forKey:@"home"];
        
        
    }
    else if ([self.title isEqualToString:@"邮箱"])
    {
        [dic setValue:self.TextFiled.text forKey:@"email"];

//        if([_TextFiled.text hasPrefix:@"@"])
//        {
//            
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:@"请输入正确的邮编"];
//            return;
//        
//        }
//        
       
        
        
    }
    else if ([self.title isEqualToString:@"个人说明"])
    {
        
        [dic setValue:self.TextFiled.text forKey:@"introduction"];
        
        
    }
    
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/User/SetUserName"];
    [SVProgressHUD showWithStatus:@"正在上传"];
    
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setObject:[dic objectForKey:@"nickname"] forKey:@""];
    
    [SSJF_AppDelegate.engine sendRequesttoSSJF:requestInfo portPath:netPath  Method:@"POST" onSucceeded:^(NSDictionary *responseDic){
        NSNumber * result  = [responseDic valueForKey:@"ReFlag"];
        if([result integerValue]==1)
        {
            
            NSUserDefaults * de  =[ NSUserDefaults standardUserDefaults];
            
            [SVProgressHUD showSuccessWithStatus:@"修改成功!"];
            if([weakSelf.title isEqualToString:@"昵称"])
            {
                
            [de setValue:self.TextFiled.text forKey:@"nickname"];
                
               
            }
            else if ([weakSelf.title isEqualToString:@"性别"])
            {
                if(self.CurrentIndex == 0)
                {
                    [de setValue:@"男" forKey:@"sex"];
                    
                }
                else
                {
                    [de setValue:@"女" forKey:@"sex"];
                }
               
               
                
            }else if ([weakSelf.title isEqualToString:@"年龄"])
            {
                
               
                [de setValue:self.TextFiled.text forKey:@"age"];
               
                
            }
            else if ([weakSelf.title isEqualToString:@"职业"])
            {
                
                [de setValue:self.TextFiled.text forKey:@"job"];
  
               
                
            }
            else if ([weakSelf.title isEqualToString:@"星座"])
            {
                
                [de setValue:self.ConstellationArray[self.CurrentIndex] forKey:@"constellation"];
             
                
            }
            else if ([weakSelf.title isEqualToString:@"兴趣爱好"])
            {
                
                [de setValue:self.TextFiled.text forKey:@"interest"];
                
                
            }
            else if ([weakSelf.title isEqualToString:@"学校"])
            {
                
                [de setValue:self.TextFiled.text forKey:@"school"];
                
                
            }
            else if ([weakSelf.title isEqualToString:@"故乡"])
            {
                
                [de setValue:self.TextFiled.text forKey:@"home"];
                
                
            }
            else if ([weakSelf.title isEqualToString:@"邮箱"])
            {
                
                [de setValue:self.TextFiled.text forKey:@"email"];
                
                
            }
            else if ([self.title isEqualToString:@"个人说明"])
            {
                
                [de setValue:self.TextFiled.text forKey:@"introduction"];
                
                
            }
            [de synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
//            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [SVProgressHUD showErrorWithStatus:[responseDic valueForKey:@"info"]  ];
        }
        
        
        
        
        
    } onError:^(NSError *engineError){
        
    }];
    
    
    

}


- (BOOL)isAge:(NSString *)age
{
    NSString *      regex = @"([1-9]|[1-9][0-9]|1[01][0-9])";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:age];
}

-(BOOL)isCode:(NSString *)code
{
    NSString *      regex = @"^[1-9]\\d*$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:code];


}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatnavigationbar];
    
    self.TextFiled.text = self.Deatail;
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    self.tableview.delegate = self;
    self.tableview.dataSource  = self;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.tableview.tableFooterView  = view;
    self.tableview.tableHeaderView = view;
    if ([self.title isEqualToString:@"性别"]) {
        self.TextView.hidden = YES;
       
        self.tableview.tag = 1;
        self.tableview.backgroundColor = [UIColor clearColor];
        self.tableview.scrollEnabled = NO;
        [self.view addSubview:_tableview];
    }
    else if ([self.title isEqualToString:@"星座"])
    {
        self.TextView.hidden = YES;
      
        self.tableview.tag = 2;
        self.tableview.backgroundColor = [UIColor clearColor];
       
        [self.view addSubview:_tableview];
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==1)
    {
         return self.SexArray.count;
    }
    else if (tableView.tag ==2)
    {
        return  self.ConstellationArray.count;
    }
   
    
    return 0;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1)
    {
        
        static NSString *ID = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if(cell == nil)
        {
            cell  =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
        }
        cell.textLabel.text = self.SexArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    else if (tableView.tag ==2)
    {
        static NSString *ID = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if(cell == nil)
        {
            cell  =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
        }
        cell.textLabel.text = self.ConstellationArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    
    
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView.tag == 1)
    {
        self.CurrentIndex = indexPath.row;
        [self nerwork];
    
    }
    if(tableView.tag ==2)
    {
        self.CurrentIndex = indexPath.row;
        [self nerwork];
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissview
{
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)save
{
    if([self.TextFiled.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"不可提交空白内容"  ];
    }
    
    
    else if([self.TextFiled.text isEqualToString:self.Deatail])
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else
    {
        [self nerwork];
    }
    



}

-(void)creatnavigationbar
{
    UIButton *cancle = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,33, 30)];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    cancle.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancle setTintColor:[UIColor blackColor]];
    [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(dismissview) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithCustomView:cancle];
    self.navigationItem.leftBarButtonItem = cancleItem;
    
    UIButton *save = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,33, 30)];
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    save.titleLabel.font = [UIFont systemFontOfSize:15];
    [save setTintColor:[UIColor blackColor]];
    [save addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithCustomView:save];
    self.navigationItem.rightBarButtonItem = saveItem;
}


@end
