//
//  HomeHeadView.h
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeadView : UIView

@property (nonatomic ,strong)UILabel *label1;
@property (nonatomic ,strong)UILabel *label2;

@property (nonatomic ,strong)UIButton *dateBtn;

@property (nonatomic ,copy)ActionBlock goBlock;


- (void)dataWithPayNum:(CGFloat)paynum  income:(CGFloat)income ;

@end
