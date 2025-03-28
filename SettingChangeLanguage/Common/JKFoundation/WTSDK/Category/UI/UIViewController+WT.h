//  GitHub: https://github.com/Tate-zwt/WTSDK
//  UIViewController+WT.h
//  WTSDK
//
//  Created by 张威庭 on 15/12/16.
//  Copyright © 
//

#import <UIKit/UIKit.h>

@protocol LCBackButtonHandlerProtocol <NSObject>

@optional
/**
 *  self.navigationController
 */
@property (nonatomic, weak) UINavigationController *nav;

/**
 *  self.Nav 默认动画 pushViewController:vc animated:YES
 */
- (void)pushVc:(UIViewController *)vc;
- (void)pushVcStr:(NSString *)vcstr;
/** 取得对应的Vc */
- (UIViewController *)vcWithClassStr:(NSString *)classStr;

/**
 * 构建 rightBarButtonItem title
 */
- (void)rightBarBtn:(NSString *)title act:(SEL)selector;
/** 构建 rightBarButtonItem ImageName */
- (void)rightBarBtnImgN:(NSString *)imageN act:(SEL)selector;

/**
 *  push vc 带其他动画 具体效果自己看
 */
- (void)pushVc:(UIViewController *)vc animateType:(NSInteger)row;

@end

@interface UIViewController (WT) <LCBackButtonHandlerProtocol>

@end
