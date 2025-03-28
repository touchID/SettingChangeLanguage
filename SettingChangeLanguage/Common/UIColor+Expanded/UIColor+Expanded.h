//
//  UIColor+colorWithHexString.h
//  SmartGate
//
//  Created by fred on 14-8-19.
//  Copyright (c) 2014年 fred. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Expanded)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

+ (UIColor *)defaultBackGroundColor;
+ (UIColor *)commonBackGroundColor;
+ (UIColor *)defaultTitleWordColor;
+ (UIColor *)defaultContentWordColor;

@end
