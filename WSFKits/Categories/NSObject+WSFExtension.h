//
//  NSObject+WSFExtension.h
//  Pods-WSFKits_Example
//
//  Created by wong on 2019/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (WSFExtension)

- (BOOL)isValuable;

+ (void)wsf_SwizzlingClassMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector;
+ (void)wsf_SwizzlingInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector;
+ (void)getAllMethod;
@end

NS_ASSUME_NONNULL_END
