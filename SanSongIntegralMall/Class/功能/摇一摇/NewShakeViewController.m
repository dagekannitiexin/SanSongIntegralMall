//
//  NewShakeViewController.m
//  点看宁波
//
//  Created by wbq on 16/6/14.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import "NewShakeViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "UIImageView+WebCache.h"
#import <AudioToolbox/AudioToolbox.h>
#import "XMNavigationController.h"


@interface NewShakeViewController () <UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *recordConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *piontlabelW;
@property (strong, nonatomic) IBOutlet UIView *pointView;
@property (strong, nonatomic) IBOutlet UIImageView *Icon;
@property (strong, nonatomic) IBOutlet UILabel *piontlabel;
@property(nonatomic,strong)UIView * ExplainView;
@property(nonatomic,strong)UIView * BGshadowView;
@property(nonatomic,strong)UITextView *text;
@property(nonatomic,strong)NSString * string;
@property (strong, nonatomic) IBOutlet UIImageView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *hand;
@property(nonatomic,assign)CGRect oldFrame;
@property(nonatomic,assign)BOOL isShake;

@end

@implementation NewShakeViewController
static SystemSoundID soundIDTest = 0;
static SystemSoundID soundIDTest2 = 1;

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
    
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    NSLog(@"-------");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!iphone4 && !iphone5s)
        
    {
        self.recordConstraint.constant = -100;
        self.shopConstraint.constant = 100;
       
       
    }
    
    [self CreatmypointView];
    
 

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.hand.layer.anchorPoint = CGPointMake(0.5,0.5);
//    self.hand.frame = self.oldFrame;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self creatnavigationbar];
    [self becomeFirstResponder];

    self.title = @"摇一摇";
    [self CreatBGshadowView];
//    [self GetInfo];
    if(iphone4)
    {
       self.bottomConstraint.constant = -50;
    }
//    [self Getpoint];
    [self.view layoutIfNeeded];
    
   
   
}



-(void)CreatmypointView
{
    
    self.pointView.hidden = YES;
}


-(void)hidenView
{
 
    [UIView animateWithDuration:0.35 animations:^{
        
        _BGshadowView.alpha = 0;
        _isShake = NO;
        
    }];
    
}

-(void)CreatBGshadowView
{
    _BGshadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _BGshadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _BGshadowView.alpha = 0;
    UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenView)];
    [_BGshadowView addGestureRecognizer:tap];
    
    
    
}





-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if( _isShake )
    {
        return;
        
    }
    NSLog(@"我摇了摇");
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self handShakeAnimation];
    
    
}
- (IBAction)shop:(id)sender {
    if([self.type isEqualToString:@"addfun"])
    {
        
        
    }
    else
    {
        XMNavigationController *nav = (XMNavigationController*)self.navigationController;
        [nav pop];
        
    
        [self performSelector:@selector(pushgood) withObject:nil afterDelay:0.3];
    }
    
    
}



-(void)pushgood
{
    
    
    
}


-(void)handShakeAnimation
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.2];
    
    shake.toValue = [NSNumber numberWithFloat:+0.2];
    
    shake.duration = 0.06;
    
    shake.autoreverses = YES; //是否重复
    
    shake.repeatCount = 8;
    
    [self.hand.layer addAnimation:shake forKey:@"imageView"];
    
    self.hand.alpha = 1.0;
    
    
    //修改anchorPoint而不想移动layer，在修改anchorPoint后再重新设置一遍frame就可以达到目的
    self.oldFrame =  self.hand.frame;
    
    self.hand.layer.anchorPoint = CGPointMake(0.5,0.75);
    
    self.hand.frame = self.oldFrame;
    
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:nil];
    [self ShakestartSound];

}


- (void)ShakestartSound{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"摇一摇音效" ofType:@"mp3"];
        if (path) {
            
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest);
            
        }
        AudioServicesPlaySystemSound( soundIDTest );
}


-(void)RewardstartSound{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"中奖音效" ofType:@"mp3"];
    if (path) {
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest2);
       
        
    }
    AudioServicesPlaySystemSound( soundIDTest2 );
}




-(void)creatnavigationbar
{

    UIButton *rule  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,40, 20)];
    rule.titleLabel.font = [UIFont systemFontOfSize:15];
    [rule setTitle:@"规则" forState:UIControlStateNormal];
    [rule setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rule addTarget:self action:@selector(Rule) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem1 = [[UIBarButtonItem alloc] initWithCustomView:rule];
    self.navigationItem.rightBarButtonItem = backItem1;

}

