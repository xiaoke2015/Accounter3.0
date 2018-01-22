//
//  BaseViewController.h
//  MBDemo
//
//  Created by yuyue on 2017/4/26.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic ,strong)UILabel *naviLine;


- (void)initTitle:(NSString*)title ;

- (void)initNaviBarBtn:(NSString*)title ;

- (void)initPresentBarBtn:(NSString*)title ;

// navi 左侧视图 常用UIButton
- (void)setLeftBarWithCustomView:(UIView *)customView ;
// navi 标题视图
- (void)setTitleViewWithCustomView:(UIView *)customView ;
// navi 右侧视图 常用UIButton
- (void)setRightBarWithCustomView:(UIView *)customView ;


- (void)naviBtn ;

@end
