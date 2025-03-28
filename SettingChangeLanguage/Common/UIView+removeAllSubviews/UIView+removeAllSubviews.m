//
//  UIView+removeAllSubviews.m
//  iMusicPlayer
//
//  Created by zhuwei on 16/5/4.
//  Copyright © 2016年 zhuwei. All rights reserved.
//

#import "UIView+removeAllSubviews.h"

@implementation UIView (removeAllSubviews)

/**
 *  移除所有的子视图
 */
- (void)revmoveAllSubviews {
    NSArray *subviews = [self subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
}

@end
