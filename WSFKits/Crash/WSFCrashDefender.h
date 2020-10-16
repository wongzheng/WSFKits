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
 * shieldAll = holdRuntimeCrash + holdUncaughtException
 *
 */
+ (void)shieldAll;
/*
 * Hold Normal Runtime Crash
 * unrecognized selector
 * NSArray index out of bounds
 */
+ (void)holdRuntimeCrash;
+ (void)holdUncaughtException;

@end

NS_ASSUME_NONNULL_END
