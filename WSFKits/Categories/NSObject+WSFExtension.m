//
//  NSObject+WSFExtension.m
//  Pods-WSFKits_Example
//
//  Created by wong on 2019/4/9.
//

#import "NSObject+WSFExtension.h"

@implementation NSObject (WSFExtension)

- (BOOL)isValuable
{
    if ([self isKindOfClass:[NSString class]])
    {
        return [NSObject isValuableWithString:(NSString *)self];
    }
    if ([self isKindOfClass:[NSArray class]])
    {
        return [NSObject isValuableWithArray:(NSArray *)self];
    }
    return YES;
}

+ (BOOL)isValuableWithString:(NSString *)str
{
    NSString *strRemoveSpace = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return strRemoveSpace.length;
}

+ (BOOL)isValuableWithArray:(NSArray *)arr
{
    return arr.count > 0;
}

@end
