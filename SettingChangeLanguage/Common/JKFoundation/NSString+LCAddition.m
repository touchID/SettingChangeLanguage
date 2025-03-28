//
//  NSString+LCAddition.m
//  JKFoundation
//
//  Created by LC on 2017/12/11.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "NSString+LCAddition.h"

@implementation NSString (LCAddition)

#pragma mark - 这个是判断手机号
///这个是判断手机号
- (BOOL)isMobileNumber
{
    //    手机号以13， 15，18开头，八个 \d 数字字符
    //    虚拟运营商:170
    NSString * MOBILE = @"^((13[0-9])|(15[0-9])|(147)|(148)|(198)|(146)|(166)|(174)|(199)|(17[0-9])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


//pinyin
-(NSString*)transformToPinyin{
    NSMutableString *mutableString=[NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString,NULL,kCFStringTransformToLatin,false);
    mutableString = (NSMutableString*)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    mutableString = [[mutableString stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
    return mutableString.lowercaseString;
}


- (NSString *)transformToPinyinFirstLetter {
    NSMutableString *stringM = [NSMutableString string];
    
    
    NSString *temp  =  nil;
    for(int i =0; i < [self length]; i++){
        
        temp = [self substringWithRange:NSMakeRange(i, 1)];
        
        NSMutableString *mutableString=[NSMutableString stringWithString:temp];
        
        CFStringTransform((CFMutableStringRef)mutableString,NULL,kCFStringTransformToLatin,false);
        
        mutableString = (NSMutableString*)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
        
        mutableString =  [[mutableString substringToIndex:1] mutableCopy];
        
        [stringM appendString:(NSString *)mutableString];
        
    }
    
    return stringM.lowercaseString;
}

@end
