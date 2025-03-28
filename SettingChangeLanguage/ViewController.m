//
//  ViewController.m
//  SettingChangeLanguage
//
//  Created by lu on 2025/3/26.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = arc4random_color;//调用随机色
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *clzName = @"CLChangeLanguageController";
    Class clz = NSClassFromString(clzName);//将字符串转化成class
    UIViewController *viewController = [[clz alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];

}
@end
