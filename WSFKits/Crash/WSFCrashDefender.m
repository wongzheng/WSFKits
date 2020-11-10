//
//  WSFCrashDefender.m
//  WSFKits
//
//  Created by wong on 2020/10/9.
//

#import "WSFCrashDefender.h"
#import "NSObject+WSFCrash.h"
#import "WSFUncaughtExceptionDefender.h"

@implementation WSFCrashDefender

+ (void)shield {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self holdRuntimeCrash];
        [self holdUncaughtException];
    });
}
+ (void)holdRuntimeCrash {
    [NSObject shield];
    [NSArray shield];
}

+ (void)holdUncaughtException {
    [WSFUncaughtExceptionDefender shield];
}

@end
