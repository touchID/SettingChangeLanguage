//
//  LCGradientView.h
//  HotelRoomPrice
//
//  Created by lu on 2022/10/27.
//  Copyright © 2022 hassbrain. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LCGradientViewDirection) {
    LCGradientViewDirectionToUp,
    LCGradientViewDirectionToDown,
    LCGradientViewDirectionToLeft,
    LCGradientViewDirectionToRight
};
///渐变BG层
@interface LCGradientView : UIView

@property (assign, nonatomic)  IBInspectable LCGradientViewDirection     direction;

@property (strong, nonatomic)  IBInspectable UIColor                     *beginColor;

@property (strong, nonatomic)  IBInspectable UIColor                     *endColor;

- (instancetype)initWithType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
