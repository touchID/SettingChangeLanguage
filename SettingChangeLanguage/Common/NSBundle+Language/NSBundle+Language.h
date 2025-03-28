//
//  NSBundle+Language.h
//
//  Created by 刘凡 on 2018.
//  Copyright © 2018年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define GCLocalizedString(KEY) [[NSBundle mainBundle] localizedStringForKey:KEY value:nil table:@"Localizable"]

@interface NSBundle (Language)

+ (void)setLanguage:(NSString *)language;

+ (int)language;

+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value;

@end
