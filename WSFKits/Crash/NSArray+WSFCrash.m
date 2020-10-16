//
//  NSArray+WSFCrash.m
//  WSFKits
//
//  Created by wong on 2020/10/10.
//

#import "NSArray+WSFCrash.h"
#import "NSObject+WSFExtension.h"
#import "NSMutableArray+WSFCrash.h"
#import <objc/runtime.h>

@implementation NSArray (WSFCrash)
+ (void)shield {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSArray wsf_SwizzlingInstanceMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(wsf_objectAtIndexedSubscript:)];
    });
}
-(id)wsf_objectAtIndexedSubscript:(NSUInteger)index{
    if(index>=self.count){
        //代码处理 上传服务器.
        NSLog(@"数组取值超限：长度为%tu,取第%tu", self.count, index);
        return nil;
    }
    return [self wsf_objectAtIndexedSubscript:index] ;
}

@end
