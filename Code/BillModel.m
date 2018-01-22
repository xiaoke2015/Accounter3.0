//
//  BillModel.m
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BillModel.h"



@implementation BTypeModel



@end


@implementation BillDayModel


- (instancetype)initWithDay:(NSString*)day {
    
    self = [super init];
    
    self.day = day;
    self.billArray = [NSMutableArray array];
    self.totalPrice = 0;
    
    return self;
}


@end



@implementation BillModel





@end
