//
//  NSString+WSFExtension.h
//  BGFMDB
//
//  Created by wong on 2019/5/9.
//

#import <Foundation/Foundation.h>

#define WSF_HourTimeInterval (3600)
#define WSF_DayTimeInterval (24 * WSF_HourTimeInterval)

NS_ASSUME_NONNULL_BEGIN

@interface NSString (WSFExtension)

+ (NSString *)stringWithTimeInerval:(NSTimeInterval)timeInterval format:(NSString *)format;
+ (NSTimeInterval)timeInervalWithString:(NSString *)string format:(NSString *)format;

+ (NSArray *)cDayName;
+ (NSArray *)cMonName;
+ (NSArray *)weekDay;

- (NSString *)endingSubstringWithCount:(NSInteger)count;
/**
 * 清除html标签
 */
- (NSString *)wsf_filterHTML;

- (NSDictionary *)wsf_dictionary;


@end

NS_ASSUME_NONNULL_END
