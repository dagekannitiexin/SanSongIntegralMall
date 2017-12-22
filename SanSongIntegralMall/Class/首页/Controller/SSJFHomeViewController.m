//
//  SSJFHomeViewController.m
//  SanSongIntegralMall
//
//  Created by apple on 2017/12/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SSJFHomeViewController.h"
#import "SSJFUserInfoView.h" //头部信息
#import "HeadButton.h"
#import "SDCycleScrollView.h"
#import "XMGoodsViewStyleTwoHeadView.h"
#import "XMGoodsViewStyleTwoView.h"
#import "XMGoodsTitleStyleView.h"
#import "goodsViewStyleOne.h"
#import "XMGoodsViewStyleThreeView.h"
#import "SSJFGoodsMostNumView.h"
#import "SSJFMineViewController.h"
#import "SSJFMineIntegralList.h"

@interface SSJFHomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UIView *_headView;
    CGFloat _totleHeight;
    UITableView *_tableView;
    SSJFUserInfoView  *_infoView;
    SDCycleScrollView *_lunzhuanView;
    UIScrollView      *_activeView;
    UIView            *_viewThree; //新品首发
    UICollectionView  *mainCollectionView;
    
}


@end

@implementation SSJFHomeViewController

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏设置 底部tabBar
    self.view.backgroundColor= [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    
    //建设
    self.title = @"积分商城";
    //创建头部视图
    [self initHeadView];
    //初始化tabview
    [self initTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 头部图
 */
- (void)initHeadView
{
    //headView
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = XMBgColor;
    _totleHeight = 0; //设置总head高度
    
    //创建个人信息部分
    [self createInfoView];
    //创建活动
    [self madeActiveView];
    //创建广告轮转图
    [self createBanner];
    //品牌制造商直供
    [self madeNewMajor];
    //创建新品兑换
    [self createNewShop];
    //人气推荐
    [self madeRecommend];
    //兑换大量
    [self createActDuiHuan];

    
    //最后统计_headView大小
    _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _totleHeight);
}
-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_tableView];
    
    [_tableView setTableHeaderView:_headView];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setTableHeaderView:_headView];
}

/*
 创建个人信息部分
 */
- (void)createInfoView
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 85)];
    [_headView addSubview:bgView];
    
    _infoView = [[[NSBundle mainBundle]loadNibNamed:@"SSJFUserInfoView" owner:nil options:nil]lastObject];
    
    __block SSJFHomeViewController *blockSelf = self;
    _infoView.touchViewBlock = ^(NSString *str) {
        if ([str isEqualToString:@"Icon"]){ //跳转到个人页面
            SSJFMineViewController *mine = [[SSJFMineViewController alloc]init];
            [blockSelf.navigationController pushViewController:mine animated:YES];
            
        }else if ([str isEqualToString:@"Integral"]){//跳转到积分页面
            SSJFMineIntegralList *integral = [[SSJFMineIntegralList alloc]init];
            [blockSelf.navigationController pushViewController:integral animated:YES];
        }
    };
    [bgView addSubview:_infoView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, bgView.height, SCREEN_WIDTH, 12)];
    line.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [_headView addSubview:line];
    _totleHeight = _totleHeight +line.bottom;
}

- (void)madeActiveView
{
    //创建活动栏
    _activeView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 95)];
    _activeView.backgroundColor = [UIColor whiteColor];
    _activeView.showsVerticalScrollIndicator = FALSE;
    _activeView.showsHorizontalScrollIndicator = FALSE;
    _activeView.alwaysBounceHorizontal = YES;
    _activeView.layer.masksToBounds = YES;
    [_headView addSubview:_activeView];
    
    CGFloat btnrecommendedW = 50;
    CGFloat btnrecommendedH = 70;
    CGFloat recommendedspace = (SCREEN_WIDTH -2*20-4*btnrecommendedW)/3;
    for (int i=0; i<4; i++) {
        HeadButton *btn = [[HeadButton alloc]initWithFrame:CGRectMake(20 + (btnrecommendedW+recommendedspace)*i, 12.5, btnrecommendedW, btnrecommendedH)];
        btn.tag = i+100;
        [btn setImage:[UIImage imageNamed:@"Img_default"] forState:UIControlStateNormal];
        [btn setTitle:@"积分兑换" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(activeBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.imageView.layer.cornerRadius = btnrecommendedW/2;
        btn.imageView.clipsToBounds = YES;
        [_activeView addSubview:btn];
        _activeView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame)+20, _activeView.height);
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _activeView.bottom, SCREEN_WIDTH, 12)];
    line.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [_headView addSubview:line];
    _totleHeight = line.bottom;
}

