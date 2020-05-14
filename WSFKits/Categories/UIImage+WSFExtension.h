//
//  UIImage+WSFExtension.h
//  BGFMDB
//
//  Created by wong on 2019/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WSFExtension)
/** 根据传入的比例缩放图片 */
- (UIImage *)scaleImageToScale:(float)scaleSize;

/** 将图片用传入的颜色重绘 */
- (UIImage *)imageWithColor:(UIColor *)color;
/** 使用高斯模糊的方式重绘图片 */
- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur;

@end

NS_ASSUME_NONNULL_END
