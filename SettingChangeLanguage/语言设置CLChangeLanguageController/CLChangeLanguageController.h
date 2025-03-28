//
//  CLChangeLanguageController.h
//  CLDemo
//
//  Created by AUG on 2018/11/7.
//  Copyright © 2018年 JmoVxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLChangeLanguageController : LCViewController

@property (nonatomic, copy) void(^changeLanguageBlock)(void) ;

@end

NS_ASSUME_NONNULL_END
