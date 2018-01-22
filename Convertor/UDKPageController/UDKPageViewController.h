//
//  UDKPageViewController.h
//  BDKAccountTool
//
//  Created by 李加建 on 2017/12/20.
//  Copyright © 2017年 BDK. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^NormalBlock)(void);

@interface UDKPageViewController : UIViewController

@property (nonatomic ,copy) NormalBlock successBlock;

+ (void)PostEnterForeground ;

@end
