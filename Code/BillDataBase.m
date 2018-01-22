//
//  BillDataBase.m
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BillDataBase.h"

#import <FMDatabase.h>


@interface BillDataBase ()

@property (nonatomic)FMDatabase *dataBase;

@end

@implementation BillDataBase




- (void)openDataBase {
    
    //1.获得数据库文件的路径
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"billDataBase.sqlite"];
    
    //2.获得数据库
    FMDatabase *db = [FMDatabase databaseWithPath:fileName];
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。
    if ([db open])
    {
        
        NSString *sql = @"CREATE TABLE IF NOT EXISTS t_bill (id integer PRIMARY KEY AUTOINCREMENT, date VARCHAR(20) NOT NULL, day VARCHAR(20) NOT NULL , type VARCHAR(2) NOT NULL , price VARCHAR(20) NOT NULL , pay VARCHAR(2) NOT NULL );";
        //4.创表
        BOOL result = [db executeUpdate:sql];
        if (result)
        {
            NSLog(@"创建表成功");
        }
        else {
            NSLog(@"fails");
        }
    }
    
    self.dataBase = db;
}


- (void)insertTableWithBill:(NSString*)billType
                      price:(NSString*)billPrice
                        pay:(NSString*)billPay
                        day:(NSString*)day
{
    
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    NSDate *date = [NSDate date];
    
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateStr = [dateFormatter2 stringFromDate:date];
    NSString *dayStr = day;
    NSString *type = billType;
    NSString *price = billPrice;
    NSString *pay = billPay;
    
//    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_bill (date, day ,type, price ,pay) VALUES (%@,%@,%@,%@,%@);",dateStr,dayStr,type,price,pay];
    
    //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
    BOOL result = [db executeUpdate:@"INSERT INTO t_bill (date, day ,type, price ,pay) VALUES (?,?,?,?,?);",dateStr,dayStr,type,price,pay];
    
    if (result)
    {
        NSLog(@"插入成功");
    }
    else {
        NSLog(@"fails");
    }
    
    [self closeDataBase];
}


- (void)delWithBillId:(NSString*)Id {
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    BOOL result = [db executeUpdate:@"DELETE FROM t_bill WHERE id = ?;",Id];
    
    if (result)
    {
        NSLog(@"插入成功");
    }
    else {
        NSLog(@"fails");
    }
    
    [self closeDataBase];
    
}





- (void)queryMouth:(NSString*)mouth Data:(MDArrayResultBlock)resultBlock  price:(TotalPrice)totalBlock {
    
//    NSString *mouth = @"2017年10月%";
    
    mouth = [mouth stringByAppendingString:@"%"];
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    //查询整个表
    FMResultSet *resultSet = [db executeQuery:@"select * from t_bill WHERE day LIKE ? order by day DESC ;",mouth];
    
    //遍历结果集合
    
    NSString * selDay ;
    
    BillDayModel * billDay ;
    
    CGFloat paynum = 0; //支出
    CGFloat income = 0; //收入
    
    NSMutableArray * dataSource = [NSMutableArray array];
    
    while ([resultSet  next])
        
    {
        
        BillModel *model = [[BillModel alloc]init];
        model.Id = [NSString stringWithFormat:@"%@",@([resultSet intForColumn:@"id"])];
        model.day = [resultSet objectForColumn:@"day"];
        model.date = [resultSet objectForColumn:@"date"];
        model.type = [resultSet objectForColumn:@"type"];
        model.pay = [resultSet objectForColumn:@"pay"];
        model.price = [resultSet objectForColumn:@"price"];
        
        NSLog(@"id = %@ , day = %@ , price = %@",model.Id,model.day,model.price);
        
        if([selDay isEqualToString: model.day]){
            
            [billDay.billArray addObject:model];
        }
        else {
            
            selDay = model.day;
            
            billDay = [[BillDayModel alloc]initWithDay:selDay];
            
            [billDay.billArray addObject:model];
            
            [dataSource addObject:billDay];
        }
        
        
        NSInteger pay = [model.pay integerValue];
        
        if(pay == 1){
            paynum = paynum + [model.price floatValue];
        }
        else if (pay == 2){
            income = income + [model.price floatValue];
        }
        
        
    }
    
    NSLog(@"dataSource = %@",dataSource);
    NSLog(@"paynum = %@",@(paynum));
    NSLog(@"income = %@",@(income));
    
    [self closeDataBase];
    
    resultBlock(dataSource,nil);
    
    totalBlock(paynum,income);
}



