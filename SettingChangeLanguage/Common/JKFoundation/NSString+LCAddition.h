//
//  NSString+LCAddition.h
//  NSString+LCAddition
//
//  Created by LC on 2017/12/11.
//  Copyright © 2017年 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LCAddition)

- (BOOL)isMobileNumber;
///拼音 ->pinyin
-(NSString*)transformToPinyin;

///拼音首字母 -> py
- (NSString *)transformToPinyinFirstLetter;

@end
