//
//  LCViewController.m
//  MTDiffProject
//
//  Created by EDZ on 2019/7/19.
//  Copyright © 2019 LC. All rights reserved.
//

#import "LCViewController.h"
#import "UIColor+Expanded.h"

@interface LCViewController ()

@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation LCViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.nvType == 1 || self.nvType == 2 || self.nvType == 3 || self.nvType >= 4) {
        self.navigationController.delegate = self;
        [self.navigationController setNavigationBarHidden:true animated:animated];//返回导航隐藏bug
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
#ifdef DEBUG
    self.className = [NSString stringWithFormat:@"%@",[self topViewController].class];
    if (self.className) {
        NSLog(@"(百度统计)Start = %@",self.className);
    }
#else
//        [[BaiduMobStat defaultStat] pageviewStartWithName:self.className];
#endif
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
#ifdef DEBUG
    if (self.className) {
        NSLog(@"(百度统计)End = %@", self.className);
    }
#else
//        [[BaiduMobStat defaultStat] pageviewEndWithName:self.className];
#endif
}

- (void)dealloc {
    //[SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"[UIScreen safeInsets] = %f", [UIScreen safeInsets].top);
//    NSLog(@"[UIScreen safeInsets] = %f", [UIScreen safeInsets].bottom);
//    NSLog(@"[UIScreen safeInsets] = %f", [UIScreen safeInsets].left);
//    NSLog(@"[UIScreen safeInsets] = %f", [UIScreen safeInsets].right);

    if (self.nvType == 3){
        [self.view addSubview:self.nv3View];
        [LCUtils debug:_nv3View];
        [self.nv3View mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            if (iPhoneX) {
                make.top.equalTo(self.view.mas_top).offset(0);
            }else{
                make.top.equalTo(self.view.mas_top).offset(0);
            }
            make.height.mas_equalTo(iPhoneX?(84+20):84);
        }];
    }
    
    if (_backBtnType == 0 || _backBtnType == 1 || _backBtnType == 2 || _backBtnType == 3) {
        [self setLeftBar];
    }
    //self.view.backgroundColor = RGBColor(236, 236, 236);
    self.view.backgroundColor = [UIColor defaultBackGroundColor];
}

- (void)setLeftBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStyleDone target:self action:@selector(left_button_event:)];
}

- (void)left_button_event:(UIButton *)sender {
    if (_backBtnType == 0) {
        [self.navigationController popViewControllerAnimated:true];
    }else if (_backBtnType == 2) {
        [self.navigationController popToRootViewControllerAnimated:true];
    }else if (_backBtnType == 3) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

//- (UIButton *)set_leftButton
//{
//    //    if (self.type == 1) {
//    //        return nil;
//    //    }
//    return self.backBtn;
//}
//#pragma mark - Getter
//-(UIButton *)backBtn
//{
//    if (_backBtn == nil) {
//        //        _backBtn = [UIButton GZ_textButton:nil selectTitle:nil titleColor:nil font:0 ImageButton:@"fanhui_"];
//        _backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
//    }
//    return _backBtn;
//}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (void)getShowVCName{
    NSLog(@"[self topViewController] = %@", [self topViewController]);
    //    if ([[self topViewController] isKindOfClass:[clz class]]) {
}
//修改UITableView的cell的线
- (void)lc_setupUITableViewCellXian {
    self.default_tableView.separatorColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    self.default_tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //        self.default_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (UITableView *)default_tableView {
    if (_default_tableView == nil) {
        _default_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:-_tableViewStyle+1];
        _default_tableView.estimatedRowHeight = 0;
        _default_tableView.estimatedSectionFooterHeight = 0;
        _default_tableView.estimatedSectionHeaderHeight = 0;
        _default_tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_default_tableView];
    }
    return _default_tableView;
////        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, XNWindowWidth, XNWindowHeight-TAB_BAR_HEIGHT-NAVIGATION_BAR_HEIGHT) style:UITableViewStyleGrouped];
}


- (UIView *)nv3View {//普通导航栏样式
    if (_nv3View == nil) {
        _nv3View = [[UIView alloc] init];
    }
    return _nv3View;
}

- (NSString *)identifier1{
    if (_identifier1 == nil) {
     _identifier1 = @"identifier1";
    }
    return _identifier1;
}

- (NSString *)identifier2{
    if (_identifier2 == nil) {
     _identifier2 = @"identifier2";
    }
    return _identifier2;
}

- (NSString *)identifier3{
    if (_identifier3 == nil) {
     _identifier3 = @"identifier3";
    }
    return _identifier3;
}

- (NSString *)identifier4{
    if (_identifier4 == nil) {
     _identifier4 = @"identifier4";
    }
    return _identifier4;
}

- (NSString *)identifier5{
    if (_identifier5 == nil) {
     _identifier5 = @"identifier5";
    }
    return _identifier5;
}

- (NSString *)identifier6{
    if (_identifier6 == nil) {
     _identifier6 = @"identifier6";
    }
    return _identifier6;
}

- (NSString *)identifier7{
    if (_identifier7 == nil) {
     _identifier7 = @"identifier7";
    }
    return _identifier7;
}

- (NSString *)identifier8{
    if (_identifier8 == nil) {
     _identifier8 = @"identifier8";
    }
    return _identifier8;
}

- (NSString *)identifier9{
    if (_identifier9 == nil) {
     _identifier9 = @"identifier9";
    }
    return _identifier9;
}

@end
