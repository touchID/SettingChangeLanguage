//
//  LCHomeDayWeekMonthListViewController.m
//  RegulatoryBao
//
//  Created by luchao on 2019/9/25.
//  Copyright © 2019 xuemei. All rights reserved.
//

#import "LCHomeDayWeekMonthListViewController.h"
#import "LCTabBarContentView.h"
#import "LCJuanCenterPinTaiViewController.h"
#import "LCDaiBanShiYiViewController.h"
#import "UIViewController+LCHidden.h"
#import "GZMineViewController.h"
#import "LCHomeKeFuVC.h"
#import "LCHotelControlView.h"
#import "LCSendMsgView.h"
#import "LCShouQuanView.h"
#import "LCPhoneView.h"
#import "LCVIPSalesViewController.h"
#if TARGET_IPHONE_SIMULATOR
#else
#import "NECallViewController.h"
#endif
#import "SFHFKeychainUtils.h"
#import "LCAIHistoryViewController.h"
#import "LCPhoneViewController.h"
#import "LCStatisticalDataViewController.h"
#import "LCSuggesLiuYanViewController.h"
#import "LCSendMSGListViewController.h"
#import "LCShouQuanListViewController.h"
#import "LCPhoneBookViewController.h"
#import "LCCallHistoryViewController.h"

@interface LCHomeDayWeekMonthListViewController ()
<LCTabBarContentViewDataSource,LCTabBarContentViewDelegate,YBPopupMenuDelegate,NERtcCallKitDelegate>

@property (strong, nonatomic)  LCTabBarContentView *tabBarContentView;

@property (nonatomic,strong) LCStatisticalDataViewController *statisticalDataViewController;

@property (nonatomic,strong) LCDaiBanShiYiViewController *daiBanShiYiViewController;

@property (nonatomic,strong) GZMineViewController *mineViewController;

//客服内容页
@property (strong, nonatomic) LCHomeKeFuVC *homeKeFuVC;
//会员营销内容页
@property (strong, nonatomic) LCVIPSalesViewController *vipSalesVC;
//弹出框
@property (nonatomic, strong) zhPopupController *popupController;

@property (nonatomic, strong) zhPopupController *popupController01;

@property (nonatomic, strong) LCHotelControlView *curtainView;

//@property (nonatomic, strong) LCSendMsgView *sendMsgView;

@end

@implementation LCHomeDayWeekMonthListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    [self.navigationController setNavigationBarHidden:true animated:animated];
}

- (void)setupBackgroundBGView {
    UIImageView *view = [[UIImageView alloc] init];
    view.image = [UIImage imageNamed:@"27154149.jpg"];
    [self.view addSubview:view];
    [view sizeToFit];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(-0);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //监听呼叫过来的电话
        [[NERtcCallKit sharedInstance] addDelegate:self];
    });
    [self setupBackgroundBGView];
    //self.view.backgroundColor =
    _ThemeMgr.top_index = -1;
    
    [self.view addSubview:self.shoppingMallView];

//    [self setupshoppingMallUI];
    [self.shoppingMallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.height.mas_equalTo(89);
    }];

    self.navigationItem.title = @"首页";
//    NSArray *array = @[@"待办事宜",@"客服",@"会员营销",@"数组统计",@"系统设置"];
    NSArray *array = @[@"待办事宜",@"客服",@"系统设置"];
    self.array = array;
    self.shoppingMallView.top_button03.hidden = true;
    self.shoppingMallView.top_button04.hidden = true;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tabBarController.tabBar.translucent = NO;//设置为不半透明也可以解决灰色的

    [self.tabBarContentView reloadData];
    // 获取数量
//    NSInteger tabBarItemCount = self.tabBarContentView.tabBarItems.count;
//    @weakify(self)
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 构建
//        for (NSInteger i = 0; i < tabBarItemCount; i++) {
//            if (i == 4) {
//                @strongify(self)
//                UIButton *itemButton = self.tabBarContentView.tabBarItems[i];
//                [itemButton sendActionsForControlEvents:UIControlEventTouchUpInside];
//            }
//        }
//    });
}

