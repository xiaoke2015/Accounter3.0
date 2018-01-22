//
//  BillDataBase.h
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BillModel.h"

#import "BillTypeModel.h"

#import "NSDate+STCalendar.h"


typedef void(^TotalPrice)(CGFloat paynum ,CGFloat income);

@interface BillDataBase : NSObject


- (void)insertTableWithBill:(NSString*)billType
                      price:(NSString*)billPrice
                        pay:(NSString*)billPay
                        day:(NSString*)day;


- (void)queryMouth:(NSString*)mouth Data:(MDArrayResultBlock)resultBlock price:(TotalPrice)totalBlock;


- (void)delWithBillId:(NSString*)Id ;



- (void)queryMouth:(NSString*)mouth
           payType:(NSString*)pay
              Data:(MDArrayResultBlock)resultBlock
             price:(TotalPrice)totalBlock ;


- (void)queryLineMouth:(NSString*)mouth
               payType:(NSString*)pay
                  Data:(MDArrayResultBlock)resultBlock
                 price:(TotalPrice)totalBlock ;



- (void)queryLine2Mouth:(NSString*)mouth
                payType:(NSString*)pay
                   Data:(MDArrayResultBlock)resultBlock ;

@end
