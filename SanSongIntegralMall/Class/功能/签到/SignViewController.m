//
//  SignViewController.m
//  点看宁波
//
//  Created by wbq on 16/8/26.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import "SignViewController.h"
#import "NZLabel.h"

@interface SignViewController ()
@property (strong, nonatomic) IBOutlet UIView *BgView;

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    ViewBorderRadius(self.BgView , 15, 0, [UIColor clearColor]);
    
    CGFloat bgVieW = SCREEN_WIDTH -38;
    
    NZLabel * label = [[NZLabel alloc]initWithFrame:CGRectMake(5 * KWidth_Scale, 25,bgVieW - 10 * KWidth_Scale, 32)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    if(iphone4||iphone5s)
    {
        label.font = [UIFont systemFontOfSize:16];
    }
    label.textColor = RGBCOLOR(17, 17, 17);
    label.text = [NSString stringWithFormat:@"连续签到%@天,今日领取+%@积分",self.dic[@"current"],self.dic[@"sign_score"]];
    [label setFontColor:RGBCOLOR(255, 67, 0) string:[NSString stringWithFormat:@"+%@",self.dic[@"sign_score"]]];
    [label setFont:[UIFont systemFontOfSize:32] string:[NSString stringWithFormat:@"+%@",self.dic[@"sign_score"]]];
   
    [self.BgView addSubview:label];

    NSDictionary * rule = self.dic[@"rule"];
    
    
    CGFloat baseW = (bgVieW - 30 - 50)/5.2; //没选中的宽度1倍，选中的宽度1.5倍
    
    NSInteger currentDay = [self.dic[@"current"] integerValue];
    CGFloat W;
    CGFloat offsetY;
    CGFloat totallW  = 15;
    
    
    for (int i = 0 ; i< rule.allKeys.count; i++) {
        
        if(i == currentDay - 1) { W = baseW * 1.2; offsetY = 0;}
        
        else { W = baseW; offsetY = baseW * 0.1; }
    
        CGFloat space = 17.5;
        if(iphone4||iphone5s)
        {
            space = 10;
        }
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(totallW, CGRectGetMaxY(label.frame)+ space*KWidth_Scale , W, W * 1.6)];
//      view.backgroundColor = [UIColor redColor];
        totallW = totallW + W + 12.5;
        [self.BgView addSubview:view];
        
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, offsetY, view.width, view.width)];
        if(i < currentDay)
        iv.image = [UIImage imageNamed:@"signed"];
        else
        iv.image = [UIImage imageNamed:@"unsign"];
        [view addSubview:iv];
        
        UILabel * daylb = [[UILabel alloc]initWithFrame:CGRectMake(0, W + 2 * offsetY + 8.5, view.width, 13)];
        daylb.text = [NSString stringWithFormat:@"%d 天",i+1];
        if(i == 4)
        {
            daylb.text = [NSString stringWithFormat:@"%d+ 天",i+1];
        }
        daylb.font = [UIFont systemFontOfSize:13];
        daylb.textColor = RGBCOLOR(194, 135, 14);
        daylb.textAlignment = NSTextAlignmentCenter;
        [view addSubview:daylb];
        
        if(i < currentDay - 1)
        {
            UILabel * pointlb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.width, 20)];
            pointlb.center = iv.center;
            pointlb.font = [UIFont systemFontOfSize:20];
            pointlb.text = [NSString stringWithFormat:@"+%@",rule[[NSString stringWithFormat:@"%d",i+1]]];
            pointlb.textAlignment = NSTextAlignmentCenter;
            pointlb.y = pointlb.y - 5;
            pointlb.textColor = RGBCOLOR(194, 135, 14);
            [view addSubview:pointlb];
            
            UILabel * already = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(pointlb.frame)+1, view.width, 9)];
            already.text =@"已领取";
            already.font = [UIFont systemFontOfSize:9];
            already.textColor = RGBCOLOR(194, 135, 14);
            already.textAlignment = NSTextAlignmentCenter;
    
            if(currentDay > 5)
            {
                if(i<4)
                {
                    [view addSubview:already];
                  
                }
                else
                {
                     pointlb.center = iv.center;         
                }

            }
            else
            {
                [view addSubview:already];
            }
            
        }
        else
        {
            
            UILabel * pointlb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.width, 20)];
            pointlb.center = iv.center;
          
            pointlb.font = [UIFont systemFontOfSize:20];
            [view addSubview:pointlb];
            pointlb.text = [NSString stringWithFormat:@"+%@",rule[[NSString stringWithFormat:@"%d",i+1]]];
            pointlb.textAlignment = NSTextAlignmentCenter;
            if(i == currentDay - 1)
            pointlb.textColor = RGBCOLOR(194, 135, 14);
            else
            pointlb.textColor = RGBCOLOR(153, 153, 153);
        
        }
        
//        NSUserDefaults * de = [NSUserDefaults standardUserDefaults];
//        [de setObject:[NSString stringWithFormat:@"%@",self.dic[@"score"]] forKey:@"integral"];
//        [de synchronize];
//        [DKNB_AppDelegate.left Change:[NSString stringWithFormat:@"%@",self.dic[@"score"]]];
        
    }
    
    
    
    
    
    
}
- (IBAction)closeSign:(id)sender {
    
      [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  
}
@end
