//
//  FinderModel.m
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "FinderModel.h"

@implementation FinderModel


- (instancetype)initWithObject:(AVObject *)object {
    
    self = [super init];
    
    self.objectId = [object objectForKey:@"objectId"];
    self.mark = [object objectForKey:@"mark"];
    self.title = [object objectForKey:@"title"];
//    self.style = [object objectForKey:@"style"];
    self.detail = [object objectForKey:@"detail"];
    
    self.bid = [object objectForKey:@"bid"];
    self.url = [object objectForKey:@"url"];

    
    AVFile *file = [object objectForKey:@"image"];
    
    if(file.url != nil){
        
        self.image = file.url;
    }
    else {
        self.image = @"";
    }
    
    
    return self;
}



-  (void)detailWithObject:(AVObject *)object {
    
    
    self.detail = [object objectForKey:@"detail"];
}



+ (void)findObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"news"];
    
    //    [query orderByDescending:@"updatedAt"];
    
//    [query orderByAscending:@"num"];
    
//    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            AVObject *obj = objects[i];
            FinderModel *model = [[FinderModel alloc]initWithObject:obj];
            [models addObject:model];
        }
        
        resultBlock(models,error);
        
    }];
    
}



@end
