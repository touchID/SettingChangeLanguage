//
//  LCUtils.m
//  luchao
//
//  Created by admin on 2019/2/12.
//  Copyright © 2019年 sesame. All rights reserved.
//

#import "LCUtils.h"
#import "NSBundle+Language.h"
#import "UIView+ViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "CoreStatus.h"


@implementation LCUtils
 
- (NSInteger)textMaxLength{
    if (_textMaxLength == 0) {
        _textMaxLength = 18;
    }
    return _textMaxLength;
}

- (void)textFiledEditChangedWithTextField:(UITextField *)textField{
    //检测文本改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(putInTextFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:textField];
    self.showNumTextLabel.text = [NSString stringWithFormat:@"%zd", self.textMaxLength];
}

- (void)putInTextFieldEditChanged:(NSNotification *)obj {
    UITextView *textField = (UITextView *)obj.object;
    NSString *toBeString = textField.text;
#pragma mark -下午8:17 字数限制 -
    NSInteger index = self.textMaxLength - toBeString.length;
    // 键盘输入模式
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.textMaxLength) {
                textField.text = [toBeString substringToIndex:self.textMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > self.textMaxLength) {
            textField.text = [toBeString substringToIndex:self.textMaxLength];
        }
    }
#pragma mark - 下午8:16 字数限制 -
    if (index < 0) {
        index = 0;
        if (self.composeEditBlock != nil) {
            self.composeEditBlock();
        }
    }else{
        if (self.textNumEditBlock != nil) {
            self.textNumEditBlock(toBeString.length);
        }
    }
    self.showNumTextLabel.text = [NSString stringWithFormat:@"%ld", (long)index];
    //    NSLog(@"self.showNumTextLabel.text = %@", self.showNumTextLabel.text);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

///debug 模式下调试UI
+ (void)debug:(UIView *)view {
    [view debug:arc4random_color width:1];
}

/// 自适应图片高度
+ (CGFloat)picValueToFitValueForNum:(CGFloat)num {
    num = num * [[UIScreen mainScreen] bounds].size.width / 375.0f;
    return num;
}

/**增加侧滑返回,无其他作用*/
+ (void)lcAddSideLeftView:(UIView *)view {
    UIView *sideLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 86, 10, XNWindowHeight)];
    [view addSubview:sideLeftView];
    [LCUtils debug:sideLeftView];
    [view bringSubviewToFront:sideLeftView];
}

///用颜色值创建图片
+ (UIImage *)createImageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

///使用该方法不会模糊，根据屏幕密度计算
+ (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
}

+ (NSString *)lcGetCheckImageViewType:(UIImage *)imageView {
//    NSLog(@"imageView.size = %@", NSStringFromCGSize(imageView.size));
    if (imageView.size.width/imageView.size.height == 0.75) {
//        [SVProgressHUD showWithStatus:@"1"];
        return @"1";
    }
    if (imageView.size.width/imageView.size.height < 0.76 && imageView.size.width/imageView.size.height > 0.74 ) {
//        [SVProgressHUD showWithStatus:@"1"];
        return @"1";
    }
//    [SVProgressHUD showWithStatus:@"2"];
    return @"2";
}

///设置上左右角为圆角
+ (void)setupRadiusWithBGView:(UIView *)bgView {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bgView.bounds;
    maskLayer.path = maskPath.CGPath;
    bgView.layer.mask = maskLayer;
}
+ (NSString *)getYiXuan:(NSString *)str {
    NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *encode_set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
    return str;
}
///处理字符串去掉字符
+ (NSString *)getNewSubStoreNameByRegularExpression:(NSString *)storeName{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[-()（）—”“$&@%^*?+?=|{}?【】？??￥!！.<>/:;：；、,，。0123456789]" options:NSRegularExpressionCaseInsensitive | NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines | NSRegularExpressionAllowCommentsAndWhitespace error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:storeName options:0 range:NSMakeRange(0, [storeName length]) withTemplate:@"pk"];
    return [result componentsSeparatedByString:@"pk"].firstObject;
}

