//
//  LCUtils.h
//  luchao
//
//  Created by admin on 2019/2/12.
//  Copyright © 2019年 sesame. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
获取本地化字符串

@param key 本地化KEY
@return 返回本地化字符串
*/
#define _S_(__KEY__)     ([LCUtils yiForKey:__KEY__])

@class LCElevenHomeHotGoodsList;

@interface LCUtils : NSObject

@property (nonatomic,assign) NSInteger textMaxLength;//文本框字数de字数
@property (nonatomic,strong) UILabel *showNumTextLabel;//文本框字数限制提示字数

@property (nonatomic, copy) void(^composeEditBlock)(void);//检测文本改变
@property (nonatomic, copy) void(^textNumEditBlock)(NSInteger);//检测文本改变

- (void)textFiledEditChangedWithTextField:(UITextField *)textField;

+ (void)debug:(UIView *)view;

+ (CGFloat)picValueToFitValueForNum:(CGFloat)num;
/**增加侧滑返回,无其他作用*/
+ (void)lcAddSideLeftView:(UIView *)view;
///用颜色值创建图片
+ (UIImage *)createImageWithColor:(UIColor *)color;
///使用该方法不会模糊，根据屏幕密度计算
+ (UIImage *)convertViewToImage:(UIView *)view;
///根据图片的大小判断类型
+ (NSString *)lcGetCheckImageViewType:(UIImage *)imageView;
///设置上左右角为圆角
+ (void)setupRadiusWithBGView:(UIView *)bgView;
///处理字符串去掉字符
+ (NSString *)getYiXuan:(NSString *)str;
///是否是纯数字
+ (BOOL)isPureNumber:(NSString *)str;
///是否是纯空格
+ (BOOL)isPureSpace:(NSString *)str;

/**
 * 加粗字体方法
 * label 要加粗的 UILabel
 * BOOL YES = 加粗字体   NO = 去掉字体加粗
 */
+ (void)jiaCuFontFormLabel:(UILabel *)label jiaCu:(BOOL)jiaCu;

//+ (UIImage *)convertNVImage;

/**nowHours
 */
+ (NSString *)nowHours;
/**
 *  判断某个时间是否为今天
 */
+ (BOOL)isHours:(NSString *)dateStr;

///正则去除网络标签
+ (NSString *)getZZwithString:(NSString *)string;

//将obj转换成json字符串。如果失败则返回nil.
+ (NSString *)toJsonString:(NSObject *)string;

#pragma mark 图片处理方法
//图片旋转处理
+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (UIImage *)getImageFromURL:(NSString *)fileURL;

+ (BOOL)image:(UIImage *)image1 isEqualTo:(UIImage *)image2;
//+ (CGSize)getImageSizeWithURL:(id)URL;

+ (void)showLogin:(UIView *)view;

+ (void)showHome;
+ (void)showShopCar;
///显示无网络错误
+ (void)showNoNetworkError;

+ (NSString *)printPostDict:(NSDictionary *)parameters :(NSString *)url :(NSString *)appAccept :(NSString *)version;

///跳转到商品详情页 1.GZShoppingMallDetail
+ (void)pushShopDetailVCWithView:(UIView *)view pid:(NSString *)pid model:(LCElevenHomeHotGoodsList *)model;
///app的sessionid
+ (NSString *)getSessionid;

///退出登录 清除uid
+ (void)clearLogin;

// 获取当前info信息
+ (NSString *)getAppCurInfoStrForkey:(NSString *)key;

// 获取当前工程名称加点
+ (NSString *)getAppName;
//iOS开发之iOS13状态栏高度获取
+ (CGFloat)getStatusBarHight;

+ (NSString *)yiForKey:(NSString *)key;
//判断系统语言
+ (NSString *)checkLanguage;
+ (NSString *)yiForKey:(NSString *)key label:(UILabel *)label;

+ (BOOL)isiPhoneX;

///cell id
+ (NSString *)lcCellId:(Class)aClass;

///显示错误信息
//+ (void)showErrorMsg:(NSError *)error :(YZSNetResponse *)netResponse;

+ (void)hudBox:(NSString *)msgString :(UIView *)view;

+ (void)showMsg:(NSString *)msgString;

+ (void)zhendong;

+ (NSString *)transform:(NSString *)chinese;
//jiage
+ (NSString *)jiageByReplacing:(NSString *)result;

+ (UIImage *)imageNamed:(NSString *)name;

+ (NSString *)getUserName:(NSString *)uid;

+ (void)lcReachability:(NSString *)errorStr;

///获取启动图
+ (UIImage *)getLaunchImage;

//此方法把doubleString －－－> 价格 NSString
+ (NSString *)decimalNumberWithString:(NSString *)string;

+ (NSString *)priceWithString:(NSString *)string;

+ (NSString *)priceSpaceWithString:(NSString *)string;
@end
