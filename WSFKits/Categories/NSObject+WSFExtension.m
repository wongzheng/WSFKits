//
//  NSObject+WSFExtension.m
//  Pods-WSFKits_Example
//
//  Created by wong on 2019/4/9.
//

#import "NSObject+WSFExtension.h"
#import <objc/runtime.h>

@implementation NSObject (WSFExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL msSelector = @selector(methodSignatureForSelector:);
        SEL swizzledMSSelector = @selector(wsf_methodSignatureForSelector:);
        SEL fiSelector = @selector(forwardInvocation:);
        SEL swizzledFISelector = @selector(wsf_forwardInvocation:);
        Method meMethod = class_getInstanceMethod(class, msSelector);
        Method swizzledMSMethod = class_getInstanceMethod(class, swizzledMSSelector);
        Method fiMethod = class_getInstanceMethod(class, fiSelector);
        Method swizzledFIMethod = class_getInstanceMethod(class, swizzledFISelector);
        
        // Attempt adding the methods
        BOOL didAddMSMethod =
        class_addMethod(class,
                        msSelector,
                        method_getImplementation(swizzledMSMethod),
                        method_getTypeEncoding(swizzledMSMethod));
        
        BOOL didAddFIMethod =
        class_addMethod(class,
                        fiSelector,
                        method_getImplementation(swizzledFIMethod),
                        method_getTypeEncoding(swizzledFIMethod));
        
        // Replace methods
        if (didAddMSMethod) {
            class_replaceMethod(class,
                                swizzledMSSelector,
                                method_getImplementation(swizzledMSMethod),
                                method_getTypeEncoding(swizzledMSMethod));
        } else {
            method_exchangeImplementations(meMethod, swizzledMSMethod);
        }
        
        if (didAddFIMethod) {
            class_replaceMethod(class,
                                swizzledFISelector,
                                method_getImplementation(swizzledFIMethod),
                                method_getTypeEncoding(swizzledFIMethod));
        } else {
            method_exchangeImplementations(fiMethod, swizzledFIMethod);
        }
    });
}

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
    BOOL isVoid = strRemoveSpace.length;
    return !isVoid;
}

+ (BOOL)isValuableWithArray:(NSArray *)arr
{
    return arr.count > 0;
}

- (NSMethodSignature *)wsf_methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)wsf_forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"找不到%@类型的%@方法", NSStringFromClass(self.class), NSStringFromSelector(anInvocation.selector));
}


@end
