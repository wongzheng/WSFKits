//
//  WSFTimer.m
//  MediaEditingSystem
//
//  Created by wong on 2019/10/8.
//  Copyright © 2019 Wong. All rights reserved.
//

#import "WSFTimer.h"
#import "NSObject+WSFExtension.h"

@implementation WSFTimer

static NSMutableDictionary *wsftimers_;
dispatch_semaphore_t wsfsemaphore_;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wsftimers_ = [NSMutableDictionary dictionary];
        wsfsemaphore_ = dispatch_semaphore_create(1);
    });
}


+ (NSString *)execTask:(void(^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    if (!task || start < 0 || (interval <=0 && repeats)) {
        return nil;
    }
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    dispatch_semaphore_wait(wsfsemaphore_, DISPATCH_TIME_FOREVER);
    
    NSString *name = [NSString stringWithFormat:@"%zd", wsftimers_.count];
    wsftimers_[name] = timer;
    
    dispatch_semaphore_signal(wsfsemaphore_);
    
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    
    dispatch_resume(timer);
    
    return name;
}

+ (void)cancelTask:(NSString *)name {
    if (![name isValuable]) {
        return;
    }
    
    dispatch_semaphore_wait(wsfsemaphore_, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t timer = wsftimers_[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [wsftimers_ removeObjectForKey:name];
    }
    dispatch_semaphore_signal(wsfsemaphore_);
}


@end
