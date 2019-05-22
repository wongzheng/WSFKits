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

#endif /* WSFConstants_h */
