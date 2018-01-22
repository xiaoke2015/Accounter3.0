//
//  FinderTableViewCell.m
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "FinderTableViewCell.h"

#import <UIButton+WebCache.h>

#import <UIImageView+WebCache.h>

@interface FinderTableViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;
@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *price;
@property (nonatomic ,strong)UILabel *date;

@property (nonatomic ,strong)UIImageView *imgHot;

@property (nonatomic ,strong)UIButton *btn;


@end

@implementation FinderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}





- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = NO;
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, 90);
    
    //    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 70, 70)];
    //
    //    [self.contentView addSubview:_imgView];
    //
    //    _imgView.image = [UIImage imageNamed:@"jobs"];
    //    _imgView.layer.masksToBounds = YES;
    //    _imgView.layer.cornerRadius = 8;
    //    _imgView.backgroundColor = RGB(53, 209, 169);
    //
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, 60, 60)];
    
    [btn setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    //    btn.layer.masksToBounds = YES;
    //    btn.layer.cornerRadius = 8;
    //    btn.backgroundColor = RGB(53, 209, 169);
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
    [self.contentView addSubview:btn];
    [btn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    btn.titleLabel.font = FONT12;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.userInteractionEnabled = NO;
    //    btn.hidden = NO;
    _btn = btn;
    
    
    _imgHot = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 40, 0, 30, 30)];
    _imgHot.image = [UIImage imageNamed:@"hot"];
    _imgHot.contentMode = UIViewContentModeScaleAspectFill;
    _imgHot.clipsToBounds = YES;
    [self.contentView addSubview:_imgHot];
    _imgHot.contentMode = UIViewContentModeScaleAspectFill;
    _imgHot.clipsToBounds = YES;
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, SCREEM_WIDTH - 110, 20)];
    _title.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    _title.numberOfLines = 2;
    _title.textColor = RGB(25, 25, 25);
    [self.contentView addSubview:_title];
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(100, 55, SCREEM_WIDTH - 110, 20)];
    //    _price.numberOfLines = 0;
    [self.contentView addSubview:_price];
    _price.font = FONT14;
    _price.textColor = RGB(100, 100, 100);
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(100, 55, SCREEM_WIDTH - 110, 20)];
    
    [self.contentView addSubview:_date];
    _date.font = FONT12;
    _date.textColor = RGB(150, 150, 150);
    
    
}


- (void)dataWithModel:(FinderModel*)model {
    
    _title.text = model.title;

    _date.text = model.mark;
    
    _price.text = model.detail;
    
    [_imgHot sd_setImageWithURL:[NSURL URLWithString:model.image] ];
    
//    [_btn setTitle:model.read_num forState:UIControlStateNormal];
    
    
    NSInteger style = 1 ;//[model.style integerValue];
    
    if(style == 1 ){
        
        
        CGFloat w = SCREEM_WIDTH/2 - 15;
        CGFloat h = w*(3/4.f);
        _title.numberOfLines = 2;
        _price.numberOfLines = 2;
        
        
        _imgHot.frame = CGRectMake(SCREEM_WIDTH - w - 15, 12.5, w, h);
        
        _title.frame = CGRectMake(15, 12.5, w - 15, 40);
        
        _price.frame = CGRectMake(15, 25+40, w - 15, 40);
        
        _date.frame = CGRectMake(15, _imgHot.bottom -20, w - 15, 20);
        
        _btn.frame = CGRectMake(w - 60, _imgHot.bottom -20, 60, 20);
        
        [_title sizeToFit];
        
        self.frame = CGRectMake(0, 0, 0, h+25);
        
    }
    else if (style == 2){
        
        
        CGFloat w = SCREEM_WIDTH - 30;
        CGFloat h = w*(1/3.f);
        _title.numberOfLines = 2;
        _price.numberOfLines = 2;
        
        _imgHot.frame = CGRectMake(15, 75, w, h);
        _title.frame = CGRectMake(15, 12.5, w, 30);
        
        _price.frame = CGRectMake(15, 42.5, w, 20);
        _date.frame = CGRectMake(15, _imgHot.bottom + 10, w, 20);
        
        [_title sizeToFit];
        
        self.frame = CGRectMake(0, 0, 0, _date.bottom + 12.5);
        
        _btn.frame = CGRectMake(SCREEM_WIDTH - 75, _imgHot.bottom +10, 60, 20);
    }
    else if (style == 3){
        
    }
    
    
    
    
}




@end
