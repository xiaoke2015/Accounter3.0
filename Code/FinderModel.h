//
//  FinderModel.h
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FinderModel : NSObject

@property (nonatomic ,strong)NSString *objectId;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *mark;
@property (nonatomic ,strong)NSString *image;
@property (nonatomic ,strong)NSString *detail;
@property (nonatomic ,strong)NSString *bid;
@property (nonatomic ,strong)NSString *url;



- (instancetype)initWithObject:(AVObject *)object ;


+ (void)findObjects:(MDArrayResultBlock)resultBlock ;

@end
