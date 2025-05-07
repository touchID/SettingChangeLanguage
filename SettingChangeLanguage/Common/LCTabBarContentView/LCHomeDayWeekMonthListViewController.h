//
//  LCHomeDayWeekMonthListViewController.h
//  RegulatoryBao
//
//  Created by luchao on 2019/9/25.
//  Copyright © 2019 xuemei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCShoppingMallView.h"
#import "LCAlertMaiMaiMaiView.h"
#import "SHSHomeShopMallModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCHomeDayWeekMonthListViewController : LCViewController

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) LCShoppingMallView *shoppingMallView;

@end

NS_ASSUME_NONNULL_END