+ (BOOL)isPureNumber:(NSString *)str {
    if ([self getNewSubStoreNameByRegularExpression:str].length > 0) {
        return false;
    }else{
        return true;
    }
}

+ (BOOL)isPureSpace:(NSString *)str {
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (str.length > 0) {
        return false;
    }else{
        return true;
    }
}

/**
 * 加粗字体方法
 * label 要加粗的 UILabel
 * BOOL YES = 加粗字体   NO = 去掉字体加粗
 */
+ (void)jiaCuFontFormLabel:(UILabel *)label jiaCu:(BOOL)jiaCu{
    NSString *fontname = label.font.fontName;
    CGFloat size = label.font.pointSize;
    //    NSLog(@"初始字体字号 %@=%f",fontname,size);
    //加粗
    if (jiaCu == YES) {
        if ([fontname hasSuffix:@"Times New Roman"]) {
            label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:size];
            return;
        }
        //        NSLog(@"加粗字体");
        // 判断现有字体  以 -Bold 结尾（已经加粗字体）
        if ([fontname hasSuffix:@"-Bold"]) {
            //            NSLog(@"字体本身就是粗体字");
        }else{
            // 加粗
            fontname = [fontname stringByAppendingString:@"-Bold"];
            label.font = [UIFont fontWithName:fontname size:size];
            //            NSLog(@"加粗字体成功 %@=%f",fontname,size);
        }
    }else{
        //        NSLog(@"去掉加粗字体");
        // 判断现有字体  以 -Bold 结尾（已经加粗字体）
        if ([fontname hasSuffix:@"-Bold"]) {
            // 去掉加粗
            fontname = [fontname  stringByReplacingOccurrencesOfString:@"-Bold" withString:@""];
            label.font = [UIFont fontWithName:fontname size:size];
            //            NSLog(@"去掉加粗字体成功 %@=%f",fontname,size);
        }else{
            //            NSLog(@"字体本身不是粗体字");
        }
    }
}