- (LCTabBarContentView *)tabBarContentView{
    if (_tabBarContentView == nil) {
        _tabBarContentView = [LCTabBarContentView new];
        _tabBarContentView.frame = self.view.bounds;
        _tabBarContentView.tabBarTitleStyle = 3;
        _tabBarContentView.contentScrollView.backgroundColor = [UIColor clearColor];
//        _tabBarContentView.tabBarScrollView.backgroundColor = [UIColor clearColor];
        _tabBarContentView.isNoSelectAnimated = true;
        _tabBarContentView.dataSource = self;
        _tabBarContentView.delegate = self;
        [self.view addSubview:_tabBarContentView];
        [_tabBarContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shoppingMallView.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
    }
    return _tabBarContentView;
}

-(UIColor *)highlightColorForTabBarItemInTabBarContentView:(LCTabBarContentView *)tabBarContentView{
    return [UIColor yellowColor];//rgba(235, 82, 74 , 1);rgb(255, 186, 4);//
}
-(CGFloat)heightForTabBarInTabBarContentView:(LCTabBarContentView *)tabBarContentView{
    return 89;
}
-(UIColor *)colorForTabBarItemTextInTabBarContentView:(LCTabBarContentView *)tabBarContentView{
    return [UIColor whiteColor];//rgba(140, 140, 140, 1);
}
#pragma mark - LCTabBarContentViewDataSource -
/**
 放回当前控件需要多少个选项
 @param tabBarContentView 当前控件
 @return 返回选项个数
 */
- (NSInteger)numberOfItemsInTabBarContentView:(LCTabBarContentView *)tabBarContentView {
    //    return _count;
    return _array.count;
}
/**
 提供选项的标题
 @param tabBarContentView 当前控件
 @param index 标题索引
 @return 返回标题内容
 */
- (NSString *)tabBarContentView:(LCTabBarContentView *)tabBarContentView titleForItemAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%@",_array[index]];
//    return [NSString stringWithFormat:@"item %zd",index];
}
/**
 提供内容视图
 @param tabBarContentView 当前控件
 @param index 标题索引
 @return 内容视图
 */
- (UIView *)tabBarContentView:(LCTabBarContentView *)tabBarContentView contentViewAtIndex:(NSInteger)index {
    NSString *title = self.array[index];
    if ([title isEqualToString:@"待办事宜"]) {//第一个
        self.daiBanShiYiViewController = [[LCDaiBanShiYiViewController alloc] init];
        self.daiBanShiYiViewController.navigationItem.title = @"待办事宜";
        [self addChildViewController:self.daiBanShiYiViewController];
        return self.daiBanShiYiViewController.view;
    }
    if ([title isEqualToString:@"客服"]) {//第2个
        //客服首页
        self.homeKeFuVC = [LCHomeKeFuVC new];
        @weakify(self)
        self.homeKeFuVC.cellClickedBlock = ^(NSInteger index) {
            @strongify(self)
            [self exampleAtIndex:index];
        };
        [self addChildViewController:self.homeKeFuVC];
        return self.homeKeFuVC.view;
    }
    if ([title isEqualToString:@"会员营销"]) {//第3个
        //会员营销
        self.vipSalesVC = [LCVIPSalesViewController new];
//        @weakify(self)
//        self.homeKeFuVC.cellClickedBlock = ^(NSInteger index) {
//            @strongify(self)
//            [self exampleAtIndex:index];
//        };
        [self addChildViewController:self.vipSalesVC];
        return self.vipSalesVC.view;
    }
    if (index == 3) {//第4个
        self.statisticalDataViewController = [[LCStatisticalDataViewController alloc] init];
        [self addChildViewController:self.statisticalDataViewController];
        self.statisticalDataViewController.navigationItem.title = @"数据统计";
        return self.statisticalDataViewController.view;
    }
    //
    if ([title isEqualToString:@"系统设置"]) {//最后一个
        self.mineViewController = [[GZMineViewController alloc] init];
        self.mineViewController.navigationItem.title = @"系统设置";
        [self addChildViewController:self.mineViewController];
        return self.mineViewController.view;
    }
    
    self.statisticalDataViewController = [[LCStatisticalDataViewController alloc] init];
    self.statisticalDataViewController.view.backgroundColor = [UIColor whiteColor];
    self.statisticalDataViewController.view.alpha = 0.68;
    self.statisticalDataViewController.navigationItem.title = @"数据统计";
    [self addChildViewController:self.statisticalDataViewController];
    return self.statisticalDataViewController.view;
}

- (NSString *)getTitle:(NSArray *)array :(NSInteger)index {
//    NSLog(@"indexPath = %@", indexPath);
    if (array.count > index) {
        NSString *title = array[index];
//        NSLog(@"model.title = %@", model.title);
        return title;
    }else{
        return nil;
    }
}

