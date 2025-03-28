//
//  SettingViewController.m
//  CLDemo
//
//  Created by AUG on 2018/11/7.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import "CLChangeLanguageController.h"
//#import "NSBundle+CLLanguage.h"

@interface CLChangeLanguageController ()
<UITableViewDelegate, UITableViewDataSource>

/**tableView*/
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger currentLanguageNum;

@end

@implementation CLChangeLanguageController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.nvType = 3;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.nv3View.mas_bottom);
    }];
}

- (void)loadData{
    self.navigationItem.title = _S_(@"切换语言");
    
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppLanguagesKey"];
    // 设置默认语言
    if ([currentLanguage isEqualToString:@"zh"]) {
        self.currentLanguageNum = 1;
    }else
    if ([currentLanguage isEqualToString:@"cht"]) {
        self.currentLanguageNum = 2;
    }else
    if ([currentLanguage isEqualToString:@"en"]) {
        self.currentLanguageNum = 3;
    }else
    if ([currentLanguage isEqualToString:@"fra"]) {
        self.currentLanguageNum = 4;
    }else
    if ([currentLanguage isEqualToString:@"spa"]) {
        self.currentLanguageNum = 5;
        //增加日语语言 
    }else
    if ([[NSLocale preferredLanguages] containsObject:@"ja"]) {
        self.currentLanguageNum = 6;
    }else {
        //默认 跟随系统语言
        self.currentLanguageNum = 0;
    }
   

}


#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }

//     Configure the cell...
//    用户没有自己设置的语言，则跟随手机系统
    NSInteger isLanguage = self.currentLanguageNum;
    if (isLanguage == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = _S_(@"跟随系统");
        cell.textLabel.text = NSLocalizedString(@"跟随系统", nil);
    }else if (indexPath.row == 1) {
        cell.detailTextLabel.text = _S_(@"简体中文");
        cell.textLabel.text = NSLocalizedString(@"简体中文", nil);
    }
    else if (indexPath.row == 2) {
        cell.detailTextLabel.text = _S_(@"繁体中文");
        cell.textLabel.text = NSLocalizedString(@"繁体中文", nil);
    }
    else if (indexPath.row == 3) {
        cell.detailTextLabel.text = _S_(@"英语");
        cell.textLabel.text = NSLocalizedString(@"英语", nil);
    }
    else if (indexPath.row == 4) {
        cell.detailTextLabel.text = _S_(@"法语");
        cell.textLabel.text = NSLocalizedString(@"法语", nil);
    }
    else if (indexPath.row == 5) {
        cell.detailTextLabel.text = _S_(@"西班牙语");
        cell.textLabel.text = NSLocalizedString(@"西班牙语", nil);
    }
    else if (indexPath.row == 6) {
        cell.detailTextLabel.text = _S_(@"日语");
        cell.textLabel.text = NSLocalizedString(@"日语", nil);
    }
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        return;
    }
    UIButton *button = [[UIButton alloc] init];
    button.tag = indexPath.row;
    [self clickExit:button];

    @weakify(tableView)
    self.changeLanguageBlock = ^{
        @strongify(tableView)
        for (UITableViewCell *acell in tableView.visibleCells) {
            acell.accessoryType = acell == cell ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        }
        [SVProgressHUD show];
        [SVProgressHUD dismissWithDelay:0.5];
        if (indexPath.row == 0) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AppLanguagesKey"];
        } else if (indexPath.row == 1) {
            [[NSUserDefaults standardUserDefaults] setObject:@"zh" forKey:@"AppLanguagesKey"];
        } else if (indexPath.row == 2) {
            [[NSUserDefaults standardUserDefaults] setObject:@"cht" forKey:@"AppLanguagesKey"];
        } else if (indexPath.row == 3) {
            [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"AppLanguagesKey"];
        } else if (indexPath.row == 4) {
            [[NSUserDefaults standardUserDefaults] setObject:@"fra" forKey:@"AppLanguagesKey"];
        } else if (indexPath.row == 5) {
            [[NSUserDefaults standardUserDefaults] setObject:@"spa" forKey:@"AppLanguagesKey"];
        }
        else if (indexPath.row == 6) {
            [[NSUserDefaults standardUserDefaults] setObject:@"ja" forKey:@"AppLanguagesKey"];
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    };
}
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)clickExit:(UIButton *)send {
    NSString *tishiStr = @"确定要更换语言吗?";
    NSString *okStr = @"确定";
    NSString *cancelStr = @"取消";
    NSString *currentLanguage = @"";
    if (send.tag == 0) {
        currentLanguage = [[NSLocale preferredLanguages] firstObject];
    } else if (send.tag == 1) {
        //简体
        currentLanguage = @"zh-Hans";
    } else if (send.tag == 2) {
        //繁体
        currentLanguage = @"zh-Hant";
    } else if (send.tag == 3) {
        //英文
        currentLanguage = @"en";
    } else if (send.tag == 4) {
        //法语
        currentLanguage = @"fr";
    } else if (send.tag == 5) {
        //西班牙语
        currentLanguage = @"es";
    }
    else if (send.tag == 6) {
        //日语
        currentLanguage = @"ja";
    }
    // 点击的当前语言
    NSBundle *currentLanguageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:currentLanguage ofType:@"lproj"]];
    if (currentLanguageBundle == nil) {
        if ([currentLanguage containsString:@"zh-Hans"]) {
            currentLanguage = @"zh-Hans";
        }else
        if ([currentLanguage hasPrefix:@"zh-HK"] ||[currentLanguage containsString:@"zh-Hant"]) {
            currentLanguage = @"zh-Hant";
        }else
        if ([currentLanguage isEqualToString:@"en"] || [currentLanguage hasPrefix:@"en-"]) {
            currentLanguage = @"en";
        }else
        if ([currentLanguage hasPrefix:@"fr-"]) {
            currentLanguage = @"fr";
        }else
        if ([currentLanguage hasPrefix:@"es-"]) {
            currentLanguage = @"es";

        }else
        if ([currentLanguage hasPrefix:@"ja-"]) {
            //增加日语语言
            currentLanguage = @"ja";

        }else {
            currentLanguage = @"en";
        }
        currentLanguageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:currentLanguage ofType:@"lproj"]];
    }
    tishiStr = [currentLanguageBundle localizedStringForKey:tishiStr value:nil table:@"Localizable"];
    tishiStr = [tishiStr addStr:@"\n"];

    okStr = [currentLanguageBundle localizedStringForKey:okStr value:nil table:@"Localizable"];
    cancelStr = [currentLanguageBundle localizedStringForKey:cancelStr value:nil table:@"Localizable"];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_S_(@"确定要更换语言吗?") message:@"" preferredStyle:UIAlertControllerStyleAlert];

    @weakify(self)
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@ (%@)",[@"" addStr:okStr],_S_(@"确定")] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self)
        NSLog(@"点击了确定");
        [self clickedButtonAtIndex:1];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@ (%@)",[@"" addStr:cancelStr],_S_(@"取消")] style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}
