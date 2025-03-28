//
//  UIView+ViewController.m
//  MLMSegmentPage
//
//  Created by MAC on 2017/5/18.
//  Copyright © 2017年 my. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        } else if ([next isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)next;
            return nav.viewControllers.lastObject;
        }
        next = next.nextResponder;
    }while (next != nil);
    return nil;
}

+ (void)setUpLoginViewController {
//    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    SHSLoginViewController *vc = [[SHSLoginViewController alloc]init];
//    LCNavigationController *nav = [[LCNavigationController alloc]initWithRootViewController:vc];
//    window.rootViewController = nav;
//    /*
//     * 极光
//     * 极光单推，将alias传给后台，alias是跟后台规定的字符串
//     */
//    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
////        NSLog(@"iResCode = %zd", iResCode);
////        // 返回成功
////        NSLog(@"iAlias = %@", iAlias);
////        NSLog(@"seq = %zd", seq);
//    }
//    seq:0];
//    /*
//     * 极光
//     * 极光单推，将alias传给后台，alias是跟后台规定的字符串
//     */
//        [JPUSHService setAlias:[NSString stringWithFormat:@"0"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//    //        NSLog(@"iResCode = %zd", iResCode);
//    //        // 返回成功
//    //        NSLog(@"iAlias = %@", iAlias);
//    //        NSLog(@"seq = %zd", seq);
//        }
//        seq:0];
}

@end
