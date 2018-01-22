//
//  BillCollectionViewCell.m
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BillCollectionViewCell.h"

@interface BillCollectionViewCell ()


@end

@implementation BillCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    CGFloat w = self.width/2;
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(w/2, w - 20, w, w)];
    self.imgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imgView];
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imgView.bottom +10, self.width, 20)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = RGB(50, 50, 50);
    self.label.font = FONT14;
    [self addSubview:self.label];
    

}


@end