- (void)clickedButtonAtIndex:(NSInteger)buttonIndex
{
    {
        if (buttonIndex == 1) {
            //点击更换
            if (self.changeLanguageBlock != nil) {
                self.changeLanguageBlock();
                @weakify(self)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    @strongify(self)
                    [self loadData];
                    [self.tableView reloadData];
                });
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self refreshRootViewController];
            });
        }
    }
}
- (void)refreshRootViewController {
//    //创建新的根控制器
//    CLTabbarController *tabbarController = [[CLTabbarController alloc] init];
//    tabbarController.selectedIndex = 0;
//    UINavigationController *navigationController = tabbarController.selectedViewController;
//    NSMutableArray *viewControllers = navigationController.viewControllers.mutableCopy;
//    //取出我的页面，提前加载，解决返回按钮不变化
//    CLHomepageController *me = (CLHomepageController *)[viewControllers firstObject];
//    [me loadViewIfNeeded];
//    //新建设置语言页面
//    CLChangeLanguageController *languageController = [[CLChangeLanguageController alloc] init];
//    languageController.hidesBottomBarWhenPushed = YES;
//    [viewControllers addObject:languageController];
//    //解决奇怪的动画bug。
    dispatch_async(dispatch_get_main_queue(), ^{
        //[LCUtils showHome];
        NSLog(@"已切换到语言 ");
    });
}

- (void)exitApplication{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector"
    //运行一个不存在的方法,退出界面更加圆滑
    [self performSelector:@selector(notExistCall)];
    //abort();
    //exit(1);
    #pragma clang diagnostic pop
}

- (UITableView *) tableView{
    if (_tableView == nil){
        _tableView = [[UITableView alloc] init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"语言切换页面销毁了");
    NSLog(@"__func__dealloc = %s", __func__);
}

@end
