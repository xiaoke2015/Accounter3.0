//
//  MyTabBar.h
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>



@class MyTabBar;
@protocol MyTabBarDelegate<NSObject>
//实现plus响应的方法
-(void)PlusBtnClick:(MyTabBar *)tabBar;
@end


@interface MyTabBar : UITabBar


@property(nonatomic,weak)id <MyTabBarDelegate> mdelegate;

@end
