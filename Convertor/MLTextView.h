//
//  MLTextView.h
//  AppONE
//
//  Created by yuyue on 16-6-17.
//  Copyright (c) 2016年 incredibleRon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLTextView : UIView <UITextViewDelegate>


/*
 *textView 文本输入框

 */

@property (nonatomic,strong)UITextView *textView;

/*
 *placeholder
 
 */
@property (nonatomic,strong)UILabel *placeholder;


@property (nonatomic,assign)NSInteger maxCount;


- (void)textViewDidChange:(UITextView *)textView ;

@end
