//
//  LCGradientView.m
//  HotelRoomPrice
//
//  Created by lu on 2022/10/27.
//  Copyright © 2022 hassbrain. All rights reserved.
//

#import "LCGradientView.h"

@implementation LCGradientView

- (void)setupUI1 {
    self.beginColor = [UIColor colorWithWhite:0.2 alpha:0.3];
    self.endColor = [UIColor colorWithWhite:0.2 alpha:0.6];
    self.direction = 1;
}
- (void)setupUI2 {
    self.beginColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    self.endColor = [UIColor clearColor];//colorWithWhite:0.2 alpha:0.5];
    self.direction = 2;
}
// 设置当前视图中是一个渐变层
+ (Class)layerClass {
    return [CAGradientLayer class];
}

// 重新显示刷新界面
- (void)refresh {
    if(self.direction == LCGradientViewDirectionToUp) {
        // 定义一个渐变的颜色数组
        NSMutableArray *cfColors = [NSMutableArray array];
        
        if(self.endColor != nil) {
            [cfColors addObject:(id)self.endColor.CGColor];
        }
        
        if(self.beginColor != nil) {
            [cfColors addObject:(id)self.beginColor.CGColor];
        }
        ((CAGradientLayer *)self.layer).colors = cfColors;
        
        ((CAGradientLayer *)self.layer).startPoint = CGPointMake(0, 0);
        
        ((CAGradientLayer *)self.layer).endPoint = CGPointMake(0, 1);
        
    } else if(self.direction == LCGradientViewDirectionToDown) {
        // 定义一个渐变的颜色数组
        NSMutableArray *cfColors = [NSMutableArray array];
        
        if(self.beginColor != nil) {
            [cfColors addObject:(id)self.beginColor.CGColor];
        }
        
        if(self.endColor != nil) {
            [cfColors addObject:(id)self.endColor.CGColor];
        }
        
        
        ((CAGradientLayer *)self.layer).colors = cfColors;
        
        ((CAGradientLayer *)self.layer).startPoint = CGPointMake(0, 0);
        
        ((CAGradientLayer *)self.layer).endPoint = CGPointMake(0, 1);
    } else if(self.direction == LCGradientViewDirectionToLeft) {
        // 定义一个渐变的颜色数组
        NSMutableArray *cfColors = [NSMutableArray array];
        
        if(self.endColor != nil) {
            [cfColors addObject:(id)self.endColor.CGColor];
        }
        
        if(self.beginColor != nil) {
            [cfColors addObject:(id)self.beginColor.CGColor];
        }
        ((CAGradientLayer *)self.layer).colors = cfColors;
        
        ((CAGradientLayer *)self.layer).startPoint = CGPointMake(0, 0);
        
        ((CAGradientLayer *)self.layer).endPoint = CGPointMake(1, 0);
    } else if(self.direction == LCGradientViewDirectionToRight) {
        // 定义一个渐变的颜色数组
        NSMutableArray *cfColors = [NSMutableArray array];
        
        
        if(self.beginColor != nil) {
            [cfColors addObject:(id)self.beginColor.CGColor];
        }
        
        if(self.endColor != nil) {
            [cfColors addObject:(id)self.endColor.CGColor];
        }
        
        
        
        ((CAGradientLayer *)self.layer).colors = cfColors;
        
        ((CAGradientLayer *)self.layer).startPoint = CGPointMake(0, 0);
        
        ((CAGradientLayer *)self.layer).endPoint = CGPointMake(1, 0);
    }
    
    ((CAGradientLayer *)self.layer).locations = @[@0.0,@1.0];
    
}

- (void)setDirection:(LCGradientViewDirection)direction {
    _direction = direction;
    [self refresh];
}

- (void)setBeginColor:(UIColor *)beginColor {
    _beginColor = beginColor;
    [self refresh];
}

- (void)setEndColor:(UIColor *)endColor {
    _endColor = endColor;
    [self refresh];
}

- (instancetype)initWithType:(NSInteger)type {
    self = [super init];
    if (self) {
        if (type == 1) {
            [self setupUI1];
        }
        else
        if (type == 2) {
            [self setupUI2];
        }
        else{
            [self setupUI1];
        }
    }
    return self;
}

@end
