//
//  GZGRecommend.m
//  SanSongIntegralMall
//
//  Created by 林林尤达 on 2018/1/31.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "GZGRecommend.h"
#import "SDCycleScrollView.h"
#import "SSJFHomeModel.h"
#import "GZGProductViewOne.h"
#import "XMGoodsTitleStyleView.h"
#import "XMGoodsTitleStyleView.h"
#import "SSJFGoodsMostNumView.h"

@interface GZGRecommend ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate>{
    UIView *_headView;
    CGFloat _totleHeight;
    UITableView *_tableView;
    UICollectionView  *mainCollectionView;
    SDCycleScrollView *_lunzhuanView;
}
@property (nonatomic,strong)SSJFHomeModel * homeDetailModel;
@end

@implementation GZGRecommend

- (void)viewDidLoad {
    [super viewDidLoad];
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
    _headView.backgroundColor = [UIColor whiteColor];
    _totleHeight = 0; //设置总head高度
    //创建广告轮转图
    [self createBanner];
    //创建商品1 自营商品
    [self createSelfShop];
    //周一周四新品首发
    [self createNewShop];
    //为你推荐
    [self createActDuiHuan];
    //最后统计_headView大小
    _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _totleHeight+150);
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_tableView];
    
_tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.alwaysBounceVertical=NO;
//    _tableView.bounces=NO;
    [_tableView setTableHeaderView:_headView];
}

/*
 创建轮转图
 */
- (void)createBanner
{
    NSMutableArray *imageArray = [NSMutableArray new];
//    for (int i =0; i<_homeDetailModel.homeadv.count; i++) {
//        if ([_homeDetailModel.homeadv[i] valueForKey:@"ImageUrl"]){
//            [imageArray addObject:[_homeDetailModel.homeadv[i] valueForKey:@"ImageUrl"]];
//        }
//    }
    
    imageArray = @[@"Img_default",@"Img_default",@"Img_default",@"Img_default",@"Img_default"];
    //创建轮转图
    __weak GZGRecommend *weakSelf = self;
    _lunzhuanView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, SCREEN_WIDTH/16*9) imageURLStringsGroup:imageArray];
    _lunzhuanView.backgroundColor = [UIColor whiteColor];
    _lunzhuanView.contentMode = UIViewContentModeScaleAspectFit;
    _lunzhuanView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _lunzhuanView.delegate=self;
 _lunzhuanView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _lunzhuanView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _lunzhuanView.pageDotColor =RGBACOLOR(19,150,224,0.7);
    _lunzhuanView.currentPageDotImage = [UIImage imageNamed:@"homepage_switching_point"];
    _lunzhuanView.pageDotImage = [UIImage imageNamed:@"homepage_switching_point_white"];
    __block GZGRecommend *blockSelf = self;
    _lunzhuanView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        NSString * tag = @"没有tag";
        NSString * out_url = blockSelf.homeDetailModel.homeadv[currentIndex].AdActionUrl;
        NSString * type = @"专题栏";
        [Utility goVcForItemId:tag WithURL:out_url WithType:type WithNavGation:blockSelf.navigationController];
    };
    [_headView addSubview:_lunzhuanView];
    
    _totleHeight = _lunzhuanView.height;
}

/*
 创建自营商品
 */
- (void)createSelfShop
{
    UIView *oneView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 405)];
    oneView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:oneView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    title.text = @"公主家自营";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:16];
    [oneView addSubview:title];
    
    CGFloat spaceWith = 15;
    CGFloat shopViewWith = (SCREEN_WIDTH - 4*spaceWith)/3;
    CGFloat shopViewHeight = shopViewWith +70+20*KWidth_Scale;
    NSLog(@"%f",20*KHeight_Scale);
    NSLog(@"%f,%f",SCREEN_WIDTH,SCREEN_HEIGHT);
    for (int i =0; i<6; i++) {
        if (i<3){
            GZGProductViewOne *shopView = [[GZGProductViewOne alloc]initWithFrame:CGRectMake(spaceWith+(spaceWith +shopViewWith)*i, title.bottom, shopViewWith, shopViewHeight)];
            [oneView addSubview:shopView];
        }else {
            GZGProductViewOne *shopView = [[GZGProductViewOne alloc]initWithFrame:CGRectMake(spaceWith+(spaceWith +shopViewWith)*(i-3), title.bottom+shopViewHeight, shopViewWith, shopViewHeight)];
            [oneView addSubview:shopView];
        }
            }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, title.bottom+shopViewHeight*2, SCREEN_WIDTH, 10)];
    line.backgroundColor = XMBottomLine;
    [oneView addSubview:line];
    
    oneView.height =line.bottom;
    _totleHeight = _totleHeight +oneView.height;
}

/*
 自营商品
 */
- (void)createNewShop
{
    UIView *twoView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 405)];
    twoView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:twoView];
    
    XMGoodsTitleStyleView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"XMGoodsTitleStyleView" owner:nil options:nil]lastObject];
    titleView.width = SCREEN_WIDTH;
    titleView.title.text = @"周一周四 · 新品首发";
    [twoView addSubview:titleView];
    
    CGFloat spaceWith = 15;
    CGFloat shopViewWith = (SCREEN_WIDTH - 4*spaceWith)/3;
    CGFloat shopViewHeight = shopViewWith +70+20*KWidth_Scale;
    NSLog(@"%f",20*KHeight_Scale);
    NSLog(@"%f,%f",SCREEN_WIDTH,SCREEN_HEIGHT);
    for (int i =0; i<6; i++) {
        if (i<3){
            GZGProductViewOne *shopView = [[GZGProductViewOne alloc]initWithFrame:CGRectMake(spaceWith+(spaceWith +shopViewWith)*i, titleView.bottom, shopViewWith, shopViewHeight)];
            [twoView addSubview:shopView];
        }else {
            GZGProductViewOne *shopView = [[GZGProductViewOne alloc]initWithFrame:CGRectMake(spaceWith+(spaceWith +shopViewWith)*(i-3), titleView.bottom+shopViewHeight, shopViewWith, shopViewHeight)];
            [twoView addSubview:shopView];
        }
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, titleView.bottom+shopViewHeight*2, SCREEN_WIDTH, 10)];
    line.backgroundColor = XMBottomLine;
    [twoView addSubview:line];
    
    twoView.height =line.bottom;
    _totleHeight = _totleHeight +twoView.height;
}

/*
 为你推荐
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
    layout.itemSize =CGSizeMake((SCREEN_WIDTH-30)/2, 270);
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 290*(8)/2+55) collectionViewLayout:layout];
    mainCollectionView.scrollEnabled = NO;
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

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSJFGoodsMostNumView *cell = (SSJFGoodsMostNumView *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
//    cell.ProductName.text = _homeDetailModel.homepro5[indexPath.row].ProductName;
//    cell.Price.text = [NSString stringWithFormat:@"%@%@",@"¥",_homeDetailModel.homepro5[indexPath.row].Price];
//    [cell.Imageurl sd_setImageWithURL:[NSURL URLWithString:_homeDetailModel.homepro5[indexPath.row].Imageurl] placeholderImage:[UIImage imageNamed:@"Img_default"]];
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-30)/2, 270);
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
    return UIEdgeInsetsMake(0, 10, 10, 10);
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
    titleView.title.text =@"为你推荐";
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
