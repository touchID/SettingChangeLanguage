//
//  NSBundle+Language.m
//
//  Created by 刘凡 on 2018.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import "NSBundle+Language.h"
#import <objc/runtime.h>

static NSString *const GCLanguageKey = @"AppLanguagesKey";

@interface BundleEx : NSBundle

@end

@implementation BundleEx

+ (instancetype)lc_Bundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        refreshBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"LCBundle" ofType:@"bundle"]];
    }
    return refreshBundle;
}
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    
    // 当前语言
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:GCLanguageKey];
    if ([currentLanguage isEqualToString:@"zh"]) {
        currentLanguage = @"zh-Hans";
    }else
    if ([currentLanguage isEqualToString:@"cht"]) {
        currentLanguage = @"zh-Hant";
    }else
    if ([currentLanguage isEqualToString:@"en"]) {
        currentLanguage = @"en";
    }else
    if ([currentLanguage isEqualToString:@"fra"]) {
        currentLanguage = @"fr";
    }else
    if ([currentLanguage isEqualToString:@"spa"]) {
        currentLanguage = @"es";
    }
    // 设置默认语言
    NSString *langID = [[NSLocale preferredLanguages] firstObject];
    currentLanguage = currentLanguage ? currentLanguage : langID;//@"zh-Hans"
//    NSLog(@"currentLanguage = %@", currentLanguage);
    // 每次需要从语言包查询语言键值对的时候，都按照当前语言取出当前语言包
    NSBundle *currentLanguageBundle = currentLanguage ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:currentLanguage ofType:@"lproj"]] : nil;
    
    // 下面return中普通 bundle 在调用 localizedStringForKey: 方法时不会循环调用，虽然我们重写了 mainBundle 单例的 localizedStringForKey: 方法，但是我们只修改了 mainBundle 单例的isa指针指向，
    // 也就是说只有 mainBundle 单例在调用 localizedStringForKey: 方法时会走本方法，而其它普通 bundle 不会。
    return currentLanguageBundle ? [currentLanguageBundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (Language)

+ (void)load {
    static dispatch_once_t onceToken;
    
    // 保证只修改一次 mainBundle 单例的isa指针指向
    dispatch_once(&onceToken, ^{
        
        // 让 mainBundle 单例的isa指针指向 BundleEx 类
        object_setClass([NSBundle mainBundle], [BundleEx class]);
    });
}

+ (void)setLanguage:(NSString *)language {
    
    // 将当前手动设置的语言存起来
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:GCLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (int)language {
    
    NSString *language = [[NSUserDefaults standardUserDefaults] stringForKey:GCLanguageKey];
 
    if ([language isEqualToString:@"en"]) {
        return 0;
    } else {
        return 1;
    }
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value {
    if ([key isEqualToString:@"MJRefreshHeaderIdleText"]) {
        return _S_(@"下拉可以刷新");
    }
    else
    if ([key isEqualToString:@"MJRefreshHeaderPullingText"]) {
        return _S_(@"松开立即刷新");
    }
    else
    if ([key isEqualToString:@"MJRefreshHeaderRefreshingText"]) {
        return [_S_(@"正在刷新数据中") addStr:@"..."];
    }
    else
    if ([key isEqualToString:@"MJRefreshAutoFooterIdleText"]) {
        return _S_(@"点击或上拉加载更多");
    }
    else
    if ([key isEqualToString:@"MJRefreshAutoFooterRefreshingText"]) {
        return [_S_(@"正在加载更多的数据") addStr:@"..."];
    }
    else
    if ([key isEqualToString:@"MJRefreshAutoFooterNoMoreDataText"]) {
        return _S_(@"已经全部加载完毕");
    }
    else
    if ([key isEqualToString:@"MJRefreshBackFooterIdleText"]) {
        return _S_(@"上拉可以加载更多");
    }
    else
    if ([key isEqualToString:@"MJRefreshBackFooterPullingText"]) {
        return _S_(@"松开立即加载更多");
    }
    else
    if ([key isEqualToString:@"MJRefreshBackFooterRefreshingText"]) {
        return _S_(@"正在加载更多的数据...");
    }
    else
    if ([key isEqualToString:@"MJRefreshBackFooterNoMoreDataText"]) {
        return _S_(@"已经全部加载完毕");
    }
    else
    if ([key isEqualToString:@"MJRefreshHeaderLastTimeText"]) {
        return _S_(@"最后更新：");
    }
    else
    if ([key isEqualToString:@"MJRefreshHeaderDateTodayText"]) {
        return _S_(@"今天");
    }
    else
    if ([key isEqualToString:@"MJRefreshHeaderNoneLastDateText"]) {
        return _S_(@"无记录");
    }
    else {
        return @"";
    }
//    static NSBundle *bundle = nil;
//    if (bundle == nil) {
//        // （iOS获取的语言字符串比较不稳定）目前框架只处理en、zh-Hans、zh-Hant三种情况，其他按照系统默认处理
//        NSString *language = [NSLocale preferredLanguages].firstObject;
//        if ([language hasPrefix:@"en"]) {
//            language = @"en";
//        } else if ([language hasPrefix:@"zh"]) {
//            if ([language rangeOfString:@"Hans"].location != NSNotFound) {
//                language = @"zh-Hans"; // 简体中文
//            } else { // zh-Hant\zh-HK\zh-TW
//                language = @"zh-Hant"; // 繁體中文
//            }
//        } else {
//            language = @"en";
//        }
//
//        // 从MJRefresh.bundle中查找资源
//        bundle = [NSBundle bundleWithPath:[[NSBundle mj_refreshBundle] pathForResource:language ofType:@"lproj"]];
//    }
//    value = [bundle localizedStringForKey:key value:value table:nil];
//    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

@end
