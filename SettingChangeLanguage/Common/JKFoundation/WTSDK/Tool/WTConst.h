
//我要导入的东西哈哈哈哈哈😊😊😊😊😊😊😊😊😊😊😊😊😊
//category
#import "CALayer+WT.h"
#import "NSArray+WT.h"
#import "NSDate+WT.h"
#import "NSString+WT.h"
#import "NSTimer+WT.h"
#import "UIBarButtonItem+WT.h"
#import "UIImage+WT.h"
#import "UILabel+WT.h"
#import "UITextView+WT.h"
#import "UIView+WT.h"
#import "UIViewController+WT.h"

//tool
#import "WTUtility.h"

//View 😙😙😙😙😙😙😙😙😙😙
#import "UIButton+WT.h"
#import "WTTextField.h"
#import "WTTextView.h"
//导入的东西 END😊😊😊😊😊😊😊😊😊😊😊😊😊😊

//获取最上层的window
#define WTTopWindow [[UIApplication sharedApplication].windows lastObject]

#define WTAppDelegate ((AppDelegate *) [[UIApplication sharedApplication] delegate])
#define WTUserDefaults [NSUserDefaults standardUserDefaults]

#define KStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KNavBarHeight 44.0
#define KTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define KTopHeight (KStatusBarHeight + KNavBarHeight)

//状态栏高度
#define WTStatus_Bar_Height [[UIApplication sharedApplication] statusBarFrame].size.height
//NavBar高度
#define WTNavigation_Bar_Height 44
//状态栏 ＋ 导航栏 高度
#define WTStatus_And_Navigation_Height ((WTStatus_Bar_Height) + (WTNavigation_Bar_Height))
//底部tab高度
#define WTTab_Bar_Height ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#define LCPushStoryboard(__sbString) [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:__sbString bundle:nil] instantiateInitialViewController] animated:YES]

#define LCISPushLogin NSString *usercode = [[NSUserDefaults standardUserDefaults] objectForKey:@"usercode"];if([(usercode ? usercode : @"") isEqualToString:@""]){ LCPushStoryboard(@"AccLogin"); return; }

//通知中心
#define WTNotificationCenter [NSNotificationCenter defaultCenter]
#define WTScreenHeight [UIScreen mainScreen].bounds.size.height
#define WTScreenWidth [UIScreen mainScreen].bounds.size.width
#define WTDeviceHeight [UIScreen mainScreen].bounds.size.height
#define WTDeviceWidth [UIScreen mainScreen].bounds.size.width
#define PI 3.14159265358979323846

#define WTStrIsEmpty(str) ([str isKindOfClass:[NSNull class]] || [str length] < 1 ? YES : NO || [str isEqualToString:@"(null)"] || [str isEqualToString:@"null"])

#define WTAlphaColor(r, g, b, a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define WTHexColor(X) [UIColor colorWithRed:((float) ((X & 0xFF0000) >> 16)) / 255.0 green:((float) ((X & 0xFF00) >> 8)) / 255.0 blue:((float) (X & 0xFF)) / 255.0 alpha:1.0]
#define WTHexColorA(X, A) [UIColor colorWithRed:((float) ((X & 0xFF0000) >> 16)) / 255.0 green:((float) ((X & 0xFF00) >> 8)) / 255.0 blue:((float) (X & 0xFF)) / 255.0 alpha:A]

// 是否为iOS9,获得系统版本
#define WTIOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

#define iPhone5_Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus_Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONEX_SCREEN ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO) // 375 * 812

