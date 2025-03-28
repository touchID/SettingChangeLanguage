//
//  ZSD_ClassNameHeader.h
//  SHSR
//
//  Created by 赵少丹 on 2019/12/1.
//  Copyright © 2019 赵少丹. All rights reserved.
//

#ifndef ZSD_ClassNameHeader_h
#define ZSD_ClassNameHeader_h

#pragma mark -- 基类
#import "LCObject.h"

#pragma mark -- 用户model
#import "LCAccountInfoModel.h"

#pragma mark -- 聊天
#import <RongIMKit/RongIMKit.h>

#pragma mark -- 第三方类
#import "YBPopupMenu.h"//弹出框

#pragma mark -- 类别
#import "LCQuitView.h"
#import "UIView+ZKExtension.h"
#import "UIView+ViewController.h"
#import "UIColor+Hex.h"
#import "UIButton+LXMImagePosition.h"
#import "MBProgressHUD+HUD.h"
#import "ZZUITextView+Placeholder.h"
#import "UIButton+CZAddition.h"
#import "UIButton+ImageTitleSpacing.h"
#import "UIView+removeAllSubviews.h"
#import "UIButton+WebCache.h"
#import "YJProgressHUD.h"
#import "WTConst.h"

#pragma mark -- 第三方类
//#import "OpenInstallSDK.h"
#import "JPViewController.h"
#import <Bugly/Bugly.h>

#import "JKAlertX/JKAlertX.h"
#import <TZImagePickerController/TZImagePickerController.h>
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "SDCycleScrollView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "MBProgressHUD+HUD.h"
#import "MJRefresh.h"
#import "JWCountButton.h"
#import "ScrollViewFreshEmpty/UIScrollView+FreshEmpty.h"
#import "WMZDialog.h"
#import "SettingChangeLanguage_Example-Bridging-Header.h"

#pragma mark -- 系统类名
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#pragma mark -- 类名
#import "ZSD_Define.h"
#import "YZSApp.h"
#import "YZSNetApiTools.h"
#import "MDCustomAlertView.h"
#import "MDCustomPayView.h"
#import "MDCustomOncePickerView.h"
#import "MDCustomMorePickerView.h"
#import "MDCustomDatePickerView.h"
#import "MDCustomPickerView.h"
//#import "MDHomeWebViewController.h"
//#import "HZPhotoBrowser.h"
#pragma mark -- 工具类
#import "LCPCHDebug.h"
#import "UIColor+Expanded.h"
#import "SettingChangeLanguage-Swift.h"
#import "GZTool.h"
#import "DLPickerView.h"
#import <YYCache/YYCache.h>
#import <ZZFLEX/ZZFLEX.h>
/// 图片浏览器
//#import "RYImageBrowser.h"
#import "XLPhotoBrowser.h"
#import "WTTextView.h"
#import "FFDropDownMenuView.h"
#import "UIImage+CLQRCode.h"
#import "ZPTextAttribiteFild.h"

//#import "NSBundle+Language.h"
#import "UIScreen+Extend.h"
#import "UIImage+WLCompress.h"
#import "PYSearch.h"

#define xiangMuName ([LCUtils getAppName])

#define rgb(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define GZRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define BgColor [UIColor colorWithRed:244/255.f green:241/255.f blue:241/255.f alpha:1]

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)

#define kStatusBarHeight [LCUtils getStatusBarHight]

// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)
#define kTableViewCellLineColor [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]
#define defaultColor rgb(218,88,36)
#define lctabBarTitleRGBColor [UIColor colorWithRed:0.89 green:0.32 blue:0.30 alpha:1.00]

//字体大小
#define FONT_10 [UIFont systemFontOfSize:10.0]
#define FONT_11 [UIFont systemFontOfSize:11.0]
#define FONT_12 [UIFont systemFontOfSize:12.0]
#define FONT_13 [UIFont systemFontOfSize:13.0]
#define FONT_14 [UIFont systemFontOfSize:14.0]
#define FONT_15 [UIFont systemFontOfSize:15.0]
#define FONT_16 [UIFont systemFontOfSize:16.0]
#define FONT_17 [UIFont systemFontOfSize:17.0]
#define FONT_18 [UIFont systemFontOfSize:18.0]
#define FONT_19 [UIFont systemFontOfSize:19.0]
#define FONT_20 [UIFont systemFontOfSize:20.0]
#define FONT_21 [UIFont systemFontOfSize:21.0]
#define FONT_22 [UIFont systemFontOfSize:22.0]
#define FONT_24 [UIFont systemFontOfSize:24.0]
#define FONT_26 [UIFont systemFontOfSize:26.0]
#define FONT_28 [UIFont systemFontOfSize:28.0]
#define FONT_30 [UIFont systemFontOfSize:30.0]
#define FONT_32 [UIFont systemFontOfSize:32.0]

//字体大小
#define FONT_10pt [UIFont systemFontOfSize:10.0]
#define FONT_11pt [UIFont systemFontOfSize:11.0]
#define FONT_12pt [UIFont systemFontOfSize:12.0]
#define FONT_13pt [UIFont systemFontOfSize:13.0]
#define FONT_14pt [UIFont systemFontOfSize:14.0]
#define FONT_15pt [UIFont systemFontOfSize:15.0]
#define FONT_16pt [UIFont systemFontOfSize:16.0]
#define FONT_17pt [UIFont systemFontOfSize:17.0]
#define FONT_18pt [UIFont systemFontOfSize:18.0]
#define FONT_19pt [UIFont systemFontOfSize:19.0]
#define FONT_20pt [UIFont systemFontOfSize:20.0]
#define FONT_21pt [UIFont systemFontOfSize:21.0]
#define FONT_22pt [UIFont systemFontOfSize:22.0]
#define FONT_24pt [UIFont systemFontOfSize:24.0]
#define FONT_26pt [UIFont systemFontOfSize:26.0]
#define FONT_28pt [UIFont systemFontOfSize:28.0]
#define FONT_30pt [UIFont systemFontOfSize:30.0]
#define FONT_32pt [UIFont systemFontOfSize:32.0]


#endif /* ZSD_ClassNameHeader_h */
