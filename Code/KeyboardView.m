//
//  KeyboardView.m
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KeyboardView.h"


#define HEIGHT 50

@interface KeyboardView ()

@property (nonatomic ,strong)NSMutableArray *btnsArray;

@property (nonatomic ,strong)UILabel * label;

@property (nonatomic ,strong)NSString *num;

@end


@implementation KeyboardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/








- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.num = @"";
    [self creatView];
    
    [self addLine];
    
    return self;
}



- (void)addNum:(NSString*)num {
    
    NSString * words = self.num;
    
    if([num isEqualToString:@"."] == YES){
        
        if ([words rangeOfString:@"."].location == NSNotFound) {
            NSLog(@"string 不存在 martin");
            words = [words stringByAppendingString:num];
        } else {
            NSLog(@"string 包含 martin");
        }
        
    }
    else {
        
        if([words isEqualToString:@"0"]){
            
            if([num isEqualToString:@"0"]){
                
            }
            else {
                words = num;
            }
        }
        else {
            
            words = [words stringByAppendingString:num];
        }
        
    }
    
    self.num = words;
}


- (void)delNum {
 
    
    if(self.num.length > 1){
        
        self.num = [self.num substringToIndex:[self.num length] - 1];
    }
    else {
        self.num = @"0";
    }
    
}



- (void)show {
    
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.frame = CGRectMake(0, SCREEM_HEIGHT - self.height - 64, self.width, self.height);
    }];
    
}


- (void)addLine {
    
    CGFloat y = HEIGHT;
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = CGRectMake(0, 0, self.width, 0.5);
    layer1.backgroundColor = RGB(200, 200, 200).CGColor;
    [self.layer addSublayer:layer1];
    
    
    CALayer *layer2 = [CALayer layer];
    layer2.frame = CGRectMake(0,y, self.width, 0.5);
    layer2.backgroundColor = RGB(200, 200, 200).CGColor;
    [self.layer addSublayer:layer2];
    
    
    CALayer *layer3 = [CALayer layer];
    layer3.frame = CGRectMake(0,y*2, self.width, 0.5);
    layer3.backgroundColor = RGB(200, 200, 200).CGColor;
    [self.layer addSublayer:layer3];
    
    
    CALayer *layer4 = [CALayer layer];
    layer4.frame = CGRectMake(0, y*3, self.width, 0.5);
    layer4.backgroundColor = RGB(200, 200, 200).CGColor;
    [self.layer addSublayer:layer4];
    
    CALayer *layer8 = [CALayer layer];
    layer8.frame = CGRectMake(0, y*4, self.width, 0.5);
    layer8.backgroundColor = RGB(200, 200, 200).CGColor;
    [self.layer addSublayer:layer8];
    
    
    CGFloat w = self.width/4;
    
    CALayer *layer5 = [CALayer layer];
    layer5.frame = CGRectMake(w, y, 0.5, self.height - y);
    layer5.backgroundColor = RGB(200, 200, 200).CGColor;
    [self.layer addSublayer:layer5];
    
    CALayer *layer6 = [CALayer layer];
    layer6.frame = CGRectMake(w*2, y, 0.5, self.height - y);
    layer6.backgroundColor = RGB(200, 200, 200).CGColor;
    [self.layer addSublayer:layer6];
    
    CALayer *layer7 = [CALayer layer];
    layer7.frame = CGRectMake(w*3, y, 0.5, self.height - y);
    layer7.backgroundColor = RGB(200, 200, 200).CGColor;
    [self.layer addSublayer:layer7];
    

    
    
}


- (void)creatView {
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEM_WIDTH - 30, 50)];
    _label.textColor = MAINCOLOR;
    _label.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:25];
    _label.textAlignment = NSTextAlignmentRight;
    [self addSubview:_label];
    
    _label.text = @"￥0";
    
    NSArray *array = @[@"1",@"2",@"3",@"",
                       @"4",@"5",@"6",@"+",
                       @"7",@"8",@"9",@"-",
                       @"",@"0",@".",@"完成"];
    
    CGFloat y = HEIGHT;
    
    CGFloat w = self.width/4;
    
    CGFloat x1 = 0;
    CGFloat y1 = 0;
    
    self.btnsArray = [NSMutableArray array];
    
    for(int i=0;i<array.count;i++){
        
        x1 = (i%4)*w;
        y1 = y + (i/4)*y;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x1, y1, w, y)];
        
        [self addSubview:btn];
        btn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:18];
        
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(25, 25, 25) forState:UIControlStateNormal];
        
        if(i == 15){
            [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
            btn.backgroundColor = MAINCOLOR;
        }
        
        if(i == 3){
            
            [btn setImage:[UIImage imageNamed:@"num_del_btn"] forState:UIControlStateNormal];
        }
        
       
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnsArray addObject:btn];
    }
    
}



- (void)btnAction:(UIButton*)btn {
    
    NSInteger tag =  [self.btnsArray indexOfObject:btn];
    
    
    if(tag == 15){
        // 完成
        
        if(_doneBlock != nil){
            _doneBlock(self.num);
        }
    }
    else if (tag == 12){
        // 无
        
        if(_selDate != nil){
            _selDate();
        }
        
    }
    else if (tag == 11){
        // 减
    }
    else if (tag == 7){
        // 加
    }
    else if (tag == 3){
     
        // 删除
        [self delNum];
        [self updateNumber];
    }
    else {
        
        NSString *num = btn.titleLabel.text;
    
        [self addNum:num];
        [self updateNumber];
    }
}



- (void)updateNumber {
    
    NSString *num = [NSString stringWithFormat:@"￥%@",self.num];
    
    self.label.text = num;
}








@end
