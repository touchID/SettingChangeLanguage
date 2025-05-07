//
//  LCTabBarContentView.m
//  LCTabBarContentView
//
//  Created by admin on 17/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LCTabBarContentView.h"
#import "UIImage+Tint.h"

@interface LCTabBarContentView () <UIScrollViewDelegate>

/**
 导航条
 */
@property (strong, nonatomic)   UIScrollView    *tabBarScrollView;

@property (strong, nonatomic)   NSMutableArray<UIView *>    *contents;

@property (strong, nonatomic)   UIButton                    *selectedItemButton;


/**
 用于存选中视图的容器
 */
@property (strong, nonatomic)   UIView                      *highlightViewContainer;

@end

@implementation LCTabBarContentView {
    NSInteger   _count;
}


#pragma mark - 重写属性 -
- (UIView *)tabBarScrollView {
    // 创建 TabBar 控件
    if(_tabBarScrollView == nil) {
        _tabBarScrollView = [UIScrollView new];
//        _tabBarScrollView.pagingEnabled = YES;
        _tabBarScrollView.showsHorizontalScrollIndicator = NO;
        _tabBarScrollView.showsVerticalScrollIndicator = NO;
        _tabBarScrollView.backgroundColor = [UIColor clearColor];
        _tabBarScrollView.scrollEnabled = NO;// 禁止滑动
        [self addSubview:_tabBarScrollView];
        // 默认给定一个简单的布局
        [_tabBarScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
//            make.height.top.bottom.left.right.equalTo(self);
//            make.width.offset(375*2);
        }];
        ///加上分割线
//        UIImageView *view = [[UIImageView alloc] init];
//        view.image = [UIImage imageNamed:@"27154149.jpg"];
//        [_tabBarScrollView addSubview:view];
////        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
////        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
////        effectView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
////        [view addSubview:effectView];
//        [view sizeToFit];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self);
//            make.top.equalTo(self.mas_top).offset(-89);
////            make.height.mas_equalTo(XNWindowWidth*(view.frame.size.height/view.frame.size.width));
//            //make.bottom.equalTo(self);//.offset(0.3);
//        }];
//        [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(view);
//        }];
        UIView *line_view = [[UIView alloc] init];
        line_view.backgroundColor = rgb(255, 255, 255);
        [_tabBarScrollView addSubview:line_view];
        [line_view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_tabBarScrollView.mas_right).offset(0);
            make.left.equalTo(self.mas_left).offset(89-5.5-1);
            make.width.mas_equalTo(1);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
        }];

    }
    return _tabBarScrollView;
}
///内容页面
- (UIScrollView *)contentScrollView {
    if(_contentScrollView == nil) {
        _contentScrollView = [UIScrollView new];
        _contentScrollView.bounces = false;// 弹簧效果
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.scrollEnabled = NO;// 禁止滑动
        _contentScrollView.delegate = self;
        [self addSubview:_contentScrollView];
        [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.left.equalTo(self.tabBarScrollView.mas_right);
        }];
    }
    return _contentScrollView;
}

- (NSMutableArray<UIView *> *)contents {
    if(_contents == nil) {
        _contents = [NSMutableArray array];
    }
    return _contents;
}

- (NSMutableArray<UIButton *> *)tabBarItems {
    if(_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}

- (void)setTabBarBackgroundView:(UIView *)tabBarBackgroundView {
    // 设置背景视图
    if(_tabBarBackgroundView != nil) {
        [_tabBarBackgroundView removeFromSuperview];
        _tabBarBackgroundView = nil;
    }
    
    _tabBarBackgroundView = tabBarBackgroundView;
    
    [self.tabBarScrollView insertSubview:_tabBarBackgroundView atIndex:0];
    [_tabBarBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.with.height.equalTo(self.tabBarScrollView);
    }];
}

#pragma mark - 私有方法 -

- (CGFloat)tabBarHeight {
    // 获取 TabBar 高度
    CGFloat tabBarHeight = 40;
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(heightForTabBarInTabBarContentView:)]) {
        tabBarHeight = [self.delegate heightForTabBarInTabBarContentView:self];
    }
    
    return tabBarHeight;
}

