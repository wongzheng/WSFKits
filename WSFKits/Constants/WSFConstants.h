//
//  WSFConstants.h
//  Pods
//
//  Created by wong on 2019/4/9.
//

#ifndef WSFConstants_h
#define WSFConstants_h

#import "WSFLayoutConstants.h"

#define CurrentViewController [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController viewControllers].lastObject
#define EndEditing()  [CurrentViewController.view endEditing:YES]

#define WSFAppVersion               [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define WeakSelfDefined \
__weak typeof(self) weakSelf = self;

//单例模式
#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

//单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

// 懒加载
#define LAZYLOAD(classname,propertyname)   \
- (classname *)propertyname \
{   \
if(!_##propertyname)  \
{   \
classname *propertyname = [classname new];  \
\
_##propertyname = propertyname;   \
}   \
return _##propertyname;   \
}
// ImageNamed
/* 直接填写图片名称，不用加@"" */
#define ImageName(name) [UIImage imageNamed:@(#name)]
#define StringFormat(format, ...)  [NSString stringWithFormat:format,  __VA_ARGS__]

#define PostNtfNamed(name) [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil]
#define PostNtf(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj]
#define AddSelfObserver(selName,ntfName) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selName) name:ntfName object:nil]
#define RemoveSelfObserver [[NSNotificationCenter defaultCenter]removeObserver:self]

#define WSFStringFromClass(name) NSStringFromClass([name class])
#define WSFTableRegisterClass(table, name) [table registerClass:[name class] forCellReuseIdentifier:NSStringFromClass([name class])];


// 信号量
#ifndef WSF_LOCK
#define WSF_LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#endif

#ifndef WSF_UNLOCK
#define WSF_UNLOCK(lock) dispatch_semaphore_signal(lock);
#endif

#define WSFSemaphoreCreate \
static dispatch_semaphore_t signalSemaphore; \
static dispatch_once_t onceTokenSemaphore; \
dispatch_once(&onceTokenSemaphore, ^{ \
    signalSemaphore = dispatch_semaphore_create(1); \
});

#define WSFSemaphoreWait WSF_LOCK(signalSemaphore)
#define WSFSemaphoreSignal WSF_UNLOCK(signalSemaphore)

#endif /* WSFConstants_h */
