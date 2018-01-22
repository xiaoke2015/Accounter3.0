//
//  BillModel.h
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BTypeModel : NSObject

@property (nonatomic ,strong)NSString *type;

@property (nonatomic ,assign)CGFloat totalPrice;

@property (nonatomic ,strong)UIColor *color;

@end


@interface BillDayModel : NSObject

@property (nonatomic ,strong)NSString *day;

@property (nonatomic ,strong)NSMutableArray *billArray;

@property (nonatomic ,assign)CGFloat totalPrice;


- (instancetype)initWithDay:(NSString*)day ;

@end



@interface BillModel : NSObject

@property (nonatomic ,strong)NSString *Id;

@property (nonatomic ,strong)NSString *date;
@property (nonatomic ,strong)NSString *day;
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *price;
@property (nonatomic ,strong)NSString *pay;

@end
