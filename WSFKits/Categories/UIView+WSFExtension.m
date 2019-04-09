//
//  UIView+WSFExtension.m
//  Pods-WSFKits_Example
//
//  Created by wong on 2019/4/9.
//

#import "UIView+WSFExtension.h"

@implementation UIView (WSFExtension)

- (void)gradientLayerWithColors:(NSArray<UIColor *> *)colors horizontal:(BOOL)isHorizontal vertical:(BOOL)isVertical
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    NSMutableArray *array = [NSMutableArray array];
    for (UIColor *color in colors) {
        [array addObject:(id)color.CGColor];
    }
    gradientLayer.colors = [array copy];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(isHorizontal, isVertical);
    [self.layer addSublayer:gradientLayer];
}

- (void)setCornerRadius:(CGFloat)radius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}

- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}
@end