-(void)Rule
{
    self.isShake = YES;
    self.hand.layer.anchorPoint = CGPointMake(0.5,0.5);
    
    [self CreatExplain];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _BGshadowView.alpha = 1;
        
    }];
     self.hand.frame = self.oldFrame;



}

-(void)CreatExplain
{
    
    
    [_ExplainView removeFromSuperview];
    _ExplainView = [[UIView alloc]initWithFrame:CGRectMake(30, 40, SCREEN_WIDTH-60, (SCREEN_WIDTH-60)*1.4)];
    
    _ExplainView.backgroundColor = [UIColor whiteColor];
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _ExplainView.width, 5)];
    imageview.image  = [UIImage imageNamed:@"弹窗条"];
    [_ExplainView addSubview:imageview];
    [_BGshadowView addSubview:_ExplainView];
    _ExplainView.center = CGPointMake(_BGshadowView.width/2, _BGshadowView.height/2-20);
    UITapGestureRecognizer * tap1  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stoptouch)];
    [_ExplainView addGestureRecognizer:tap1];
    
    [self.view addSubview:_BGshadowView];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, _ExplainView.width, 50)];
    title.text = @"活动说明";
    
    title.textColor = RGBCOLOR(25, 86, 160);
    title.textAlignment = NSTextAlignmentCenter;
    [_ExplainView addSubview:title];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(title.frame), _ExplainView.width - 40, 1)];
    line.backgroundColor =RGBCOLOR(220, 220, 220);
    [_ExplainView addSubview:line];
    
    _text = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame), _ExplainView.width -20, _ExplainView.height -100)];
    [_ExplainView addSubview:_text];
    _text.editable = NO;
    if(self.string)
    {
        _text.text = self.string;
    }
    else
    {
        _text.text = @"一、什么是美的积分？ \n 1. 美的积分定义：美的积分仅限美的平台（美的商城www.midea.com、“美的商城”微信公众号、“美的会员”微信公众号、淘系美的旗下指定旗舰店、专卖店等）内使用，是对美的用户完善个人资料、评价、签到、 线上购买美的产品等相关活动情况的奖励。\n 2. 美的积分有效期：积分可以累积，有效期至少为1年，即从获得开始至次年年底，逾期自动作废。\n3. 积分消耗逻辑：会员在使用积分时，优先消耗有效期更近的积分（如累积积分包括今年年底到期和明年年底到期的积分，则优先消耗今年年底到期的积分）。 \n \n 二、如何获得美的积分? \n 以下6种途径可以获得积分： \n 1. 对购物订单进行评价：在美的商城购买产品并确认收货后，可对所购买的产品进行评价，提交评价可获得10积分。如有晒图则可获得20积分的奖励。\n 2. 首次完成手机验证：首次成功绑定手机号可获得积分，每个会员仅可获得一次。\n 3. 个人资料100%完善：“个人中心”中“我的资料”的信息完整度100%可获得积分，每个会员仅可获得一次。 \n 4. 每日首次签到：在“个人中心”或“每日签到”每天首次签到可获得积分，每个会员每天仅可获得一次。 \n 5. 参与美的线上活动：可获得活动奖励积分，如：积分抽奖、冷知识、微砍价等活动。 \n 6. 线上购买美的产品：从2015年5月1日起，在线上指定店铺购买美的产品，收货人可获得相应积分；获得的积分需在30日内在“我的美的产品”中点击领取，否则积分失效；请收货人及时关注“美的商城”微信公众号，并注册美的会员，否则积分发放失败不予补偿。在美的商城购买的产品会在购买人确认收货后的24小时内自动发放到购买人的账号，购买人可在积分明细中进行查询。\n 线上购买美的产品获得积分公式为：交易金额X平台系数X积分返点； \n 平台系数：美的商城、淘系美的旗下指定店铺的平台系数为1，其他线上平台为0.8； \n 积分返点：积分的基准返点比例为商品交易金额的10%；";
    }
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_text.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _text.text.length)];
    
    _text.attributedText = attributedString;
    _text.textColor = RGBCOLOR(150, 150, 150);
    [_text setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    
    UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    btn.center = CGPointMake(_ExplainView.width/2, _ExplainView.height - 10 -15);
    btn.backgroundColor = RGBCOLOR(25, 86, 160);
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"我知道了" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5.0;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(hidenView) forControlEvents:UIControlEventTouchUpInside];
    [_ExplainView addSubview:btn];
    
    
     self.hand.frame = self.oldFrame;
}


- (IBAction)ShakeRecord:(id)sender {
    
    

    
    
    
    
}

-(void)stoptouch
{
    
    
    
}

-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
