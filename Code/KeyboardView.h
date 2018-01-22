//
//  KeyboardView.h
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardView : UIView

@property (nonatomic ,copy)void (^doneBlock)(NSString *price);

@property (nonatomic ,copy)ActionBlock selDate;



- (void)show ;

@end