- (void)closeDataBase {
    
    
    [self.dataBase close];
}




- (void)queryMouth:(NSString*)mouth
           payType:(NSString*)pay
              Data:(MDArrayResultBlock)resultBlock
             price:(TotalPrice)totalBlock {
    
    //    NSString *mouth = @"2017年10月%";
    
    mouth = [mouth stringByAppendingString:@"%"];
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    //查询整个表
    FMResultSet *resultSet = [db executeQuery:@"select * from t_bill WHERE day LIKE ? AND pay = ? order by type DESC ;",mouth, pay];
    
    //遍历结果集合
    
    NSString * selType ;
    
    BTypeModel * billType ;
    
    CGFloat total = 0;
    
    NSMutableArray * dataSource = [NSMutableArray array];
    
    while ([resultSet  next])
        
    {
        
        BillModel *model = [[BillModel alloc]init];
        model.Id = [NSString stringWithFormat:@"%@",@([resultSet intForColumn:@"id"])];
        model.day = [resultSet objectForColumn:@"day"];
        model.date = [resultSet objectForColumn:@"date"];
        model.type = [resultSet objectForColumn:@"type"];
        model.pay = [resultSet objectForColumn:@"pay"];
        model.price = [resultSet objectForColumn:@"price"];
        
        NSLog(@"id = %@ , day = %@ , price = %@",model.Id,model.day,model.price);
        
        if([selType isEqualToString: model.type]){
            
//            [billDay.billArray addObject:model];
            billType.totalPrice = billType.totalPrice + [model.price floatValue];
        }
        else {
            
            selType = model.type;
            
            billType = [[BTypeModel alloc]init];
            
            billType.type = model.type;
        
            NSInteger tag = [model.type integerValue] - 1;
            
            billType.color = [self colorWithType:tag];
            
            billType.totalPrice = billType.totalPrice + [model.price floatValue];
            
            [dataSource addObject:billType];
        }
        
        
        total = total + [model.price floatValue];
        
    }
    
    NSLog(@"dataSource = %@",dataSource);

    
    [self closeDataBase];
    
    resultBlock(dataSource,nil);
    
    totalBlock(total,total);
    
}






- (UIColor*)colorWithType:(NSInteger)type {
    
    if(type == 0){
        return RGB(246, 222, 163);
    }
    else if(type == 1){
        return RGB(149, 214, 233);
    }
    else if(type == 2){
        return RGB(253, 183, 211);
    }
    else if(type == 3){
        return RGB(37, 178, 206);
    }
    else if(type == 4){
        return RGB(176, 130, 106);
    }
    else if(type == 5){
        return RGB(155, 226, 194);
    }
    else if(type == 6){
        return RGB(50, 202, 188);
    }
    else if(type == 7){
        return RGB(251, 134, 90);
    }
    else if(type == 8){
        return RGB(165, 224, 219);
    }
    else if(type == 9){
        return RGB(139, 191, 101);
    }
    else if(type == 10){
        return RGB(163, 158, 178);
    }
    else if(type == 11){
        return RGB(194, 222, 168);
    }
    else if(type == 12){
        return RGB(246, 172, 145);
    }
    else if(type == 13){
        return RGB(128, 225, 237);
    }
    else if(type == 14){
        return RGB(75, 145, 194);
    }
    else if(type == 15){
        return RGB(252, 205, 102);
    }
    else if(type == 16){
        return RGB(176, 224, 230);
    }
    else if(type == 17){
        return RGB(255, 215, 0);
    }
    else if(type == 19){
        return RGB(237, 145, 33);
    }
    else if(type == 20){
        return RGB(64, 224, 208);
    }
   
    else {
        return RGB(0, 0, 0);
    }
    
}




