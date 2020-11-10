//
//  UIView+WSFExtension.h
//  Pods-WSFKits_Example
//
//  Created by wong on 2019/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, UIBorderSideType) {

UIBorderSideTypeAll = 0,

UIBorderSideTypeTop = 1 << 0,

UIBorderSideTypeBottom = 1 << 1,

UIBorderSideTypeLeft = 1 << 2,

UIBorderSideTypeRight = 1 << 3,
};


@interface UIView (WSFExtension)

@property (nonatomic, getter=isShown) BOOL shown;

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
/**
 *  设置边界的方向，颜色及宽度
 */
- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType;

- (CGFloat)width_wsf;
- (CGFloat)height_wsf;
- (CGFloat)x_wsf;
- (CGFloat)y_wsf;

- (void)bezierCornerWithRadius:(CGFloat)radius corner:(UIRectCorner)corner;

@end

NS_ASSUME_NONNULL_END
