//  GitHub: https://github.com/Tate-zwt/WTSDK
//  UIViewController+WT.m
//  WTSDK
//
//  Created by 张威庭 on 15/12/16.
//  Copyright ©  
//

#import "UIViewController+WT.h"
#import <objc/runtime.h>
static const void *HttpRequestHUDKey = &HttpRequestHUDKey;
@implementation UIViewController (WT)

/**
 *  self.navigationController
 */
- (UINavigationController *)nav {
    UINavigationController *nav = self.navigationController;
    return nav ? nav : self.tabBarController.navigationController;
}

- (UIViewController *)VcWithClassStr:(NSString *)ClassStr {
    UINavigationController *CurrentNav = (UINavigationController *) ([self isKindOfClass:[UINavigationController class]] ? (self) : (self.nav));
    for (UIViewController *vc in [CurrentNav.viewControllers reverseObjectEnumerator]) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            UITabBarController *Tab = (UITabBarController *) vc;
            for (UIViewController *vc in [Tab.viewControllers reverseObjectEnumerator]) {
                if ([vc isKindOfClass:NSClassFromString(ClassStr)]) {
                    return vc;
                }
            }
        }
        if ([vc isKindOfClass:NSClassFromString(ClassStr)]) {
            return vc;
        }
    }
    return nil;
}

/**
 *  self.nav 默认动画 pushViewController:vc animated:YES
 */
- (void)pushVc:(UIViewController *)vc {
    [self.nav pushViewController:vc animated:YES];
}
- (void)pushVcStr:(NSString *)vcstr {
    [self.nav pushViewController:[[NSClassFromString(vcstr) alloc] init] animated:YES];
}
/**
 * 构建 rightBarButtonItem title
 */
- (void)rightBarBtn:(NSString *)title act:(SEL)selector {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
}
/**< 构建 rightBarButtonItem title */
- (void)rightBarBtnImgN:(NSString *)imageN act:(SEL)selector {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imageN] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:selector];
}

#pragma clang diagnostic pop
//
- (void)touchesBegan:(nonnull NSSet *)touches withEvent:(nullable UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -  push 动画

#define kDuration 0.35 // 动画持续时间(秒)
/**
 *  push vc 带其他动画 具体效果自己看
 */
- (void)pushVc:(UIViewController *)vc animateType:(NSInteger)row {
    if (row < 4) {
        //UIView Animation
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:kDuration];
        [self.navigationController pushViewController:vc animated:NO];
        switch (row) {
            case 0:
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:YES];
                break;
            case 1:
                [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:YES];
                break;
            case 2:
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:YES];
                break;
            case 3:
                [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:YES];
                break;
            default:
                break;
        }
        [UIView commitAnimations];
    } else {
        //core animation
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = kDuration;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.subtype = kCATransitionFromLeft;
        switch (row) {
            case 4:
                animation.type = kCATransitionReveal;
                break;
            case 5:
                animation.type = kCATransitionMoveIn;
                break;
            case 6:
                animation.type = @"cube";
                break;
            case 7:
                animation.type = @"suckEffect";
                break;
            case 8:
                animation.type = @"rippleEffect";
                break;
            case 9:
                animation.type = @"pageCurl";
                break;
            case 10:
                animation.type = @"pageUnCurl";
                break;
            case 11:
                animation.type = kCATransitionFade;
                break;
            case 12:
                animation.type = kCATransitionMoveIn;
                animation.subtype = kCATransitionFromTop;
                break;
            default:
                break;
        }

        [self.navigationController pushViewController:vc animated:NO];
        [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
    }
}

@end