- (NSInteger)numberOfItems {
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInTabBarContentView:)]) {
        return [self.dataSource numberOfItemsInTabBarContentView:self];
    }
    return 0;
}

/**
 刷新导航条
 */
- (void)realoadTabBar {
    
    // 刷新布局
    [self.tabBarScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
//        make.left.top.right.equalTo(self);
        make.width.mas_equalTo([self tabBarHeight]);
    }];
    
    // 清空TabBar内部的内容
    for (UIButton *itemButton in self.tabBarItems) {
        [itemButton removeFromSuperview];
    }
    [self.tabBarItems removeAllObjects];
    
    // 构建TabBar选项
    // 获取数量
    NSInteger tabBarItemCount = _count;
    
    // 构建
    for (NSInteger i = 0; i < tabBarItemCount; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.titleLabel.font = [UIFont systemFontOfSize:15.0];

        [self.tabBarScrollView addSubview:itemButton];
        
        [itemButton addTarget:self action:@selector(actionSelectItemButton:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置标题
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(tabBarContentView:titleForItemAtIndex:)]) {
            NSString *title = [self.dataSource tabBarContentView:self titleForItemAtIndex:i];
            //if (i < 2 || i == 4) {
                [itemButton setBackgroundImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
                [itemButton setBackgroundImage:[UIImage imageNamed:[title addStr:@"_选中"]] forState:UIControlStateSelected];
            //}else{
            //    [itemButton setTitle:title forState:UIControlStateNormal];
            //}
        }
        
        // 设置标题颜色
        if(self.delegate && [self.delegate respondsToSelector:@selector(colorForTabBarItemTextInTabBarContentView:)]) {
            [itemButton setTitleColor:[self.delegate colorForTabBarItemTextInTabBarContentView:self] forState:UIControlStateNormal];
        } else {
            [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        // 设置选中的颜色
        if(self.delegate && [self.delegate respondsToSelector:@selector(highlightColorForTabBarItemInTabBarContentView:)]) {
            [itemButton setTitleColor:[self.delegate highlightColorForTabBarItemInTabBarContentView:self] forState:UIControlStateSelected];
        } else {
            [itemButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        }
        
        [self.tabBarItems addObject:itemButton];
    }
    
    // 布局
    CGFloat percentWith = 1.0 / tabBarItemCount;
    for (NSInteger i = 0; i < tabBarItemCount; i++) {
        UIButton *itemButton = self.tabBarItems[i];
        
        if (self.tabBarTitleStyle == 2) {///样式一的title布局
            CGFloat space = 19; // 中间间隔
            if (i == 0) {
//                UIButton *nextItemButton = _tabBarItems[i + 1];
                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.equalTo(nextItemButton.mas_left).offset(-space);
                    make.right.equalTo(self.mas_centerX).offset(-space);
                    make.width.equalTo(itemButton.mas_width);
                    make.height.equalTo(itemButton.mas_height);
                    make.centerY.equalTo(self.tabBarScrollView.mas_centerY);
                }];
            }
//            if (i == 1) {
//                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.centerX.equalTo(self.mas_centerX).offset(0);
//                    make.width.equalTo(itemButton.mas_width);
//                    make.height.equalTo(itemButton.mas_height);
//                    make.centerY.equalTo(self.tabBarScrollView.mas_centerY);
//                }];
//            }
            if (i == 1) {
//                UIButton *lastItemButton = _tabBarItems[i - 1];
                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.left.equalTo(lastItemButton.mas_right).offset(space);
                    make.left.equalTo(self.mas_centerX).offset(space);
                    make.width.equalTo(itemButton.mas_width);
                    make.height.equalTo(itemButton.mas_height);
                    make.centerY.equalTo(self.tabBarScrollView.mas_centerY);
                }];
            }
        }else if (self.tabBarTitleStyle == 3) {///样式3的title布局
            CGFloat space = 40; // 间隔
            if (i == 0) {
                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.tabBarScrollView.mas_top).offset(60);
                    make.width.equalTo(itemButton.mas_width);
                    make.height.equalTo(itemButton.mas_height);
                    make.centerX.equalTo(self.tabBarScrollView.mas_centerX);
                }];
            }else{
                UIButton *lastItemButton = _tabBarItems[i - 1];
                [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastItemButton.mas_bottom).offset(space);
                    make.width.equalTo(itemButton.mas_width);
                    make.height.equalTo(itemButton.mas_height);
                    make.centerX.equalTo(self.tabBarScrollView.mas_centerX);
                }];
            }
        }else{
            [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
                if(i == 0) {
                    make.left.equalTo(self.tabBarScrollView.mas_left);
                } else {
                    make.left.equalTo(self.tabBarItems[i - 1].mas_right);
                }
                if(i == tabBarItemCount - 1) {
                    make.right.equalTo(self.tabBarScrollView.mas_right);
                } else {
                    make.right.equalTo(self.tabBarItems[i + 1].mas_left);
                }
                make.top.bottom.height.equalTo(self.tabBarScrollView);
                make.width.equalTo(self.tabBarScrollView).multipliedBy(percentWith);
            }];
        }
    }
    [self.tabBarScrollView layoutIfNeeded];
    
    UIButton *endItemButton = _tabBarItems.lastObject;
    CGFloat channelContentSizeWidth = CGRectGetMaxX(endItemButton.frame) > ScreenWidth ? CGRectGetMaxX(endItemButton.frame) : ScreenWidth;
    // 设置滚动视图的滚动范围 : height = 0 表示横向滚动
    self.tabBarScrollView.contentSize = CGSizeMake(channelContentSizeWidth+20, 0);

    // 构建选中的视图容器
    if(self.highlightViewContainer == nil) {
        self.highlightViewContainer = [UIView new];
        self.highlightViewContainer.userInteractionEnabled = NO;
        [self.tabBarScrollView addSubview:self.highlightViewContainer];
        [self.highlightViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tabBarItems.firstObject);
        }];
    }
    
    NSArray *subviews = [self.highlightViewContainer subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(highlightViewForTabBarItemInTabBarContentView:)]) {
        UIView *highlightView = [self.delegate highlightViewForTabBarItemInTabBarContentView:self];
        [self.highlightViewContainer addSubview:highlightView];
        [highlightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.highlightViewContainer);
        }];
    }
    
    
    [self actionSelectItemButton:self.tabBarItems.firstObject];
    
}


