//
//  BillTypeModel.h
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillTypeModel : NSObject

@property (nonatomic ,strong)NSArray *imgArray;
@property (nonatomic ,strong)NSArray *imgSelArray;
@property (nonatomic ,strong)NSArray *titleArray;

@property (nonatomic ,strong)NSArray *img2Array;
@property (nonatomic ,strong)NSArray *img2SelArray;
@property (nonatomic ,strong)NSArray *title2Array;


+ (BillTypeModel *)shareInstance  ;

@end
