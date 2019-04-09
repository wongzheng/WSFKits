//
//  UIView+WSFExtension.h
//  Pods-WSFKits_Example
//
//  Created by wong on 2019/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WSFExtension)

/**
 *  视图按传入颜色水平垂直等分渐变
 */
- (void)gradientLayerWithColors:(NSArray<UIColor *> *)colors horizontal:(BOOL)isHorizontal vertical:(BOOL)isVertical;
/**
 *  设置视图的圆角大小
 */
- (void)setCornerRadius:(CGFloat)radius;
/**
 *  设置视图的边框宽度及颜色
 */
- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
