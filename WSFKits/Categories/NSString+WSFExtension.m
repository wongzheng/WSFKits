//
//  NSString+WSFExtension.m
//  BGFMDB
//
//  Created by wong on 2019/5/9.
//

#import "NSString+WSFExtension.h"

@implementation NSString (WSFExtension)

- (NSString *)endingSubstringWithCount:(NSInteger)count {
    if (self.length < count) {
        return [self copy];
    }
    return [self substringWithRange:NSMakeRange(self.length-count, count)];
}

@end
