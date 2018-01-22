//
//  BillTypeModel.m
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BillTypeModel.h"

static BillTypeModel * bill = nil;

@implementation BillTypeModel



+ (BillTypeModel *)shareInstance {
    
    if(bill == nil){
        bill = [[BillTypeModel alloc]init];
    }
    
    return bill;
}


- (instancetype)init {
    
    self = [super init];
    
    
    self.titleArray = @[@"购物",@"餐饮",@"果蔬",@"交通",@"医疗",
                        @"服装",@"住房",@"红包",@"化妆品",@"娱乐",
                        @"水电燃气",@"母婴",@"旅游",@"健身",@"学习",
                        @"礼物",@"宠物",@"数码",@"家具",@"维修",
                        @"其他"];
    
    self.imgArray = @[@"001",@"002",@"003",@"003",@"005",
                      @"006",@"007",@"008",@"009",@"010",
                      @"011",@"012",@"013",@"014",@"015",
                      @"016",@"017",@"018",@"019",@"020",
                      @"021"];
    
    self.imgSelArray = @[@"101",@"102",@"103",@"103",@"105",
                         @"106",@"107",@"108",@"109",@"110",
                         @"111",@"112",@"113",@"114",@"115",
                         @"116",@"117",@"118",@"119",@"120",
                         @"121"];
    
    
    self.title2Array = @[@"工资",@"礼金",@"理财",@"其他"];
    
    self.img2Array = @[@"401",@"402",@"403",@"021"];
    
    self.img2SelArray = @[@"301",@"302",@"303",@"121"];
    
    return self;
}


@end
