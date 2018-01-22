//
//  DetailHeadView.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DetailHeadView.h"


@interface DetailHeadView ()

@property (nonatomic ,strong)UILabel *title;

@property (nonatomic ,strong)UILabel *price;

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *detail;

@property (nonatomic ,strong)UIView * commentBar ;


@end

@implementation DetailHeadView

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
    
 
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEM_WIDTH - 30, 20)];
    _title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _title.textAlignment = NSTextAlignmentCenter;
    _title.numberOfLines = 0;
    _title.textColor = RGB(0, 0, 0);
    [self addSubview:_title];
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, _title.bottom, SCREEM_WIDTH - 30, (SCREEM_WIDTH - 40)*(2/3.f))];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    [self addSubview:_imgView];
    
    _detail = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom, SCREEM_WIDTH - 30, 20)];
    _detail.numberOfLines = 0;
    _detail.font = FONT14;
    _detail.textColor = RGB(100, 100, 100);
    
    [self addSubview:_detail];
    
    
    _commentBar = [[UIView alloc]initWithFrame:CGRectMake(0, _detail.bottom + 10, SCREEM_WIDTH, 40)];
    
    [self addSubview:_commentBar];
    
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 40)];
//    label.text = @"最新评论";
//    label.textColor = RGB(50, 50, 50);
//    label.font = FONT14;
//    [_commentBar addSubview:label];
//    
//    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 85, 0, 70, 40)];
//    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    [btn setTitle:@"评论" forState:UIControlStateNormal];
//    btn.titleLabel.font = FONT15;
//    [_commentBar addSubview:btn];
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    
//    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEM_WIDTH, 0.5)];
//    line.backgroundColor = RGB(200, 200, 200);
//    [_commentBar addSubview:line];
//    
//    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnAction {
    
    if(_commentBlock != nil){
        _commentBlock();
    }
}


- (void)dataWithModel:(FinderModel*)model {
    
    
    _title.text = model.title;
    [_title sizeToFit];
    _title.frame = CGRectMake(15, 20, SCREEM_WIDTH - 30, _title.height);
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    _imgView.frame = CGRectMake(15, _title.bottom +10, SCREEM_WIDTH - 30, _imgView.height);
    
    _detail.frame = CGRectMake(15, _imgView.bottom +10, SCREEM_WIDTH - 30, 20);
    _detail.text = model.detail;
    [_detail sizeToFit];
    
    
    _commentBar.frame = CGRectMake(0, _detail.bottom +10, SCREEM_WIDTH, 40);
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _detail.bottom + 60);
    
}


@end
