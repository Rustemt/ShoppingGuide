//
//  BMTemaiController.h
//  KouDaiShopping
//
//  Created by admin on 14-6-5.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "AOWaterView.h"

@interface BMTemaiController : UIViewController
<EGORefreshTableDelegate,UIScrollViewDelegate>
{
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;
}
@property(nonatomic,strong)AOWaterView *aoView;

@end