#pragma mark -  dianji  -
/**
 当选中状态发生改变时回调
 
 @param tabBarContentView 当前控件
 @param index 选项下标
 */
- (void)tabBarContentView:(LCTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index {
    [self cherkIntefaceNetwork];
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LCSelectHomeTabBar" object:nil userInfo:nil];
    }
}

- (void)cherkIntefaceNetwork {
    if (_AccM.loginState == LoginStateNoOnline) {
        [LCUtils showLogin:self.view];
        return;
    }
}

- (LCShoppingMallView *)shoppingMallView {
    if (_shoppingMallView == nil) {
        _shoppingMallView = [[LCShoppingMallView alloc] init];
        _shoppingMallView.frame = CGRectMake(0, 0,XNWindowWidth, 89);
        for (NSInteger i = 0; i < 4; i++) {
            UIButton *shouQuanBtn = [_shoppingMallView viewWithTag:1000+i];
            [shouQuanBtn addTarget:self action:@selector(clickTopTaskList:) forControlEvents:UIControlEventTouchUpInside];
        }
        @weakify(self)
        [_shoppingMallView.touXiangIcon tapGesture:^(UIGestureRecognizer *ges) {
            @strongify(self)
            if (_AccM.loginState == LoginStateNoOnline) {
                [self popLogin];
            }else{
                [self imgClick];
            }
        }];
    }
    return _shoppingMallView;
}

- (void)popLogin{
    [LCUtils showLogin:self.view];
}

- (void)imgClick {
    CGPoint p = _shoppingMallView.touXiangIcon.center;
    p.y = p.y + _shoppingMallView.touXiangIcon.frame.size.height/2;
    [self showCustomPopupMenuWithPoint:p];
}
#define TITLES @[@"个人信息", @"退出"]
#define ICONS  @[@"motify",@"delete"]

- (void)showDarkPopupMenuWithPoint:(CGPoint)point
{
    [YBPopupMenu showAtPoint:point titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = NO;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.offset = 10;
        popupMenu.type = YBPopupMenuTypeDark;
        popupMenu.animationManager.style = YBPopupMenuAnimationStyleNone;
        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }];
}

