//
//  SIDADView.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIDADView : UIView

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,copy )ActionBlock goBlock;

+ (SIDADView*)showInWindow ;

@end