/**
 刷新内容
 */
- (void)realoadContent {
    // 清空老的内容
    for (UIView *contentView in self.contents) {
        [contentView removeFromSuperview];
    }
    [self.contents removeAllObjects];
    
    
    
    // 构建内容视图
    for (NSInteger i = 0; i < _count; i++) {
        UIView *contentView = nil;
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(tabBarContentView:contentViewAtIndex:)]) {
            contentView = [self.dataSource tabBarContentView:self contentViewAtIndex:i];
        }
        if(contentView == nil) {
            contentView = [UIView new];
        }
        
        [self.contentScrollView addSubview:contentView];
        [self.contents addObject:contentView];
    }
    
    // 布局内容视图
    for (NSInteger i = 0; i < _count; i++) {
        UIView *contentView = self.contents[i];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0) {
                make.left.equalTo(self.contentScrollView.mas_left);
            } else {
                make.left.equalTo(self.contents[i - 1].mas_right);
            }
            if(i == self->_count - 1) {
                make.right.equalTo(self.contentScrollView.mas_right);
            } else {
                make.right.equalTo(self.contents[i + 1].mas_left);
            }
            
            make.top.height.bottom.width.equalTo(self.contentScrollView);
            
        }];
    }
}

#pragma mark - 动作方法 -
- (void)segmentAction:(NSInteger)currentSelectIndex {
    self.isNoSelectAnimated = true;
    UIButton *selectedItemButton = self.tabBarItems[currentSelectIndex];
    [self actionSelectItemButton:selectedItemButton];
}

/**
 选择选中的Button

 @param button 选中的Button
 */
