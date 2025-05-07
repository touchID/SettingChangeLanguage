//
//  LCTabBarContentView.h
//  LCTabBarContentView
//
//  Created by admin on 17/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 依赖库
 1. Masonry
 */

@class LCTabBarContentView;

/**
 为当前控件提供数据支持
 */
@protocol LCTabBarContentViewDataSource <NSObject>

@required
/**
 放回当前控件需要多少个选项

 @param tabBarContentView 当前控件
 @return 返回选项个数
 */
- (NSInteger)numberOfItemsInTabBarContentView:(LCTabBarContentView *)tabBarContentView;

/**
 提供选项的标题

 @param tabBarContentView 当前控件
 @param index 标题索引
 @return 返回标题内容
 */
- (NSString *)tabBarContentView:(LCTabBarContentView *)tabBarContentView titleForItemAtIndex:(NSInteger)index;

/**
 提供内容视图

 @param tabBarContentView 当前控件
 @param index 标题索引
 @return 内容视图
 */
- (UIView *)tabBarContentView:(LCTabBarContentView *)tabBarContentView contentViewAtIndex:(NSInteger)index;

@end


/**
 为当前控件显示样式及行为
 */
@protocol LCTabBarContentViewDelegate <NSObject>

@optional
/**
 定义导航条的高度,如果不定义默认 30

 @param tabBarContentView 当前控件
 @return 高度
 */
- (CGFloat)heightForTabBarInTabBarContentView:(LCTabBarContentView *)tabBarContentView;


/**
 设置标题的颜色, 默认黑色

 @param tabBarContentView 当前控件
 @return 标题颜色
 */
- (UIColor *)colorForTabBarItemTextInTabBarContentView:(LCTabBarContentView *)tabBarContentView;

/**
 当前选中的颜色,默认值: 橘黄色

 @param tabBarContentView 当前控件
 @return 返回选中的颜色
 */
- (UIColor *)highlightColorForTabBarItemInTabBarContentView:(LCTabBarContentView *)tabBarContentView;


/**
 返回一个当前选项选中的视图

 @param tabBarContentView 当前控件
 @return 选中的视图
 */
- (UIView *)highlightViewForTabBarItemInTabBarContentView:(LCTabBarContentView *)tabBarContentView;


/**
 当选中状态发生改变时回调

 @param tabBarContentView 当前控件
 @param index 选项下标
 */
- (void)tabBarContentView:(LCTabBarContentView *)tabBarContentView didSelectItemAtIndex:(NSInteger)index;
@end


@interface LCTabBarContentView : UIView

///title样式
@property (assign, nonatomic) NSInteger tabBarTitleStyle;
/**
 内容
 */
@property (strong, nonatomic)   UIScrollView    *contentScrollView;
/**
 存放 TabBarItem 容器
 */
@property (strong, nonatomic)   NSMutableArray<UIButton *>  *tabBarItems;

/**
 数据源
 */
@property (weak, nonatomic)   id<LCTabBarContentViewDataSource>     dataSource;


/**
 代理
 */
@property (weak, nonatomic)   id<LCTabBarContentViewDelegate>       delegate;

@property (strong, nonatomic)   UIView                              *tabBarBackgroundView;
@property (assign, nonatomic)   Boolean                             isNoSelectAnimated;

/**
 刷新界面
 */
- (void)reloadData;
- (void)segmentAction:(NSInteger)currentSelectIndex;

@end
