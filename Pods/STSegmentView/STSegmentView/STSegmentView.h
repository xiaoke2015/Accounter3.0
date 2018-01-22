//
//  STSegmentView.h
//  STSegmentView
//
//  Created by styf on 2017/6/15.
//  Copyright © 2017年 styf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STSegmentViewDelegate <NSObject>

- (void)buttonClick:(NSInteger)index;

@end

@interface STSegmentView : UIView
/*!@brief 选中的背景色视图*/
@property (nonatomic,strong) UIView *selectedBgView;

/*!@brief 外部的滚动视图*/
@property(nonatomic,weak) UIScrollView *outScrollView;
/*!@brief 代理*/
@property(nonatomic,weak) id<STSegmentViewDelegate> delegate;
/*!@brief 标题数组*/
@property (nonatomic,strong) NSArray *titleArray;
/*!@brief 滑块颜色*/
@property (nonatomic,strong) UIColor *sliderColor;
/*!@brief 底部Label文字颜色*/
@property (nonatomic,strong) UIColor *bottomLabelTextColor;
/*!@brief 顶部Label文字颜色*/
@property (nonatomic,strong) UIColor *topLabelTextColor;
/*!@brief 选中标题背景色*/
@property (nonatomic,strong) UIColor *selectedBackgroundColor;
/*!@brief 选中背景色视图的圆角*/
@property (nonatomic,assign) CGFloat selectedBgViewCornerRadius;
/*!@brief 标题字体*/
@property (nonatomic,strong) UIFont *labelFont;
/*!@brief 标题间距*/
@property (nonatomic,assign) CGFloat titleSpacing;
/*!@brief 滑块顶部外边距*/
@property (nonatomic,assign) CGFloat sliderTopMargin;
/*!@brief 滑块高度*/
@property (nonatomic,assign) CGFloat sliderHeight;
/*!@brief 动画时间*/
@property (nonatomic,assign) NSTimeInterval duration;


/**
 设置按钮选中

 @param index 下标
 */
- (void)setButtonSelected:(NSInteger)index;


@end
