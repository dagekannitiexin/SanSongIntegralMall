//
//  SSJFQuickNavgitonViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2018/1/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SSJFQuickNavgitonViewController.h"
#import "NewButton.h"
#import "XMNavigationController.h"
#import "NewShakeViewController.h"
#import "SignViewController.h"

@interface SSJFQuickNavgitonViewController ()
/** 功能数组 */
@property(nonatomic,strong)NSArray * imgIcon;
@property(nonatomic,strong)NSArray *btntitle;
@property(nonatomic,strong)UIScrollView * scrollView;
@end

@implementation SSJFQuickNavgitonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.fd_interactivePopDisabled = YES;
    self.fd_prefersNavigationBarHidden = YES;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    _btntitle = [NSArray arrayWithObjects:@"摇一摇",@"大转盘",@"签到",@"积分商城",@"邀请好友", nil];
    _imgIcon =  [NSArray arrayWithObjects:@"Quick_sharkitoff",@"Quick_ turnplate",@"Quick_signin",@"Quick_ integralShop",@"Quick_ classify",nil];
    [self reloadView];
}

- (void)setleftBackBtn
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed: @"checkUserType_backward_9x15_" ] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(close)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 18/2, 37/2);
    UIBarButtonItem* itembutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = itembutton;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadView
{

    CGFloat h = 0.0;
    CGFloat widspace = 5;
    CGFloat heispace = 30;
    CGFloat btnwid = (SCREEN_WIDTH-4*widspace)/3;
    CGFloat btnhei = (SCREEN_WIDTH-4*widspace)/3;
    for(int i = 0;i<_btntitle.count;i++)
    {
        int m = i/3;
        int n = i%3;

//        AddFun * ad = self.AdArray[i];
        NewButton *btn = [[NewButton alloc]initWithFrame:CGRectMake(widspace+n*(btnwid+widspace), heispace + m*(btnhei+heispace), btnwid, btnhei)];
        btn.tag = i ;
//        NSString * urlstr = ad.image;
//        [btn sd_setImageWithURL:[NSURL URLWithString:urlstr] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:_imgIcon[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitle:_btntitle[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];

        h = CGRectGetMaxY(btn.frame);

    }

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,btnwid,btnwid)];
    btn.center = CGPointMake(self.view.width/2, h+btn.width/2);
    [btn setImage:[UIImage imageNamed:@"home_home_chazi"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(btn.frame)+30);


}

-(void)close
{
    XMNavigationController *nav = (XMNavigationController*)self.navigationController;
    [nav pop];
}

-(void)btnclick:(UIButton *)btn
{
    NSInteger i = btn.tag;
    switch (i) {
        case 0:
        {
            //摇一摇
            NewShakeViewController * shake = [[NewShakeViewController alloc] init];
            shake.title = @"摇一摇";
            [self.navigationController pushViewController:shake animated:YES];

        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            //签到
            SignViewController * vc = [[SignViewController alloc]init];
            
            NSArray *array1 = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25", nil];
            NSDictionary *rule = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"5",@"1",
                                  @"10",@"2",
                                  @"15",@"3",
                                  @"20",@"4",
                                  @"25",@"5",nil];
            
            NSDictionary *dicnew = [NSDictionary dictionaryWithObjectsAndKeys:
                                    array1,@"analysis_rule",
                                    @"1",@"current",
                                    rule,@"rule",
                                    @"103",@"score",
                                    @"5",@"sign_score",
                                    nil];
            vc.transitioningDelegate = [UIApplication sharedApplication].keyWindow.rootViewController;
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.dic = dicnew;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:^{
                
            }];
            
        }
            break;
        case 3:
        {
            //回到主页
            [self close];
        }
            break;
        case 4:
        {
            //设置邀请码
            NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/api/User/GetShareUrl"];
            __weak SSJFQuickNavgitonViewController *weakSelf = self;
            [SSJF_AppDelegate.engine sendRequesttoSSJF:nil portPath:netPath Method:@"GET" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
                NSDictionary *rdt = [aDictronaryBaseObjects objectForKey:@"Rdt"];
                NSString *str = [rdt objectForKey:@"ReData"];
                NSString * tag = @"没有tag";
                NSString * out_url = str;
                NSString * type = @"专题栏";
                [Utility goVcForItemId:tag WithURL:out_url WithType:type WithNavGation:self.navigationController];
            } onError:^(NSError *engineError) {
                NSLog(@"no");
            }];
        }
            break;
        default:
            break;
    }
}
@end
