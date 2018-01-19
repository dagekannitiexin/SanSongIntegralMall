//
//  XMMeAddressEmptyDetail.h
//  XuanMaoShopping
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMBaseViewController.h"
#import "adressModel.h"

typedef void (^saveBtn) (void);
@interface XMMeAddressEmptyDetail : XMBaseViewController

@property (nonatomic ,copy) saveBtn saveBtnBlock;
@property (nonatomic , strong)adressModel *model;
@property (nonatomic, assign)BOOL         isupdate; //判断是否在修改状态
@property (nonatomic, strong)NSIndexPath  *indexPath; //model的参数

@end
