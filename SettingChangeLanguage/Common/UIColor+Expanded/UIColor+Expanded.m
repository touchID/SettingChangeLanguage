//
//  UIColor+colorWithHexString.m
//  SmartGate
//
//  Created by fred on 14-8-19.
//  Copyright (c) 2014年 fred. All rights reserved.
//

#import "UIColor+Expanded.h"

@implementation UIColor (Expanded)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    return [UIColor colorWithHexString:stringToConvert alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor clearColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    if (alpha >1.0 || alpha < 0) {
        alpha = 1.0;
    }
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

+ (UIColor *)commonBackGroundColor
{
    return [self colorWithHexString:@"F2F2F2"];
}

+ (UIColor *)defaultBackGroundColor
{
    return [self colorWithHexString:@"F3F3F3"];//浅灰色
}

+ (UIColor *)defaultTitleWordColor
{
    return  [self colorWithHexString:@"666666"];
}

+ (UIColor *)defaultContentWordColor
{
    return  [self colorWithHexString:@"2B569A"];
}

@end