- (void)showCustomPopupMenuWithPoint:(CGPoint)point
{
    [YBPopupMenu showAtPoint:point titles:TITLES icons:@[@"",@"top留言"] menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = YES;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.type = YBPopupMenuTypeDefault;
        popupMenu.cornerRadius = 8;
        popupMenu.rectCorner = UIRectCornerTopLeft| UIRectCornerTopRight | UIRectCornerBottomLeft| UIRectCornerBottomRight;
        popupMenu.tag = 1008;
//        //如果不加这句默认是 UITableViewCellSeparatorStyleNone 的
//        popupMenu.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }];
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    //推荐回调
    NSLog(@"点击了 %@ 选项",ybPopupMenu.titles[index]);
    if (index == 0) {
        NSString *clzName = @"GZPersonalDataViewController";
        Class clz = NSClassFromString(clzName);//将字符串转化成class
        UIViewController *viewController = [[clz alloc] init];
        clz = NSClassFromString(@"LCNavigationController");//将字符串转化成class
        UINavigationController *navController = [[clz alloc] initWithRootViewController:viewController];
        [self presentViewController:navController animated:true completion:nil];
    }else{
        NSString * myTokenStr = [@"" addStr:@""];
        BOOL f = [SFHFKeychainUtils storeUsername:@"sysToken" andPassword:myTokenStr forServiceName:[[NSBundle mainBundle] bundleIdentifier] updateExisting:YES error:nil];
        //从钥匙串中读取token
        if (f) {
            [LCUPInfoNetworking sharedInstance].parameters[@"Authorization"] = myTokenStr;
            _AccM.loginState = LoginStateNoOnline;
            [LCUtils clearLogin];
            [LCUtils showHome];
            [[NERtcCallKit sharedInstance] logout:^(NSError * _Nullable error) {
                NSLog(@"error = %@",error);
            }];
        }
    }
}

- (void)ybPopupMenuBeganDismiss:(YBPopupMenu *)ybPopupMenu {
    
}

- (void)clickTopTaskList:(UIButton *)sender {
    _ThemeMgr.top_index = sender.tag - 1000;
    if (sender.tag == 1000) {
        NSLog(@"授权");
        [self exampleAtIndex:0];
        self.shoppingMallView.top_button01.alpha = 1;
    }
    if (sender.tag == 1001) {
        NSLog(@"呼叫");
        self.shoppingMallView.top_button02.alpha = 1;
        [self exampleAtIndex:1];
    }
    if (sender.tag == 1002) {
        NSLog(@"续订");
        self.shoppingMallView.top_button03.alpha = 1;
        [self exampleAtIndex:7];
    }
    if (sender.tag == 1003) {
        NSLog(@"留言");
        self.shoppingMallView.top_button04.alpha = 1;
        [self exampleAtIndex:8];
    }
}

#pragma mark -  重置按钮样式 reset_top_button -
- (void)reset_top_button {
    self.shoppingMallView.top_button01.alpha = 0.71;
    self.shoppingMallView.top_button02.alpha = 0.71;
    self.shoppingMallView.top_button03.alpha = 0.71;
    self.shoppingMallView.top_button04.alpha = 0.71;
    
    _ThemeMgr.top_index = -1;
}

#pragma mark -  客服点击事件  -
//客服页面
- (void)exampleAtIndex:(NSInteger)index {
    if (_AccM.loginState == LoginStateNoOnline) {
        GZLoginViewController *loginVC = [[GZLoginViewController alloc]init];
        LCNavigationController *nv = [[LCNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nv animated:YES completion:nil];
        if (_ThemeMgr.kefu_index > -1) {
            _ThemeMgr.kefu_index = -1;
            [self.homeKeFuVC.mainCollectionView reloadData];
        }
        [self reset_top_button];
        return;
    }
    if (index == 0)//授权页面
    {
        NSString *title = @"";
        NSString *icon = @"";

        NSArray *array = [NSArray lc_arrayWithPlist:@"kefu.plist" andClassName:@"SHSHomeShopMallModel"];
        if (array.count > index) {
            if (array.count > 0) {
                SHSHomeShopMallModel *model = array[index];
                title = [@"" addStr:model.title];
                title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
                icon = [@"" addStr:model.icon];
            }
        }
        LCShouQuanListViewController *viewController = [[LCShouQuanListViewController alloc] init];
        viewController.navigationItem.title = title;
        viewController.tabBarItem.title = icon;
        @weakify(self)
        viewController.cancelClickedBlock = ^{
            @strongify(self)
            [self reset_top_button];
            if (_ThemeMgr.kefu_index > -1) {
                _ThemeMgr.kefu_index = -1;
                [self.homeKeFuVC.mainCollectionView reloadData];
            }
        };
//        Class clz = NSClassFromString(@"LCNavigationController");//将字符串转化成class
//        UINavigationController *navController = [[clz alloc] initWithRootViewController:viewController];
//        [self presentViewController:navController animated:true completion:nil];
        [self presentViewController:viewController animated:false completion:nil];

        return;
    }

    if (index == 3)//团客信息
    {
        NSString *title = @"";
        NSString *icon = @"";

        NSArray *array = [NSArray lc_arrayWithPlist:@"kefu.plist" andClassName:@"SHSHomeShopMallModel"];
        if (array.count > index) {
            if (array.count > 0) {
                SHSHomeShopMallModel *model = array[index];
                title = [@"" addStr:model.title];
                title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
                icon = [@"" addStr:model.icon];
            }
        }
        LCSendMSGListViewController *viewController = [[LCSendMSGListViewController alloc] init];
        viewController.navigationItem.title = title;
        viewController.tabBarItem.title = icon;
        @weakify(self)
        viewController.cancelClickedBlock = ^{
            @strongify(self)
            if (_ThemeMgr.kefu_index > -1) {
                _ThemeMgr.kefu_index = -1;
                [self.homeKeFuVC.mainCollectionView reloadData];
            }
        };
//        Class clz = NSClassFromString(@"LCNavigationController");//将字符串转化成class
//        UINavigationController *navController = [[clz alloc] initWithRootViewController:viewController];
//        [self presentViewController:navController animated:true completion:nil];
        [self presentViewController:viewController animated:false completion:nil];

        return;
    }
    if (index == 7 || index == 4)//建议和留言本
    {
        NSString *title = @"";
        NSString *icon = @"";

        NSArray *array = [NSArray lc_arrayWithPlist:@"kefu.plist" andClassName:@"SHSHomeShopMallModel"];
        if (array.count > index) {
            if (array.count > 0) {
                SHSHomeShopMallModel *model = array[index];
                title = [@"" addStr:model.title];
                title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
                icon = [@"" addStr:model.icon];
            }
        }
        LCSuggesLiuYanViewController *viewController = [[LCSuggesLiuYanViewController alloc] init];
        viewController.navigationItem.title = title;
        viewController.tabBarItem.title = icon;
        @weakify(self)
        viewController.cancelClickedBlock = ^{
            @strongify(self)
            [self reset_top_button];
            if (_ThemeMgr.kefu_index > -1) {
                _ThemeMgr.kefu_index = -1;
                [self.homeKeFuVC.mainCollectionView reloadData];
            }
        };
//        Class clz = NSClassFromString(@"LCNavigationController");//将字符串转化成class
//        UINavigationController *navController = [[clz alloc] initWithRootViewController:viewController];
//        [self presentViewController:navController animated:true completion:nil];
        [self presentViewController:viewController animated:false completion:nil];

        return;
    }

    
    if (index == 8)//ai对话记录
    {
        NSString *title = @"";
        NSString *icon = @"";

        NSArray *array = [NSArray lc_arrayWithPlist:@"kefu.plist" andClassName:@"SHSHomeShopMallModel"];
        if (array.count > index) {
            if (array.count > 0) {
                SHSHomeShopMallModel *model = array[index];
                title = [@"" addStr:model.title];
                title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
                icon = [@"" addStr:model.icon];
            }
        }
        LCAIHistoryViewController *viewController = [[LCAIHistoryViewController alloc] init];
        viewController.navigationItem.title = title;
        viewController.tabBarItem.title = icon;
        @weakify(self)
        viewController.cancelClickedBlock = ^{
            @strongify(self)
            if (_ThemeMgr.kefu_index > -1) {
                _ThemeMgr.kefu_index = -1;
                [self.homeKeFuVC.mainCollectionView reloadData];
            }
        };
//        Class clz = NSClassFromString(@"LCNavigationController");//将字符串转化成class
//        UINavigationController *navController = [[clz alloc] initWithRootViewController:viewController];
//        [self presentViewController:navController animated:true completion:nil];
        [self presentViewController:viewController animated:false completion:nil];

        return;
    }
    
    if (index == 10) {//呼叫
        NSString *title = @"";
        NSString *icon = @"";

        NSArray *array = [NSArray lc_arrayWithPlist:@"kefu.plist" andClassName:@"SHSHomeShopMallModel"];
        if (array.count > index) {
            if (array.count > 0) {
                SHSHomeShopMallModel *model = array[index];
                title = [@"" addStr:model.title];
                title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
                icon = [@"" addStr:model.icon];
            }
        }
        LCPhoneBookViewController *viewController = [[LCPhoneBookViewController alloc] init];
        viewController.navigationItem.title = title;
        viewController.tabBarItem.title = icon;
//        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;//UIModalPresentationFullScreen 不透明
        //[viewController.styleButton addTarget:self action:@selector(didCall:) forControlEvents:UIControlEventTouchUpInside];
        @weakify(self)
        viewController.cancelClickedBlock = ^{
            @strongify(self)
            if (_ThemeMgr.kefu_index > -1) {
                _ThemeMgr.kefu_index = -1;
                [self.homeKeFuVC.mainCollectionView reloadData];
            }
            [self reset_top_button];

        };
//        Class clz = NSClassFromString(@"LCNavigationController");//将字符串转化成class
//        UINavigationController *navController = [[clz alloc] initWithRootViewController:viewController];
//        [self presentViewController:navController animated:false completion:nil];
        [self presentViewController:viewController animated:false completion:nil];
        return;
    }
    if (index == 1) {//呼叫记录
        NSString *title = @"";
        NSString *icon = @"";

        NSArray *array = [NSArray lc_arrayWithPlist:@"kefu.plist" andClassName:@"SHSHomeShopMallModel"];
        if (array.count > index) {
            if (array.count > 0) {
                SHSHomeShopMallModel *model = array[index];
                title = [@"" addStr:model.title];
                title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
                icon = [@"" addStr:model.icon];
            }
        }
//        LCCallHistoryViewController *viewController = [[LCCallHistoryViewController alloc] init];
        //呼叫测试
        LCPhoneViewController *viewController = [[LCPhoneViewController alloc] init];
        viewController.navigationItem.title = title;
        viewController.tabBarItem.title = icon;
//        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;//UIModalPresentationFullScreen 不透明
        //[viewController.styleButton addTarget:self action:@selector(didCall:) forControlEvents:UIControlEventTouchUpInside];
        @weakify(self)
        viewController.cancelClickedBlock = ^{
            @strongify(self)
            if (_ThemeMgr.kefu_index > -1) {
                _ThemeMgr.kefu_index = -1;
                [self.homeKeFuVC.mainCollectionView reloadData];
            }
        };
        [self presentViewController:viewController animated:false completion:nil];
        return;
    }

//    NSString *clzName = @"LCCallViewController";
//    Class clz = NSClassFromString(clzName);//将字符串转化成class
//    UIViewController *viewController = [[clz alloc] init];
//    //UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MobileLogin" bundle:nil];
//    //UIViewController *controller = [sb instantiateInitialViewController];
////    [self.navigationController pushViewController:viewController animated:YES];
//    self.definesPresentationContext = YES;
//    viewController.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.68];
//    viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;//关键代码
//
//    [self presentViewController:viewController animated:false completion:nil];//:viewController animated:YES];
//    return;
    //
    [self setupPopupControllerWithIndex:index];
    [self.popupController showInView:self.view.window duration:0.55 bounced:YES completion:nil];
    NSArray *array = [NSArray lc_arrayWithPlist:@"kefu.plist" andClassName:@"SHSHomeShopMallModel"];
    if (array.count > index) {
        self.curtainView.alertHeaderTableView.shopHeaderImageView.image = [UIImage imageNamed:@"商品详情轮播_"];
        NSString *title = @"";
        if (array.count > 0) {
            SHSHomeShopMallModel *model = array[index];
            title = [@"" addStr:model.title];
            title = [title stringByReplacingOccurrencesOfString:@" " withString:@""];
            self.curtainView.alertHeaderTableView.shopHeaderImageView
                .image = [UIImage imageNamed:[@"" addStr:model.icon] ];
        }
        self.curtainView.alertHeaderTableView.kucunLabel.text = title;
    }
}
#pragma mark -  其他弹出页面  -
- (zhPopupController *)setupPopupControllerWithIndex:(NSInteger)index  {
    //if (!_popupController)
    {
        LCHotelControlView *curtainView;
        CGFloat popViewWidth = XNWindowWidth*0.7;
        CGFloat popViewHeight = 488;
        CGFloat offsetSpacing = 0;
        if (index == 0) {
            curtainView = [self setupShouQuanView];
            popViewHeight = XNWindowHeight-200;
        }else if(index == 1){
            curtainView = [self setupPhoneView];
            offsetSpacing = -30;
        }
        else
        if (index == 4) {
            curtainView = [self setupSendMsgView];
            popViewHeight = XNWindowHeight-200;
        }else{
            curtainView = [[LCHotelControlView alloc] init];
            [curtainView intefaceNetwork];
            popViewHeight = XNWindowHeight-200;
        }
        _curtainView = curtainView;
        curtainView.radius = 6;
        __weak typeof(self) w_self = self;
        curtainView.cancelClickedBlock = ^{
            [w_self.popupController dismiss];
        };
        
        _popupController = [[zhPopupController alloc] initWithView:curtainView size:CGSizeMake( popViewWidth, popViewHeight)];
        _popupController.offsetSpacing = offsetSpacing;//-30;
        _popupController.willPresentBlock = ^(zhPopupController * _Nonnull popupController) {
        };
        @weakify(self)
        _popupController.willDismissBlock = ^(zhPopupController * _Nonnull popupController) {
            @strongify(self)
            if (_ThemeMgr.kefu_index > -1) {
                _ThemeMgr.kefu_index = -1;
                [self.homeKeFuVC.mainCollectionView reloadData];
            }
            [self reset_top_button];

        };
    }
    return _popupController;
}

- (LCPhoneView *)setupPhoneView {
    LCPhoneView *sendMsgView = [[LCPhoneView alloc] init];
//    [sendMsgView.styleButton addTarget:self action:@selector(didCall:) forControlEvents:UIControlEventTouchUpInside];
    //授权字体稍大
    sendMsgView.alertHeaderTableView.kucunLabel.font = FONT_30;
    return sendMsgView;
}

#pragma mark - NERtcVideoCallDelegate
- (void)onInvited:(NSString *)invitor
          userIDs:(NSArray<NSString *> *)userIDs
      isFromGroup:(BOOL)isFromGroup
          groupID:(nullable NSString *)groupID
             type:(NERtcCallType)type
       attachment:(nullable NSString *)attachment {
    NSLog(@"menu controoler onInvited");
    [NIMSDK.sharedSDK.userManager fetchUserInfos:@[invitor] completion:^(NSArray<NIMUser *> * _Nullable users, NSError * _Nullable error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.description];
            return;
        }else {
            NIMUser *imUser = users.firstObject;
            NEUser *remoteUser = [[NEUser alloc] init];
            remoteUser.imAccid = imUser.userId;
            remoteUser.mobile = imUser.userInfo.mobile;
            remoteUser.avatar = imUser.userInfo.avatarUrl;
            remoteUser.nickName = imUser.userInfo.nickName;
            //[SVProgressHUD showWithStatus:[@"" addStr:remoteUser.nickName]];
            remoteUser.call_state = @"来电";
//            NSLog(@"menu remoteUser= %@",remoteUser);
            NSDate *current_time = NSDate.new;
            remoteUser.call_date = current_time;
            remoteUser.call_date_str = current_time.WT_YYYYMMddHHmmss;
//        remoteUser.room_no = self.navigationItem.title;
            [WHCSqlite insert:remoteUser];

            [self reCall:remoteUser];
        }
    }];
    
}