/*
 创建轮转图
 */
- (void)createBanner
{
    //创建轮转图
//    __weak SSJFHomeViewController *weakSelf = self;
    _lunzhuanView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, _activeView.bottom+12, SCREEN_WIDTH, SCREEN_WIDTH/3) imageNamesGroup:[NSArray arrayWithObjects:@"Img_default",@"Img_default",@"Img_default", nil]];
    _lunzhuanView.backgroundColor = [UIColor whiteColor];
    _lunzhuanView.contentMode = UIViewContentModeScaleAspectFit;
    _lunzhuanView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _lunzhuanView.delegate=self;
 _lunzhuanView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _lunzhuanView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _lunzhuanView.pageDotColor =RGBACOLOR(19,150,224,0.7);
    _lunzhuanView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        NSLog(@"hah");
    };
    [_headView addSubview:_lunzhuanView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, _lunzhuanView.bottom, SCREEN_WIDTH, 12)];
    line.backgroundColor = RGBACOLOR(240, 240, 240, 1);
    [_headView addSubview:line];
    _totleHeight = line.bottom;
}

//品牌制造商直供
- (void)madeNewMajor
{
    //最外层嵌套
    UIView *viewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 295)];
    viewTwo.backgroundColor = [UIColor whiteColor];
    XMGoodsTitleStyleView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"XMGoodsTitleStyleView" owner:nil options:nil]lastObject];
    titleView.width = SCREEN_WIDTH;
    [viewTwo addSubview:titleView];
    
    CGFloat spaceWithCenter = 5.0;
    CGFloat shopViewHeight = 115.0;
    CGFloat spaceWith = 10;
    CGFloat shopViewWith = (SCREEN_WIDTH - spaceWithCenter - 2*spaceWith)/2;
    for (int i =0; i<4; i++) {
        goodsViewStyleOne *shopView = [[[NSBundle mainBundle]loadNibNamed:@"goodsViewStyleOne" owner:nil options:nil]lastObject];
        shopView.width = shopViewWith;
        [viewTwo addSubview:shopView];
        CGPoint viewPoint;
        if (i<=1){
            viewPoint = CGPointMake(spaceWith+i*(shopViewWith+spaceWithCenter), 0);
        }else {
            viewPoint = CGPointMake(spaceWith+(i-2)*(shopViewWith+spaceWithCenter), shopViewHeight+spaceWithCenter);
        }
        shopView.x =viewPoint.x;
        shopView.y =viewPoint.y+titleView.bottom;
    }
    [_headView addSubview:viewTwo];
    // 加10原因是因为存在边线_totleHeight+10 过了
    _totleHeight = _totleHeight +viewTwo.height;
}

/*
 创建新品首发
 */
