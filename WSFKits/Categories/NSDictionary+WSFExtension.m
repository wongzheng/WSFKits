//
//  NSDictionary+WSFExtension.m
//  WSFKits_Example
//
//  Created by wong on 2019/4/11.
//  Copyright © 2019 zbad1171@qq.com. All rights reserved.
//

#import "NSDictionary+WSFExtension.h"
#import <objc/runtime.h>

@implementation NSDictionary (WSFExtension)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"__NSDictionaryM");
        Method sofkMethod = class_getInstanceMethod(cls, @selector(setObject:forKeyedSubscript:));
        Method swizzingSOFKMethod = class_getInstanceMethod(cls, @selector(wsf_setObject:forKeyedSubscript:));
        method_exchangeImplementations(sofkMethod, swizzingSOFKMethod);
    });
}


- (void)wsf_setObject:(id)obj forKeyedSubscript:(id)subscrip {
    if (!subscrip) {
        NSLog(@"wsf_dictionary set objc with nil key!");
        return;
    }
    [self wsf_setObject:obj forKeyedSubscript:subscrip];
}

@end
