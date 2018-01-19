//
//  XMMeAddressEmpty.h
//  XuanMaoShopping
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMBaseViewController.h"

typedef void (^chooseBtnClick) (NSMutableDictionary *);

@interface XMMeAddressEmpty : XMBaseViewController

@property (nonatomic ,copy) chooseBtnClick chooseBtnClickBlock;
@property (nonatomic,assign)BOOL isChooseId; //是否是寻找一个地址就是所谓新增的就是选中的地址
@property (nonatomic,strong)NSString *chooseAdressId;//选中的地址ID
@end