//+ (UIImage *)convertNVImage{
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0, XNWindowWidth,64)];
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[
//                             (__bridge id)rgb(255,80,127).CGColor,
//                             (__bridge id)rgba(255,80,127,0.95).CGColor,
//                             (__bridge id)rgba(255,80,127,0.9).CGColor];
//    gradientLayer.locations = @[@0.3, @0.5, @1.0];
//    gradientLayer.startPoint = CGPointMake(1.0,0);
//    gradientLayer.endPoint = CGPointMake(0,0);
//    gradientLayer.frame = backView.frame;
//    [backView.layer addSublayer:gradientLayer];
//    
//    UIImage *bgimage1 = [self convertViewToImage:backView];
//    return bgimage1;
//}

/**nowHours
 */
+ (NSString *)nowHours {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *nowStr = [fmt stringFromDate:now];
    return nowStr;
}

/**
 *  判断某个时间是否为一分钟之内
 */
+ (BOOL)isHours:(NSString *)dateStr {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *nowStr = [fmt stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
}

///正则去除网络标签
+ (NSString *)getZZwithString:(NSString *)string {
    if (string.length < 1) {
        return @"";
    }
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n|&nbsp"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

//将obj转换成json字符串。如果失败则返回nil.
+ (NSString *)toJsonString:(NSObject *)obj {
    
    //先判断是否能转化为JSON格式
    if (![NSJSONSerialization isValidJSONObject:obj])  return nil;
    NSError *error = nil;
    
    NSJSONWritingOptions jsonOptions = NSJSONWritingPrettyPrinted;
    if (@available(iOS 11.0, *)) {
        //11.0之后，可以将JSON按照key排列后输出，看起来会更舒服
        jsonOptions = NSJSONWritingPrettyPrinted | NSJSONWritingSortedKeys ;
    }
    //核心代码，字典转化为有格式输出的JSON字符串
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted  error:&error];
    if (error || !jsonData) return nil;
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}


#pragma mark 图片处理方法
//图片旋转处理
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (UIImageOrientationRight) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (UIImageOrientationRight) {
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (UIImageOrientationRight) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)getImageFromURL:(NSString *)fileURL {
    UIImage *result;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
+ (BOOL)image:(UIImage *)image1 isEqualTo:(UIImage *)image2 {
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    return[data1 isEqual:data2];
}
+ (void)showLogin:(UIView *)view {
    [UIView setUpLoginViewController];
    //[UIApplication sharedApplication].keyWindow.rootViewController = navController;
}
+ (void)showHome {
    Class clz = NSClassFromString(@"LCTabBarController");//将字符串转化成class
    UITabBarController *controller = [[clz alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = controller;
}
+ (void)showShopCar {
    Class clz = NSClassFromString(@"LCTabBarController");//将字符串转化成class
    UITabBarController *controller = [[clz alloc] init];
    //[UIApplication sharedApplication].keyWindow.rootViewController = controller;
    controller.selectedIndex = 3;
}

+ (void)showNoNetworkError {
    //[SVProgressHUD showErrorWithStatus:NoNetwork];
}

+ (NSString *)printPostDict:(NSDictionary *)parameters :(NSString *)url :(NSString *)appAccept :(NSString *)version{
    NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *encode_set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
    
    NSString *dict1jsonStr;
    {
        NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
//        [mutableDictionary setObject:[@"" addStr:kGZTool.accountInfoModel.token01] forKey:@"token"];

        dict1jsonStr = [mutableDictionary jsonStr];
        dict1jsonStr = [dict1jsonStr stringByReplacingOccurrencesOfString:@"}" withString:@""];
        dict1jsonStr = [dict1jsonStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        dict1jsonStr = [dict1jsonStr stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
        dict1jsonStr = [dict1jsonStr stringByReplacingOccurrencesOfString:@"%7B" withString:@"%0A"];
        dict1jsonStr = [dict1jsonStr stringByReplacingOccurrencesOfString:@"%2C" withString:@"%0A"];
        dict1jsonStr = [dict1jsonStr stringByReplacingOccurrencesOfString:@"%5C" withString:@""];
            //NSLog(@"Appid Appsecret = \n%@", dict1jsonStr);
    }
    //if (![[@"" addStr:parameters[@"uid"]] isPureNumber])
    NSString *dict2jsonStr = [parameters jsonStr];
    dict2jsonStr = [dict2jsonStr stringByReplacingOccurrencesOfString:@"、" withString:@"%E3%80%81"];
    dict2jsonStr = [dict2jsonStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    dict2jsonStr = [dict2jsonStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    dict2jsonStr = [dict2jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    dict2jsonStr = [dict2jsonStr stringByReplacingOccurrencesOfString:@":" withString:@"="];
    dict2jsonStr = [dict2jsonStr stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    dict2jsonStr = [dict2jsonStr stringByReplacingOccurrencesOfString:@"{" withString:@""];
    dict2jsonStr = [dict2jsonStr stringByReplacingOccurrencesOfString:@"}" withString:@""];
//    NSLog(@"dict2jsonStr = %@   %@",url, dict2jsonStr);
    dict2jsonStr = [NSString stringWithFormat:@"//coolaf.com/zh/tool/gp?u=%@&p=%@&c=&px=&h=%@",
                    [url stringByAddingPercentEncodingWithAllowedCharacters:encode_set],
                    [[@"" addStr:dict2jsonStr] stringByAddingPercentEncodingWithAllowedCharacters:encode_set],
                    [[@"Content-Type:application/x-www-form-urlencoded" stringByAddingPercentEncodingWithAllowedCharacters:encode_set] addStr:dict1jsonStr]
                    ];
//    NSLog(@"dict2jsonStr = \nhttp:%@", dict2jsonStr);
    return dict2jsonStr;
}



///跳转到商品详情页 1.GZShoppingMallDetail
+ (void)pushShopDetailVCWithView:(UIView *)view pid:(NSString *)pid model:(LCElevenHomeHotGoodsList *)model{
//    NSString *clzName = @"LCShopDetailViewController";
//    Class clz = NSClassFromString(clzName);//将字符串转化成class
//    UIViewController *viewController = [[clz alloc] init];
//    viewController.tabBarItem.title = [NSString stringWithFormat:@"%@",pid];
//    [[view viewController].navigationController pushViewController:viewController animated:YES];
    
//    LCShopDetailViewController *viewController = [[LCShopDetailViewController alloc] init];
//    viewController.pid = pid;
//    viewController.shopDetileModel = model;
//    [[view viewController].navigationController pushViewController:viewController animated:YES];
}

+ (NSString *)getSessionid {
    NSString *myUUIDStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *sessionidString = [NSString stringWithFormat:@"%@", [myUUIDStr MD5]];
    NSString *md5Str;
    for (NSInteger i = 0; i < 24; i++) {
        md5Str = [sessionidString substringWithRange:NSMakeRange(8, 16)];
    }
    return [@"iOS:" addStr:md5Str];
}

+ (void)clearLogin {
//    LCAccountInfoModel *accountInfoModel = [LCAccountInfoModel new];
//    kGZTool.accountInfoModel = accountInfoModel;
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:accountInfoModel];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:data forKey:@"accountInfo"];
//    [user synchronize];
//     _AccM.accountInfoModel = accountInfoModel;
//    _AccM.loginState = LoginStateNoOnline;
}

// 获取当前info信息
+ (NSString *)getAppCurInfoStrForkey:(NSString *)key {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurInfoStr = [infoDictionary objectForKey:key];
    return appCurInfoStr;
}

// 获取当前工程名称加点
+ (NSString *)getAppName {
    return [[LCUtils getAppCurInfoStrForkey:@"CFBundleName"] addStr:@"."];
}

 + (CGFloat)getStatusBarHight {
    float statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        statusBarHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

+ (NSString *)yiForKey:(NSString *)key {
    return [self yiForKey:key label:nil];
}

+ (NSString *)checkLanguage {
    NSString *langID = [[NSLocale preferredLanguages] firstObject];
    NSString *currentLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppLanguagesKey"];
//        [NSBundle setLanguage:@"en"];
//        [NSBundle setLanguage:@"zh-Hans"];
    if ([langID containsString:@"zh-Hans"]) {
        langID = @"zh";
    }else
    if ([langID hasPrefix:@"zh-HK"] ||[langID containsString:@"zh-Hant"]) {
        langID = @"cht";
    }else
    if ([langID isEqualToString:@"en"] || [langID hasPrefix:@"en-"]) {
        langID = @"en";
    }else
    if ([langID hasPrefix:@"fr-"]) {
        langID = @"fra";
    }else
    if ([langID hasPrefix:@"es-"]) {
        langID = @"spa";
    }else {
        langID = @"en";
    }
    // 设置默认语言
    currentLanguage = currentLanguage ? currentLanguage : langID;
    return currentLanguage;
}

+ (NSString *)debugYi:(NSString *)key label:(UILabel *)label {
    NSString *currentLanguage = [self checkLanguage];
//     * 百度翻译 query 要翻译的内容 lang 翻译成什么语言（zh:中文;cht:繁体中文';en:英文';fra:法语';spa:西班牙语';）
//    [YZSNetApiTools postFanYi:key :currentLanguage completion:^(NSURLSessionDataTask * _Nonnull task, YZSNetResponse * _Nonnull netResponse, NSError * _Nonnull error) {
//        if (netResponse.code == 200) {
//            NSString *str = (NSString *)netResponse.data;
//            if ([@"" addStr:str].length > 0) {
//                NSLog(@"需翻译 = %@ yi 翻译结果:%@",key, str);
//                if (label != nil) {
//                    
//                }
//            }
//        }else {
//            //                    NSString *appid = @"20200518000460588";
//            //                    NSString *secretKey = @"R1X8spgtcFtVIXbZsD6T";
//            //                    NSString *q = key;
//            //
//            //                    NSString *salt = [NSString stringWithFormat:@"%d", arc4random_uniform((65536 - 32768)) +(32768)];
//            //                //    NSString *salt = [NSString stringWithFormat:@"%.0f", NSDate.new.timeStamp];
//            //                    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",appid,q,salt,secretKey];
//            //
//            //                    sign = sign.MD5;
//            //                    NSDictionary *fanyi_parameters = @{
//            //                        @"appid" : [@"" addStr:appid],
//            //                        @"q" : [@"" addStr:q],
//            //                        @"from" : [@"" addStr:@"auto"],
//            //                        @"to" : [@"" addStr:currentLanguage],
//            //                        @"salt" : [@"" addStr:salt],
//            //                        @"sign" : [@"" addStr:sign]
//            //                    };
//            //                    NSString *URLString = @"http://api.fanyi.baidu.com/api/trans/vip/translate";
//            //                    [kNetworkTool GETWithUrlString:URLString parameters:fanyi_parameters success:^(NSDictionary *dict) {
//            //                        NSLog(@"dict = %@", dict);
//            //
//            ////                        {
//            ////                          "to" : "en",
//            ////                          "trans_result" : [
//            ////                            {
//            ////                              "src" : "教育",
//            ////                              "dst" : "education"
//            ////                            }
//            ////                          ],
//            ////                          "from" : "zh"
//            ////                        }
//            //                    } failure:^(NSError *error) {
//            //                    }];
//        }
//    }];
    return [[NSBundle mainBundle] localizedStringForKey:key value:nil table:@"Localizable"];
}

+ (NSString *)yiForKey:(NSString *)key label:(UILabel *)label {
    if (!(key.length > 0) && label != nil) {
        key = [@"" addStr:label.text];
    }
    #ifdef DEBUG
        return [self debugYi:key label:label];
    #else
    #endif
//    return GCLocalizedString(key);
    return [[NSBundle mainBundle] localizedStringForKey:key value:nil table:@"Localizable"];
}

+ (BOOL)isiPhoneX {
    return iPhoneX;
}

///cell id
+ (NSString *)lcCellId:(Class)aClass {
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass(aClass)];
}

/////显示错误信息
//+ (void)showErrorMsg:(NSError *)error :(YZSNetResponse *)netResponse {
//    if (netResponse.code != 200) {
//        if (netResponse == nil) {
//            //[SVProgressHUD showErrorWithStatus:[@"" addStr:netResponse.msg]];
//            [MBProgressHUD showMsg:error.localizedDescription];
//        }else{
//            [MBProgressHUD showMsg:netResponse.msg];
//        }
//    }
//}


+ (void)hudBox:(NSString *)msgString :(UIView *)view{
}

+ (void)showMsg:(NSString *)msgString {

}

+ (void)zhendong {
    UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
    [feedBackGenertor prepare];
    [feedBackGenertor impactOccurred];
}

+ (NSString *)transform:(NSString *)chinese {
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}

+ (NSString *)jiageByReplacing:(NSString *)result {
    result = [result stringByReplacingOccurrencesOfString:@"$" withString:@""];
    return result;
}

+ (NSBundle *)bundle {
    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"ZFPlayer" ofType:@"bundle"]];
    });
    return bundle;
}

+ (UIImage *)imageNamed:(NSString *)name {
    if (name.length == 0) return nil;
    int scale = (int)UIScreen.mainScreen.scale;
    if (scale < 2) scale = 2;
    else if (scale > 3) scale = 3;
    NSString *n = [NSString stringWithFormat:@"%@@%dx", name, scale];
    UIImage *image = [UIImage imageWithContentsOfFile:[self.bundle pathForResource:n ofType:@"png"]];
    if (!image) image = [UIImage imageWithContentsOfFile:[self.bundle pathForResource:name ofType:@"png"]];
    return image;
}

+ (NSString *)getUserName:(NSString *)uid {
//    NSDictionary *params = @{
//                             @"action":
//                                 [NSString stringWithFormat:
//                                 @"https://api.agora.io/dev/v1/channel/user/b2dc59f671ea460b8d25c23bbc3d3fb5/%@",uid],
//                             @"GET":@"true"
//                             };
//    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] initWithDictionary:params];
////    if (uid) {
////        [mutableDictionary setObject:uid forKey:@"channelName"];
////    }
////    [mutableDictionary setObject:@"b2dc59f671ea460b8d25c23bbc3d3fb5" forKey:@"appid"];
//
//    [YZSNetApiTools lcPostRequestUrlWithDict:mutableDictionary completion:^(NSURLSessionDataTask * _Nonnull task, YZSNetResponse * _Nonnull netResponse, NSError * _Nonnull error) {
//        if (netResponse.code == 200) {
////            NSString *result = (NSString *)netResponse.data;
////            NSLog(@"result = %@", result);
//            NSLog(@"netResponse.data = %@", netResponse.data);
////            if ([@"" addStr:result].length > 0) {
////                [MBProgressHUD showMsg:result];
////            }else{
////                [MBProgressHUD showMsg:netResponse.msg];
////            }
//        }
//    }];
    return @"1";
}

- (void)openUC:(NSString *)linkStr {
    NSString *charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *encode_set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"ucbrowser://"]]) {
        linkStr = [linkStr stringByAddingPercentEncodingWithAllowedCharacters:encode_set];

        [[UIApplication sharedApplication ] openURL:[NSURL URLWithString:[@"ucbrowser://" addStr:linkStr]] options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO} completionHandler:^(BOOL success) {
            NSLog(@"open uc...%d", success);
        }];
    }
}

+ (void)lcReachability:(NSString *)errorStr {
    BOOL status = [CoreStatus isNetworkEnable];
    if (!status) {
        [SVProgressHUD showErrorWithStatus:[@"" addStr:NoNetwork]];
    }else{
//        Reachability *reach = [Reachability reachabilityWithHostName:BASE_URL];
//        NetworkStatus status = [reach currentReachabilityStatus];
//        if (status == NotReachable){
//            [SVProgressHUD showErrorWithStatus:[@"" addStr:NoNetwork]];
//        }else{
//            //[SVProgressHUD showErrorWithStatus:[@"" addStr:NoServices]];
//        }
    }

}

///获取启动图
+ (UIImage *)getLaunchImage{
    
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOr = @"Portrait";//垂直
    NSString *launchImage = nil;
    NSArray *launchImages =  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary *dict in launchImages) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(viewSize, imageSize) && [viewOr isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImage];
}

