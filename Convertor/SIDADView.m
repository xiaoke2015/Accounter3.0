//
//  SIDADView.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SIDADView.h"

@implementation SIDADView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (SIDADView*)showInWindow {
    
    SIDADView * adView = [[SIDADView alloc]initWithFrame:SCREEM ];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:adView];
    
    return adView;
}




- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}


- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    
    [self addSubview:bgView];
    
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200*(4/3.f))];

    _imgView.center = self.center;
    
    [self addSubview:_imgView];
    
    
    _imgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_imgView addGestureRecognizer:tap];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(_imgView.right - 50, _imgView.top, 50, 44)];
    
    [btn setImage:[UIImage imageNamed:@"cha_btn"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}


- (void)btnAction {
    
    [self removeFromSuperview];
}


- (void)tapAction {
    
    if(_goBlock != nil){
        _goBlock();
    }
}


@end
