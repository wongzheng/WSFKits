//
//  NSString+WSFExtension.m
//  BGFMDB
//
//  Created by wong on 2019/5/9.
//

#import "NSString+WSFExtension.h"

@implementation NSString (WSFExtension)

+ (NSString *)stringWithTimeInerval:(NSTimeInterval)timeInterval format:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSTimeInterval)timeInervalWithString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.timeZone = [NSTimeZone localTimeZone];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    return [date timeIntervalSince1970];
}

+ (NSArray *)cDayName {
    return [NSArray arrayWithObjects:@"*", @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",nil];
}

+ (NSArray *)cMonName{
    return [NSArray arrayWithObjects:@"*", @"正", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @"十一", @"腊", nil];
}

+ (NSArray *)weekDay{
    return [NSArray arrayWithObjects:@"", @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
}

- (NSString *)endingSubstringWithCount:(NSInteger)count {
    if (self.length < count) {
        return [self copy];
    }
    return [self substringWithRange:NSMakeRange(self.length-count, count)];
}




@end
