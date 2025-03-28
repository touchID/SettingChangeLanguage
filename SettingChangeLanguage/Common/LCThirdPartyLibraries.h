//
//  LCThirdPartyLibraries.h
//  SettingChangeLanguage
//
//  Created by lu on 2025/3/27.
//

#ifndef LCThirdPartyLibraries_h
#define LCThirdPartyLibraries_h


#import "JKFoundation/JKFoundation.h"//JKFoundation
#import "WTConst.h"//JKFoundation
#import "Masonry.h"
#import "LCUtils.h"
#import "LCObject.h"
#import "LCViewController.h"
#import "EXTScope.h"//@weakify @strongify 的实现
#import "SVProgressHUD.h"

// 判断 iPad
#define DX_UI_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断iPhone12 | 12Pro
#define DX_Is_iPhone12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !DX_UI_IS_IPAD : NO)

//判断iPhone12 Pro Max
#define DX_Is_iPhone12_ProMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) && !DX_UI_IS_IPAD : NO)

#define iPhone12_All2 (DX_Is_iPhone12 || DX_Is_iPhone12_ProMax)

// 判断是否是iPhone X 或者12

#define iPhoneX ((([[UIScreen mainScreen] bounds].size.height) == 812.0f || ([[UIScreen mainScreen] bounds].size.height) == 896.0f) || iPhone12_All2)

#define XNWindowWidth ([[UIScreen mainScreen] bounds].size.width)

#define XNWindowHeight ([[UIScreen mainScreen] bounds].size.height)

#define NoNetwork _S_(@"网络出错啦,请检查网络!")
#define NoServices _S_(@"后台服务升级中,请稍后再试!")

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define arc4random_color RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

#endif /* LCThirdPartyLibraries_h */
