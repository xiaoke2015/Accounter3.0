
//
//  MLTextView.m
//  AppONE
//
//  Created by yuyue on 16-6-17.
//  Copyright (c) 2016年 incredibleRon. All rights reserved.
//

#import "MLTextView.h"


@implementation MLTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    _maxCount = 150;
    
    [self loadView];
    
    return self;
}



- (void)loadView {
    
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    _textView.delegate = self;
    [self addSubview:_textView];
    
    _placeholder = [[UILabel alloc]initWithFrame:CGRectMake(5, 6, CGRectGetWidth(self.frame), 20)];
    
    [self addSubview:_placeholder];
    _placeholder.userInteractionEnabled = NO;
    _placeholder.numberOfLines = 0;
    _placeholder.textColor = RGB(200, 200, 200);
    
    _placeholder.font = [UIFont systemFontOfSize:15];
    _textView.font = [UIFont systemFontOfSize:15];
    
   
    
}



- (void)textViewDidChange:(UITextView *)textView {
    
    if(textView.text.length <=0){
        
        _placeholder.hidden = NO;
    }
    else {
        
        if(textView.text.length > _maxCount){
            
            textView.text = [textView.text substringWithRange:NSMakeRange(0, _maxCount)];
        }
        
        _placeholder.hidden = YES;
    }
}



@end