- (void)createNewShop
{
    _viewThree = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 345)];
    _viewThree.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:_viewThree];
    
    //头部view
    XMGoodsViewStyleTwoHeadView *shopHeadView = [[[NSBundle mainBundle]loadNibNamed:@"XMGoodsViewStyleTwoHeadView" owner:nil options:nil]lastObject];
    shopHeadView.width = SCREEN_WIDTH;
    [_viewThree addSubview:shopHeadView];
    
    //创建商品视图
    UIScrollView *goodsScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, shopHeadView.bottom, SCREEN_WIDTH, 256)];
    goodsScr.backgroundColor = [UIColor whiteColor];
    goodsScr.showsVerticalScrollIndicator = FALSE;
    goodsScr.showsHorizontalScrollIndicator = FALSE;
    goodsScr.alwaysBounceHorizontal = YES;
    goodsScr.layer.masksToBounds = YES;
    [_viewThree addSubview:goodsScr];
    
    //创建scrollerView内部商品视图
    CGFloat shopTwoSapce = 10;
    CGFloat shopTwoWith = 141;
    for (int i = 0;i<4;i++){
        XMGoodsViewStyleTwoView *shopView = [[[NSBundle mainBundle]loadNibNamed:@"XMGoodsViewStyleTwoView" owner:nil options:nil]lastObject];
        [goodsScr addSubview:shopView];
        CGPoint orginPoint = CGPointMake(shopTwoSapce+(shopTwoSapce+shopTwoWith)*i, shopTwoSapce);
        shopView.origin = orginPoint;
        goodsScr.contentSize = CGSizeMake(shopView.right+20, goodsScr.height);
    }
    _totleHeight = _totleHeight +_viewThree.height;
}

- (void)madeRecommend
{
    //这个view上面包含灰色界面  orgin：viewfour+10
    UIView *viewFour = [[UIView alloc]init];
    viewFour.backgroundColor = [UIColor whiteColor];
    //标题栏
    XMGoodsTitleStyleView *titleView = [[[NSBundle mainBundle]loadNibNamed:@"XMGoodsTitleStyleView" owner:nil options:nil]lastObject];
    [viewFour addSubview:titleView];
    
    CGFloat goodsViewHeighSpace = 15;
    CGFloat goodsViewWidthSpace = 15;
    CGFloat goodsViewHeight = 140;
    CGFloat goodsViewWidth = SCREEN_WIDTH -2*goodsViewWidthSpace;
    ;
    for (int i =0; i<3; i++) {
        XMGoodsViewStyleThreeView *goodsView = [[[NSBundle mainBundle]loadNibNamed:@"XMGoodsViewStyleThreeView" owner:nil options:nil]lastObject];
        goodsView.width = goodsViewWidth;
        [viewFour addSubview:goodsView];
        //设置位置
        goodsView.origin = CGPointMake(goodsViewWidthSpace, titleView.bottom+(goodsViewHeight+goodsViewHeighSpace)*i);
        viewFour.frame = CGRectMake(0, _totleHeight+10, SCREEN_WIDTH, goodsView.bottom+15);
    }
    [_headView addSubview:viewFour];
    _totleHeight = _totleHeight +viewFour.height;
}

/*
 积分兑换
 UICollectionView的高度为150*(num/2+0.5)
 */
- (void)createActDuiHuan
{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //设置headerView的尺寸大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
    //该方法也可以设置itemSize
    layout.itemSize =CGSizeMake((SCREEN_WIDTH-30)/2, 255);
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 275*12+55) collectionViewLayout:layout];
    mainCollectionView.scrollEnabled = YES;
    mainCollectionView.showsVerticalScrollIndicator = NO;
    [_headView addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerNib:[UINib nibWithNibName:@"SSJFGoodsMostNumView" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
    
    //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
    [mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    _totleHeight = _totleHeight +mainCollectionView.height;
}

#pragma maek - btnClick
- (void)activeBtnclick:(UIButton*)sender
{
    
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 24;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SSJFGoodsMostNumView *cell = (SSJFGoodsMostNumView *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-30)/2, 255);
}

//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 55);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor whiteColor];
    XMGoodsTitleStyleView *titleView = [[NSBundle mainBundle]loadNibNamed:@"XMGoodsTitleStyleView" owner:nil options:nil].lastObject;
    [headerView addSubview:titleView];
    return headerView;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSString *msg = cell.botlabel.text;
    //    NSLog(@"%@",msg);
}



@end
