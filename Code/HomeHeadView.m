//
//  HomeHeadView.m
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HomeHeadView.h"

@implementation HomeHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.backgroundColor = MAINCOLOR;
    
    [self addLayer];
    
    [self creatLabel];
    
    return self;
}


- (void)addLayer {
    
//    255,200,167
//    213,204,246
    
    CALayer *layer1 = [CALayer  layer];
    
    layer1.frame = CGRectMake(-30, 60, 60, 60);
    layer1.masksToBounds = YES;
    layer1.cornerRadius = 30;
    layer1.backgroundColor = RGBA(255, 200, 167, 0.5).CGColor;
    
    [self.layer addSublayer:layer1];
    
    CALayer *layer2 = [CALayer  layer];
    
    layer2.frame = CGRectMake(-20, 100, 40, 40);
    layer2.masksToBounds = YES;
    layer2.cornerRadius = 20;
    layer2.backgroundColor = RGBA(213, 204, 246, 0.5).CGColor;
    
    [self.layer addSublayer:layer2];
    
    
    CALayer *layer3 = [CALayer  layer];
    
    layer3.frame = CGRectMake(self.width - 70, -50, 150, 150);
    layer3.masksToBounds = YES;
    layer3.cornerRadius = 75;
    layer3.backgroundColor = RGBA(183, 120, 253, 0.5).CGColor;
    
    [self.layer addSublayer:layer3];
    
    CALayer *layer4 = [CALayer  layer];
    
    layer4.frame = CGRectMake(self.width - 120, self.height - 40, 120, 120);
    layer4.masksToBounds = YES;
    layer4.cornerRadius = 60;
    layer4.backgroundColor = RGBA(213, 204, 246, 0.5).CGColor;
    
    [self.layer addSublayer:layer4];
}



- (void)dateBtnAction {
    
    if(_goBlock != nil){
        _goBlock();
    }
}


- (void)creatLabel {
    
    
    _dateBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 60, 40, 120, 30)];
    
    _dateBtn.layer.masksToBounds = YES;
    _dateBtn.layer.cornerRadius = _dateBtn.height/2;
    _dateBtn.layer.borderWidth = 1;
    _dateBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self addSubview:_dateBtn];
    
    [_dateBtn addTarget:self action:@selector(dateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat h = self.height/2;
    CGFloat w = self.width/2 - 30;
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, h, w, h)];
    _label1.textColor = [UIColor whiteColor];
    _label1.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:36];
    _label1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label1];
    
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(w+40, h, w, h)];
    _label2.textColor = [UIColor whiteColor];
    _label2.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:36];
    _label2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label2];
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, h, w, 20)];
    label1.textColor = [UIColor whiteColor];
    label1.font = FONT14;
    [self addSubview:label1];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"支出（元）";
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(w+40, h, w, 20)];
    label2.textColor = [UIColor whiteColor];
    label2.font = FONT14;
    [self addSubview:label2];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"收入（元）";
    
    
    
}




- (void)dataWithPayNum:(CGFloat)paynum  income:(CGFloat)income {
    
    
    _label1.text = [NSString stringWithFormat:@"%.1f",paynum];
    _label2.text = [NSString stringWithFormat:@"%.1f",income];
}


@end
