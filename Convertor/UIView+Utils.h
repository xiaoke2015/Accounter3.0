//
//  UIView+Utils.h
//  LanJiazai
//
//  Created by yuyue on 16-7-19.
//  Copyright (c) 2016年 incredibleRon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Utils)


@property (nonatomic,assign)CGFloat top;

@property (nonatomic,assign)CGFloat bottom;

@property (nonatomic,assign)CGFloat left;

@property (nonatomic,assign)CGFloat right;

@property (nonatomic,assign)CGFloat width;

@property (nonatomic,assign)CGFloat height;

@property (nonatomic, assign) CGSize size;

- (void)setCornerRadius:(CGFloat)cornerRadius ;


- (void)sizeThatFit ;

- (void)addEdgingWithWidth:(CGFloat)width;

@end