//此方法把doubleString －－－> 价格 NSString
+ (NSString *)decimalNumberWithString:(NSString *)string {
   NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", string]];
    /*
    枚举
        NSRoundPlain,   // Round up on a tie   貌似取整
        NSRoundDown,    // Always down == truncate   只舍不入
        NSRoundUp,      // Always up     只入不舍
        NSRoundBankers  // on a tie round so last digit is even   貌似四舍五入
    */
//raiseOnExactness:发生精确错误时是否抛出异常，一般为NO
//raiseOnOverflow:发生溢出错误时是否抛出异常，一般为NO
//raiseOnUnderflow:发生不足错误时是否抛出异常，一般为NO
//raiseOnDivideByZero:被0除时是否抛出异常，一般为YES
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
    scale:2
                                                                                           raiseOnExactness:NO
                                                                                            raiseOnOverflow:NO
                                                                                           raiseOnUnderflow:NO
                                                                                        raiseOnDivideByZero:YES];
    NSDecimalNumber * ouncesDecimal = decNumber;
    NSDecimalNumber * roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *showX = [NSString stringWithFormat:@"%@",roundedOunces];
   return showX;
}

+ (NSString *)priceWithString:(NSString *)string {
    return [@"$" addStr:[self decimalNumberWithString:string]];
}

+ (NSString *)priceSpaceWithString:(NSString *)string {
    return [@"$ " addStr:[self decimalNumberWithString:string]];
}

@end
