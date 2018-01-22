//
//  ChartTableViewCell.m
//  Convertor
//
//  Created by 李加建 on 2017/10/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ChartTableViewCell.h"

@implementation ChartTableViewCell

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
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, 60);
    
    self.textLabel.font = FONT15;
    
    self.detailTextLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:22];
    self.detailTextLabel.textColor = RGB(50, 50, 50);
    
    
    
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(15, 15, 30, 30);
    self.textLabel.frame = CGRectMake(15, 15, SCREEM_WIDTH - 100, 30);
    
    
    
}


@end