- (IBAction)actionSelectItemButton:(UIButton *)button {
    
//    // 过滤
//    if(self.selectedItemButton != nil && self.selectedItemButton == button) return;
    

    if(self.selectedItemButton != nil) {
        self.selectedItemButton.selected = NO;
        self.selectedItemButton = nil;
    }
    self.selectedItemButton = button;
    self.selectedItemButton.selected = YES;
    
    // 联动内容
    NSInteger selectedIndex = [self.tabBarItems indexOfObject:self.selectedItemButton];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBarContentView:didSelectItemAtIndex:)]) {
        [self.delegate tabBarContentView:self didSelectItemAtIndex:selectedIndex];
    }
    
    
    CGPoint offset = CGPointMake(selectedIndex * self.contentScrollView.frame.size.width, 0);
    if (self.isNoSelectAnimated == true) {
        [self.contentScrollView setContentOffset:offset animated:NO];
    }else{
        [self.contentScrollView setContentOffset:offset animated:YES];
    }
    
    
    if (self.tabBarTitleStyle == 3) {///样式3的title布局
        
#pragma mark -  频道标签手势点击之后tabBarScrollView进行滚动  -
        // 1.把选中的频道标签居中
        // 1.2 计算选中的标签居中时,需要滚动的距离
        CGFloat offsetX = button.center.x - self.bounds.size.width*0.5;
        
        // 1.3 限制最大和最小滚动范围
        CGFloat minOffset = 0;
        CGFloat maxOffset = self.tabBarScrollView.contentSize.width - self.bounds.size.width;
        if (offsetX < minOffset) {
            offsetX = minOffset;
        }
        if (offsetX > maxOffset) {
            offsetX = maxOffset;
        }
        // 1.4 获取需要滚动到的点
        CGPoint point = CGPointMake(offsetX, 0);
        // 1.5 频道滚动视图滚动到标签居中的位置
        if (self.isNoSelectAnimated == true) {
            [self.tabBarScrollView setContentOffset:point animated:NO];
        }else{
            [self.tabBarScrollView setContentOffset:point animated:YES];
        }
        
        if (selectedIndex == 0) {
            [self.tabBarScrollView setContentOffset:CGPointMake(0,0) animated:false];
        }
    }

    
    // 当滚动完成以后更新高亮容器视图的约束
    [self.highlightViewContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.selectedItemButton);
    }];

}

#pragma mark - 公共方法 -
/**
 刷新界面
 */
- (void)reloadData {
    _count = [self numberOfItems];
    
    [self realoadTabBar];
    [self realoadContent];
    
}

#pragma mark - UIScrollViewDelegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    // 计算选中 TabBarItem
//    CGFloat offsetX = scrollView.contentOffset.x / (scrollView.contentSize.width - scrollView.frame.size.width) * (self.tabBarScrollView.frame.size.width - self.highlightViewContainer.frame.size.width);
//
//    // 仅仅设置了frame
//    self.highlightViewContainer.frame = CGRectMake(offsetX, self.highlightViewContainer.frame.origin.y, self.highlightViewContainer.frame.size.width, self.highlightViewContainer.frame.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
#pragma mark -  滚动变化  -
    if (scrollView == self.tabBarScrollView/**假如是标签视图就不做变化*/) {
        return;
    }
    NSInteger selectedIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIButton *selectedButton = self.tabBarItems[selectedIndex];
    [self actionSelectItemButton:selectedButton];
    
    
    // 当滚动完成以后更新高亮容器视图的约束
    [self.highlightViewContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.selectedItemButton);
    }];
    
    
    if (self.tabBarTitleStyle == 3) {///样式3的title布局
        
        // 计算当前滚动到第几个角标
        NSInteger index = scrollView.contentOffset.x / self.bounds.size.width;
        
        // 获取滚动首页视图时,对应的标签
        UIButton *itemButton = _tabBarItems[index];
        
        // 计算当滚动首页视图时,对应的标签居中时需要滚动的距离
        CGFloat offsetX = itemButton.center.x - self.bounds.size.width*0.5;
        
        // 限制最大和最小 滚动范围
        CGFloat minOffset = 0;
        CGFloat maxOffset = self.tabBarScrollView.contentSize.width - self.bounds.size.width;
        if (offsetX < minOffset) {
            offsetX = minOffset;
        }
        if (offsetX > maxOffset) {
            offsetX = maxOffset;
        }
        
        // 获取居中时需要滚动到的点
        CGPoint point = CGPointMake(offsetX, 0);
        // 滚动首页视图时,把对应的标签居中
        [self.tabBarScrollView setContentOffset:point animated:YES];
        
    }
    
}
@end
