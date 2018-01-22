//
//  NSDate+STCalendar.h
//  LDCalendarView
//
//  Created by yuyue on 2017/4/25.
//  Copyright © 2017年 lidi. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SEL_COLOR [UIColor colorWithRed:74/255.f green:66/255.f blue:255/255.f alpha:1]

#define NOR_COLOR [UIColor colorWithRed:248/255.f green:247/255.f blue:255/255.f alpha:1]

#define WORK_COLOR [UIColor colorWithRed:248/255.f green:247/255.f blue:255/255.f alpha:1]

@interface NSDate (STCalendar)



/**
 Acquire the week index from date.
 **/
+ (NSInteger)acquireWeekDayFromDate:(NSDate*)date ;



- (NSInteger)day;
- (NSInteger)month;
- (NSInteger)year;


// 当前日期后第几天
- (NSDate *)nextDateWithDay:(NSInteger)day ;


- (NSString *)acquireDateString ;

+ (NSDate*)acquireDateWithStr:(NSString*)str ;


- (BOOL)isInStartDate:(NSDate*)startDate endDate:(NSDate*)endDate ;

@end