- (void)queryLineMouth:(NSString*)mouth
           payType:(NSString*)pay
              Data:(MDArrayResultBlock)resultBlock
             price:(TotalPrice)totalBlock {
    
    //    NSString *mouth = @"2017年10月%";
    
    mouth = [mouth stringByAppendingString:@"%"];
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    //查询整个表
    FMResultSet *resultSet = [db executeQuery:@"select * from t_bill WHERE day LIKE ? AND pay = ? order by day ASC ;",mouth, pay];
    
    //遍历结果集合
    
    NSString * selDay ;
    
    BillDayModel * billDay ;
    
    CGFloat total = 0;
    
    NSMutableArray * dataSource = [NSMutableArray array];
    
    while ([resultSet  next])
        
    {
        
        BillModel *model = [[BillModel alloc]init];
        model.Id = [NSString stringWithFormat:@"%@",@([resultSet intForColumn:@"id"])];
        model.day = [resultSet objectForColumn:@"day"];
        model.date = [resultSet objectForColumn:@"date"];
        model.type = [resultSet objectForColumn:@"type"];
        model.pay = [resultSet objectForColumn:@"pay"];
        model.price = [resultSet objectForColumn:@"price"];
        
        NSLog(@"id = %@ , day = %@ , price = %@",model.Id,model.day,model.price);
        
        if([selDay isEqualToString: model.day]){
            
            [billDay.billArray addObject:model];
            
            billDay.totalPrice = billDay.totalPrice + [model.price floatValue];
        }
        else {
            
            selDay = model.day;
            
            billDay = [[BillDayModel alloc]initWithDay:selDay];
            
            [billDay.billArray addObject:model];
            
            [dataSource addObject:billDay];
            
            billDay.totalPrice = billDay.totalPrice + [model.price floatValue];
        }

        
    }
    
    NSLog(@"dataSource = %@",dataSource);
    
    
    [self closeDataBase];
    
    resultBlock(dataSource,nil);
    
    totalBlock(total,total);
    
}



- (void)queryLine2Mouth:(NSString*)mouth
               payType:(NSString*)pay
                  Data:(MDArrayResultBlock)resultBlock
                  {
    
    NSMutableArray * dataSource = [self getMouthDays:mouth];
    
    mouth = [mouth stringByAppendingString:@"%"];
    
    [self openDataBase];
    
    FMDatabase *db = self.dataBase;
    
    //查询整个表
    FMResultSet *resultSet = [db executeQuery:@"select * from t_bill WHERE day LIKE ? AND pay = ? order by type ASC ;",mouth, pay];
    
    //遍历结果集合
    

    
    
    while ([resultSet  next])
        
    {
        
        BillModel *model = [[BillModel alloc]init];
        model.Id = [NSString stringWithFormat:@"%@",@([resultSet intForColumn:@"id"])];
        model.day = [resultSet objectForColumn:@"day"];
        model.date = [resultSet objectForColumn:@"date"];
        model.type = [resultSet objectForColumn:@"type"];
        model.pay = [resultSet objectForColumn:@"pay"];
        model.price = [resultSet objectForColumn:@"price"];
        
        NSLog(@"id = %@ , day = %@ , price = %@",model.Id,model.day,model.price);
        
        for(int i=0;i<dataSource.count;i++){
            
            BillDayModel *model2 = dataSource[i];
            
            
            if([model2.day isEqualToString:model.day] == YES){
                
                model2.totalPrice = model2.totalPrice + [model.price floatValue];
            }
            
        }
        
        
    }
    
    NSLog(@"dataSource = %@",dataSource);
    
    
    [self closeDataBase];
    
    resultBlock(dataSource,nil);
    
    
}




- (NSMutableArray*)getMouthDays:(NSString*)currentDay {
    
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy年MM月"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSDate *today = [dateFormatter2 dateFromString:currentDay];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *firstDay;
    
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:today];

    
    NSRange range = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDay];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(int i=0;i<range.length;i++){
        
        NSDate *date = [firstDay nextDateWithDay:i+1];
        
        NSString *day = [dateFormatter stringFromDate:date];
        
        BillDayModel *model = [[BillDayModel alloc]initWithDay:day];
        
        [array addObject:model];
    }

    
    return array;

}








@end
