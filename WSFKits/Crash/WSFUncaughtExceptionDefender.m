//
//  WSFUncaughtExceptionDefender.m
//  WSFKits
//
//  Created by wong on 2020/10/12.
//

#import "WSFUncaughtExceptionDefender.h"
#import "WSFConstants.h"
#include <libkern/OSAtomic.h>
#include <execinfo.h>

static BOOL dismissed;
static NSUncaughtExceptionHandler *otherHandler = nil;

volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 10;

const NSInteger UncaughtExceptionHandlerSkipAddressCount = 4;
const NSInteger UncaughtExceptionHandlerReportAddressCount = 5;

NSString * const UncaughtExceptionHandlerSignalExceptionName = @"UncaughtExceptionHandlerSignalExceptionName";
NSString * const UncaughtExceptionHandlerSignalKey = @"UncaughtExceptionHandlerSignalKey";
NSString * const UncaughtExceptionHandlerAddressesKey = @"UncaughtExceptionHandlerAddressesKey";

@implementation WSFUncaughtExceptionDefender

+ (void)shield {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        otherHandler = NSGetUncaughtExceptionHandler();
        NSSetUncaughtExceptionHandler(WSFCrashExceptionHandler);
        signal(SIGABRT, SignalHandler);
        signal(SIGILL, SignalHandler);
        signal(SIGSEGV, SignalHandler);
        signal(SIGFPE, SignalHandler);
        signal(SIGBUS, SignalHandler);
        signal(SIGPIPE, SignalHandler);
    });
}

+ (void)showLogWithException:(NSException *)exception {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"程序遇到了未知错误即将崩溃！" message:@"错误代码：9527" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            dismissed = YES;
    }]];
    UIViewController *currentVC = [UIApplication sharedApplication].delegate.window.rootViewController;

    [currentVC presentViewController:alert animated:YES completion:nil];
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFArrayRef allModes = CFRunLoopCopyAllModes(runLoop);
    
    while (!dismissed)
    {
        for (NSString *mode in (__bridge NSArray *)allModes)
        {
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, true);
        }
    }
    CFRelease(allModes);
    NSSetUncaughtExceptionHandler(NULL);
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
}

+ (NSArray *)backtrace
{
     void* callstack[128];
     int frames = backtrace(callstack, 128);
     char **strs = backtrace_symbols(callstack, frames);
     
     int i;
     NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
     for (
         i = UncaughtExceptionHandlerSkipAddressCount;
         i < UncaughtExceptionHandlerSkipAddressCount +
            UncaughtExceptionHandlerReportAddressCount;
        i++)
     {
         [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
     }
     free(strs);
     
     return backtrace;
}

void WSFCrashExceptionHandler(NSException *exception)
{
    // 日志记录写入文件
//    WriteCrashLogToFile(exception);
    
    [WSFUncaughtExceptionDefender
        performSelectorOnMainThread:@selector(showLogWithException:)
        withObject:exception
        waitUntilDone:YES];
    
    //调用别人的Handler
    if (otherHandler && otherHandler != WSFCrashExceptionHandler) {
        otherHandler(exception);
    }
}

void SignalHandler(int signal)
{
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum)
    {
        return;
    }
    
    NSMutableDictionary *userInfo =
        [NSMutableDictionary
            dictionaryWithObject:[NSNumber numberWithInt:signal]
            forKey:UncaughtExceptionHandlerSignalKey];

    NSArray *callStack = [WSFUncaughtExceptionDefender backtrace];
    [userInfo
        setObject:callStack
        forKey:UncaughtExceptionHandlerAddressesKey];
    
    [WSFUncaughtExceptionDefender
        performSelectorOnMainThread:@selector(showLogWithException:)
        withObject:
            [NSException
                exceptionWithName:UncaughtExceptionHandlerSignalExceptionName
                reason:
                    [NSString stringWithFormat:
                        NSLocalizedString(@"Signal %d was raised.", nil),
                        signal]
                userInfo:
                    [NSDictionary
                        dictionaryWithObject:[NSNumber numberWithInt:signal]
                        forKey:UncaughtExceptionHandlerSignalKey]]
        waitUntilDone:YES];
}


@end
