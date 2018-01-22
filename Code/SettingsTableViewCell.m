//
//  SettingsTableViewCell.m
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    self.imageView.frame = CGRectMake(15, 10, 24, 24);
    self.textLabel.frame = CGRectMake(54, 7, 200, 30);
}

@end
