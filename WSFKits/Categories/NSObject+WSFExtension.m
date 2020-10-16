//
//  NSObject+WSFExtension.m
//  Pods-WSFKits_Example
//
//  Created by wong on 2019/4/9.
//

#import "NSObject+WSFExtension.h"
#import <objc/runtime.h>

@implementation NSObject (WSFExtension)

- (BOOL)isValuable
{
    if ([self isKindOfClass:[NSString class]])
    {
        return [NSObject isValuableWithString:(NSString *)self];
    }
    if ([self isKindOfClass:[NSArray class]])
    {
        return [NSObject isValuableWithArray:(NSArray *)self];
    }
    return YES;
}

+ (BOOL)isValuableWithString:(NSString *)str
{
    NSString *strRemoveSpace = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return strRemoveSpace.length;
}

+ (BOOL)isValuableWithArray:(NSArray *)arr
{
    return arr.count > 0;
}

+ (void)getAllMethod {
    unsigned int count;
    Method*methodList =class_copyMethodList(self, &count);// 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
        // 遍历所有的方法
        for(int i =0; i < count; i++) {
            // 获得方法
            Method method = methodList[i];
            // 获得方法名
            NSString *methodName = NSStringFromSelector(method_getName(method));
            // 拼接方法名
            [methodNames appendString:methodName];
            [methodNames appendString:@"\n"];
        }
        // 释放
        free(methodList);
        // 打印方法名
        NSLog(@"%@ - %@", self, methodNames);
}

+ (void)wsf_SwizzlingClassMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector {
    Method originalMethod = class_getClassMethod(self, originalSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);

    BOOL didAddMethod = class_addMethod(self,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(self,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)wsf_SwizzlingInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);

    BOOL didAddMethod = class_addMethod(self,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(self,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
