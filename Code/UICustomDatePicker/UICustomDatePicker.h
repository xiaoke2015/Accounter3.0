//
//  UICustomDatePicker.h
//  LengBaoBao
//
//  Created by mac on 2017/6/25.
//  Copyright © 2017年 leng360. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICustomDatePicker : UIView


/**
 返回自定义的选择日期的视图

 @param superView 视图需要显示到的superview
 @param date 选择后的日期
 @param cancel 取消选择的操作
 */
+ (void) showCustomDatePickerAtView:(UIView *)superView
                   choosedDateBlock:(void (^)(NSDate *date))date
                        cancelBlock:(void(^)())cancel;

@end
