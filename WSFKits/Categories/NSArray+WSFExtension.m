//
//  NSArray+WSFExtension.m
//  WSFKits_Example
//
//  Created by wong on 2019/4/11.
//  Copyright © 2019 zbad1171@qq.com. All rights reserved.
//

#import "NSArray+WSFExtension.h"
#import <objc/runtime.h>

@implementation NSArray (WSFExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"__NSArrayM");
        Method insertMethod = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
        Method swizzingInsertMethod = class_getInstanceMethod(cls, @selector(wsf_insertObject:atIndex:));
        method_exchangeImplementations(insertMethod, swizzingInsertMethod);
    });
}

- (void)wsf_insertObject:(NSObject *)obj atIndex:(NSUInteger)index {
    if(!obj) {
        NSLog(@"wsf_nsarray add nil object!");
        return;
    }
    [self wsf_insertObject:obj atIndex:index];
}

@end
