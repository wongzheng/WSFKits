//
//  WSFCrashDefender.h
//  WSFKits
//
//  Created by wong on 2020/10/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSFCrashDefender : NSObject

/**
 * shield = holdRuntimeCrash + holdUncaughtException
 *
 */
+ (void)shield;
/*
 * Hold Normal Runtime Crash
 * unrecognized selector
 * NSArray index out of bounds
 */
+ (void)holdRuntimeCrash;
+ (void)holdUncaughtException;

+ (void)realQuit;

@end

NS_ASSUME_NONNULL_END
