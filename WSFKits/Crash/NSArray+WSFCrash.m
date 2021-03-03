//
//  NSArray+WSFCrash.m
//  WSFKits
//
//  Created by wong on 2020/10/10.
//

#import "NSArray+WSFCrash.h"
#import "NSObject+WSFExtension.h"
#import <objc/runtime.h>

@implementation NSArray (WSFCrash)
+ (void)shield {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSArrayI") wsf_SwizzlingInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(wsf_objectAtIndex:)];
        [objc_getClass("__NSArrayI") wsf_SwizzlingInstanceMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(wsf_objectAtIndexedSubscript:)];
        [objc_getClass("__NSArrayM") wsf_SwizzlingInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(wsf_mutableObjectAtIndex:)];
        [objc_getClass("__NSArrayM") wsf_SwizzlingInstanceMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(wsf_mutableObjectAtIndexedSubscript:)];
        [objc_getClass("__NSArrayM") wsf_SwizzlingInstanceMethod:@selector(insertObject:atIndex:) withMethod:@selector(wsf_mutableInsertObject:atIndex:)];
    });
}

- (id)wsf_objectAtIndex:(NSUInteger)index {
    if(index>=self.count){
        //代码处理 上传服务器.
        NSLog(@"数组取值超限：长度为%tu,取第%tu", self.count, index);
        return nil;
    }
    return [self wsf_objectAtIndex:index] ;
    
}
-(id)wsf_objectAtIndexedSubscript:(NSUInteger)index{
    if(index>=self.count){
        //代码处理 上传服务器.
        NSLog(@"数组取值超限：长度为%tu,取第%tu", self.count, index);
        return nil;
    }
    return [self wsf_objectAtIndexedSubscript:index] ;
}

-(id)wsf_mutableObjectAtIndexedSubscript:(NSUInteger)index{
    if(index>=self.count){
        //代码处理 上传服务器.
        NSLog(@"可变数组取值超限：长度为%tu,取第%tu", self.count, index);
        return nil;
    }
    return [self wsf_mutableObjectAtIndexedSubscript:index] ;
}

-(id)wsf_mutableObjectAtIndex:(NSUInteger)index{
    if(index>=self.count){
        //代码处理 上传服务器.
        NSLog(@"可变数组取值超限：长度为%tu,取第%tu", self.count, index);
        return nil;
    }
    return [self wsf_mutableObjectAtIndex:index] ;
}

- (void)wsf_mutableInsertObject:(id)object atIndex:(NSUInteger)index{
    if (object) {
        [self wsf_mutableInsertObject:object atIndex:index];
    } else {
        NSLog(@"可变数组插入空值");
    }
}
@end
