//
//  NSMutableArray+WSFCrash.m
//  WSFKits
//
//  Created by wong on 2020/10/12.
//

#import "NSMutableArray+WSFCrash.h"

@implementation NSMutableArray (WSFCrash)

-(id)wsf_objectAtIndexedSubscript:(NSUInteger)index{
    if(index>=self.count){
        //代码处理 上传服务器.
        NSLog(@"可变数组取值超限：长度为%tu,取第%tu", self.count, index);
        return nil;
    }
    return [self wsf_objectAtIndexedSubscript:index] ;
}

-(id)wsf_objectAtIndex:(NSUInteger)index{
    if(index>=self.count){
        //代码处理 上传服务器.
        NSLog(@"可变数组取值超限：长度为%tu,取第%tu", self.count, index);
        return nil;
    }
    return [self wsf_objectAtIndex:index] ;
}
@end
