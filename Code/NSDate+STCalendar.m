//
//  NSDate+STCalendar.m
//  LDCalendarView
//
//  Created by yuyue on 2017/4/25.
//  Copyright © 2017年 lidi. All rights reserved.
//

#import "NSDate+STCalendar.h"

@implementation NSDate (STCalendar)




+ (NSInteger)acquireWeekDayFromDate:(NSDate*)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitWeekday;
    NSDateComponents* comps = [calendar components:unitFlags fromDate:date];
    return [comps weekday];
}



- (NSDate *)nextDateWithDay:(NSInteger)day {
    
    NSDate * date = [self dateByAddingTimeInterval:day *24*60*60];
    
    return date;
}



- (NSInteger)day {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)month {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)year {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitYear fromDate:self];
    return [components year];
}


- (NSString*)acquireDateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    return strDate;
}



- (BOOL)isInStartDate:(NSDate*)startDate endDate:(NSDate*)endDate {
    
    
    NSTimeInterval  T1 = [self timeIntervalSinceDate:startDate];
    NSTimeInterval  T2 = [self timeIntervalSinceDate:endDate];
    

    if(T1>=0 && T2 <=0){
        
        return YES;
    }
    
    return NO;

}



+ (NSDate*)acquireDateWithStr:(NSString*)str  {
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:str];
    
    return date;
}





@end
