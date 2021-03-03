//
//  UIImage+WSFExtension.m
//  BGFMDB
//
//  Created by wong on 2019/5/21.
//

#import "UIImage+WSFExtension.h"

@implementation UIImage (WSFExtension)

+ ( UIImage *)grayImage:( UIImage *)sourceImage {
     int  width = sourceImage. size . width ;
     int  height = sourceImage. size . height ;
     CGColorSpaceRef  colorSpace =  CGColorSpaceCreateDeviceGray ();
     CGContextRef  context =  CGBitmapContextCreate  ( nil , width, height, 8 , 0 , colorSpace, kCGImageAlphaNone );
     CGColorSpaceRelease (colorSpace);
     if  (context == NULL ) {
         return  nil ;
    }
     CGContextDrawImage (context, CGRectMake ( 0 , 0 , width, height), sourceImage. CGImage );
     UIImage  *grayImage = [ UIImage imageWithCGImage : CGBitmapContextCreateImage (context)];
     CGContextRelease (context);
     return  grayImage;
}

- (UIImage *)scaleImageToScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *ciImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    //设置模糊程度
    [filter setValue:@(blur) forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:ciImage.extent];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

@end