- (void)reCall:(NEUser *)remoteUser {
    if ([remoteUser.imAccid isEqualToString:_AccM.accountInfoModel.yunxinImAccid]) {
        [SVProgressHUD showErrorWithStatus:@"呼叫用户不可以是自己哦"];
        return ;
    }
    
    NSDictionary *remoteUserJson = [remoteUser yy_modelToJSONObject];
    NEUser *user = [NEUser yy_modelWithJSON:[LCUtils setupNERemoteUser:remoteUserJson]];
    if ([LCUtils showNoNetworkError]) {
        return;
    }
    //me
    NELocalUser *userModel = [NELocalUser yy_modelWithJSON:[LCUtils setupNELocalUser:nil]];
    
    NECallViewController *callVC = [[NECallViewController alloc] init];
    callVC.localUser = userModel;
    callVC.remoteUser = user;
    callVC.callType = NERtcCallTypeAudio;//NERtcCallTypeAudio;
    callVC.status = NERtcCallStatusCalled;
    
    callVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    //任何页面是否都可以弹出页面
    [[self topViewController] presentViewController:callVC animated:YES completion:nil];
    [LCUtils lcLocalPush:0.1 :@"有客人电话!" :@"" :[@"" addStr:@"房间 有来电"]];
}

- (LCShouQuanView *)setupShouQuanView {
    LCShouQuanView *sendMsgView = [[LCShouQuanView alloc] init];
    //授权字体稍大
    sendMsgView.alertHeaderTableView.kucunLabel.font = FONT_30;
    [sendMsgView shouQuanListData];
    return sendMsgView;
}

