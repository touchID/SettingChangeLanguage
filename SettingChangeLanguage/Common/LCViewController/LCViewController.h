//
//  LCViewController.h
//  MTDiffProject
//
//  Created by EDZ on 2019/7/19.
//  Copyright © 2019 LC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCViewController : UIViewController

@property (nonatomic, strong) UIView *nv3View;

@property(nonatomic,copy) NSString *className;

@property (nonatomic, assign) NSInteger backBtnType;

@property (nonatomic, assign) NSInteger nvType;

@property(strong, nonatomic) UIImage *shadowImage;//导航栏的线

@property (nonatomic,strong) UILabel *titlabel;

@property (nonatomic,strong) UITableView *default_tableView;//
//默认 UITableViewStyleGrouped 0
@property (nonatomic,assign) UITableViewStyle tableViewStyle;
//UITableViewStylePlain 1

@property (nonatomic,copy) NSString *identifier1;//
@property (nonatomic,copy) NSString *identifier2;//
@property (nonatomic,copy) NSString *identifier3;//
@property (nonatomic,copy) NSString *identifier4;//
@property (nonatomic,copy) NSString *identifier5;//
@property (nonatomic,copy) NSString *identifier6;//
@property (nonatomic,copy) NSString *identifier7;//
@property (nonatomic,copy) NSString *identifier8;//
@property (nonatomic,copy) NSString *identifier9;//


//修改UITableView的cell的线
- (void)lc_setupUITableViewCellXian;

@end

NS_ASSUME_NONNULL_END
