//
//  UIView+WSFExtension.m
//  Pods-WSFKits_Example
//
//  Created by wong on 2019/4/9.
//

#import "UIView+WSFExtension.h"
#import "NSObject+WSFExtension.h"
#import <objc/runtime.h>

@interface WSFCornerModel : NSObject

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) UIRectCorner corner;

@end

@implementation WSFCornerModel @end

@interface UIView()

@property (nonatomic, strong) WSFCornerModel *cornerModel;

@end

@implementation UIView (WSFExtension)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self wsf_SwizzlingInstanceMethod:@selector(layoutSubviews) withMethod:@selector(wsf_layoutSubviews)];
    });
}

- (BOOL)isShown {
    return !self.isHidden;
}

- (void)setShown:(BOOL)shown {
    self.hidden = !shown;
}

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
//    [self bezierCornerWithRadius:radius corner:UIRectCornerAllCorners];
}

- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (UIView *)borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(UIBorderSideType)borderType {
    if (borderType == UIBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return self;
    }
    if (borderType & UIBorderSideTypeLeft) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.f, 0.f) toPoint:CGPointMake(0.0f, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    if (borderType & UIBorderSideTypeRight) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(self.frame.size.width, 0.0f) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    if (borderType & UIBorderSideTypeTop) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, 0.0f) toPoint:CGPointMake(self.frame.size.width, 0.0f) color:color borderWidth:borderWidth]];
    }
    if (borderType & UIBorderSideTypeBottom) {
        [self.layer addSublayer:[self addLineOriginPoint:CGPointMake(0.0f, self.frame.size.height) toPoint:CGPointMake( self.frame.size.width, self.frame.size.height) color:color borderWidth:borderWidth]];
    }
    return self;
}

- (CAShapeLayer *)addLineOriginPoint:(CGPoint)p0 toPoint:(CGPoint)p1 color:(UIColor *)color borderWidth:(CGFloat)borderWidth
{
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p0];
    [bezierPath addLineToPoint:p1];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.lineWidth = borderWidth;
    return shapeLayer;
}

- (CGFloat)width_wsf {
    return self.frame.size.width;
}

- (CGFloat)height_wsf {
    return self.frame.size.height;
}

- (CGFloat)x_wsf {
    return self.frame.origin.x;
}

- (CGFloat)y_wsf {
    return self.frame.origin.y;
}

- (void)bezierCornerWithRadius:(CGFloat)radius corner:(UIRectCorner)corner {
    WSFCornerModel *model = [WSFCornerModel new];
    model.radius = radius;
    model.corner = corner;
    self.cornerModel = model;
}

- (void)wsf_layoutSubviews {
    WSFCornerModel *model = self.cornerModel;
    if (model) {
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:model.corner cornerRadii:CGSizeMake(model.radius, model.radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
    [self wsf_layoutSubviews];
}

- (WSFCornerModel *)cornerModel{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCornerModel:(WSFCornerModel *)cornerModel {
    objc_setAssociatedObject(self, @selector(cornerModel), cornerModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)clearSublayers {
    for (CALayer *layer in self.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
}

@end