- (LCSendMsgView *)setupSendMsgView {
    LCSendMsgView *sendMsgView = [[LCSendMsgView alloc] init];
    [sendMsgView tuanKeListData];
    return sendMsgView;
}

//- (void)shouquan {
//    CGRect rect = CGRectMake(0, 0, 501, 457);
//    LCAlertMaiMaiMaiView *pView = [[LCAlertMaiMaiMaiView alloc] initWithFrame:rect];
//    pView.radius = 6;
//    @weakify(self)
//    @weakify(pView)
//    pView.saveClickedBlock = ^{
//        @strongify(self)
//        @strongify(pView)
//
//        [self.popupController01 dismiss];
//    };
////    pView.specArray = self.specArray;
////    pView.shopDetileModel = self.shopDetileModel;
////    pView.maiMaiMaiType = self.maiMaiMaiType;
//    pView.cancelClickedBlock = ^{
//        @strongify(self)
//        [self.popupController01 dismiss];
//    };
////    self.popupController01 = [zhPopupController new];
//    self.popupController01 = [[zhPopupController alloc] initWithView:pView size:rect.size];//CGSizeMake( XNWindowWidth*0.7, 388)];
//    self.popupController01.layoutType = zhPopupLayoutTypeCenter;
//    [self.popupController01 showInView:self.view.window duration:0.75 bounced:YES completion:nil];
////:pView];
//}

@end
