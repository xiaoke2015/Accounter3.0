//
//  STSegmentView.m
//  STSegmentView
//
//  Created by styf on 2017/6/15.
//  Copyright © 2017年 styf. All rights reserved.
//

#import "STSegmentView.h"


#define defaultFontSize 17
#define defaultDuration 0.5

@interface STSegmentView ()
/*!@brief 选中的视图*/
@property (nonatomic,strong) UIView *selectedView;

/*!@brief 顶部内容视图*/
@property (nonatomic,strong) UIView *topContentView;
/*!@brief 滑块*/
@property (nonatomic,strong) UIView *slider;

/*!@brief 标题宽度*/
@property (nonatomic,assign) CGFloat titleLabelW;

/*!@brief 底部Label数组*/
@property (nonatomic,strong) NSMutableArray *bottomLabelArray;
/*!@brief 顶部Label数组*/
@property (nonatomic,strong) NSMutableArray *topLabelArray;
/*!@brief 按钮数组*/
@property (nonatomic,strong) NSMutableArray *buttonArray;
@end
@implementation STSegmentView

/**
 设置标题

 @param titleArray 标题数组
 */
- (void)setTitleArray:(NSArray *)titleArray {
    
    if (_titleArray.count == titleArray.count) {
        //只替换标题文字
        for (int i = 0; i < titleArray.count; i ++) {
            UILabel *bottomLabel = self.bottomLabelArray[i];
            UILabel *topLabel = self.topLabelArray[i];
            bottomLabel.text = titleArray[i];
            topLabel.text = titleArray[i];
        }
        _titleArray = titleArray;
    }else{
        _titleArray = titleArray;
        [self removeAllSubViews];
        if (titleArray.count) {
            
            self.titleLabelW = (self.bounds.size.width - _titleSpacing * (titleArray.count - 1))/titleArray.count;
        }
    }
}



/**
 移除所有字视图
 */
- (void)removeAllSubViews {
    for (UIView *view in self.bottomLabelArray) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.topLabelArray) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.buttonArray) {
        [view removeFromSuperview];
    }
    [self.bottomLabelArray removeAllObjects];
    [self.topLabelArray removeAllObjects];
    [self.buttonArray removeAllObjects];
}


/**
 设置标题间距

 @param titleSpacing 间距
 */
- (void)setTitleSpacing:(CGFloat)titleSpacing {
    _titleSpacing = titleSpacing;
    if (_titleArray.count) {
        self.titleLabelW = (self.bounds.size.width - _titleSpacing * (_titleArray.count - 1))/_titleArray.count;
    }
}


/**
 设置标题宽度

 @param titleLabelW 标题宽度
 */
- (void)setTitleLabelW:(CGFloat)titleLabelW {
    _titleLabelW = titleLabelW;
    
    if (!self.bottomLabelArray.count) {
        for (int i = 0; i < self.titleArray.count; i++) {
            NSString *title = self.titleArray[i];
            UILabel *bottomLabel = [[UILabel alloc]init];
            bottomLabel.text = title;
            bottomLabel.font = _labelFont?_labelFont:[UIFont systemFontOfSize:defaultFontSize];
            bottomLabel.textColor = _bottomLabelTextColor?_bottomLabelTextColor:[UIColor blackColor];
            bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self.bottomLabelArray addObject:bottomLabel];
            [self addSubview:bottomLabel];
            
            UILabel *topLabel = [[UILabel alloc]init];
            topLabel.text = title;
            topLabel.font = _labelFont?_labelFont:[UIFont systemFontOfSize:defaultFontSize];
            topLabel.textColor = _topLabelTextColor?_topLabelTextColor:[UIColor whiteColor];
            topLabel.textAlignment = NSTextAlignmentCenter;
            [self.topLabelArray addObject:topLabel];
            [self.topContentView addSubview:topLabel];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArray addObject:button];
        }
        
    }
    
    [self setupViewFrame:self.bottomLabelArray];
    [self setupViewFrame:self.topLabelArray];
    [self setupViewFrame:self.buttonArray];
    
    UILabel *firstLabel = self.bottomLabelArray[0];
    
    self.selectedView.frame = firstLabel.bounds;
    [self addSubview:self.selectedView];
    
    self.selectedBgView.frame = self.selectedView.bounds;
    [self.selectedView addSubview:self.selectedBgView];
    
    self.topContentView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - _sliderTopMargin - _sliderHeight);
    [self.selectedView addSubview:self.topContentView];
    
    for (UIButton *button in self.buttonArray) {
        [self addSubview:button];
    }
    
    if (_slider) {
        _slider.frame = CGRectMake(0, _slider.frame.origin.y, _titleLabelW, _sliderHeight);
    }
}





/**
 设置数组内视图的frame
 
 @param array 视图数组
 */
- (void)setupViewFrame:(NSMutableArray *)array {
    for (int i = 0; i < array.count; i++) {
        UIView *view = array[i];
        view.frame = CGRectMake(i * _titleSpacing + i * _titleLabelW, 0, _titleLabelW, self.bounds.size.height - _sliderTopMargin -_sliderHeight);
    }
}


/**
 设置底部Label文字颜色

 @param bottomLabelTextColor 底部Label文字颜色
 */
- (void)setBottomLabelTextColor:(UIColor *)bottomLabelTextColor {
    _bottomLabelTextColor = bottomLabelTextColor;
    if (self.bottomLabelArray.count&&bottomLabelTextColor) {
        for (UILabel *label in self.bottomLabelArray) {
            label.textColor = bottomLabelTextColor;
        }
    }
}


/**
 设置顶部Label文字颜色

 @param topLabelTextColor 顶部Label文字颜色
 */
- (void)setTopLabelTextColor:(UIColor *)topLabelTextColor {
    _topLabelTextColor = topLabelTextColor;
    if (self.topLabelArray.count&&topLabelTextColor) {
        for (UILabel *label in self.topLabelArray) {
            label.textColor = topLabelTextColor;
        }
    }
}


/**
 设置标题字体

 @param labelFont 标题字体
 */
- (void)setLabelFont:(UIFont *)labelFont {
    _labelFont = labelFont;
    if (labelFont) {
        if (self.bottomLabelArray.count) {
            for (UILabel *label in self.bottomLabelArray) {
                label.font = labelFont;
            }
        }
        if (self.topLabelArray.count) {
            for (UILabel *label in self.topLabelArray) {
                label.font = labelFont;
            }
        }
    }
}


/**
 设置滑块高度

 @param sliderHeight 滑块高度
 */
- (void)setSliderHeight:(CGFloat)sliderHeight {
    _sliderHeight = sliderHeight;
    self.slider.frame = CGRectMake(0, self.bounds.size.height - sliderHeight, _titleLabelW, sliderHeight);
    [self addSubview:self.slider];
    
    if (_titleLabelW) {
        //重新计算布局
        self.titleLabelW = _titleLabelW;
    }
    
    if (_sliderColor) {
        self.slider.backgroundColor = _sliderColor;
    }
    
}





/**
 设置滑块顶部外边距

 @param sliderTopMargin 滑块顶部外边距
 */
- (void)setSliderTopMargin:(CGFloat)sliderTopMargin {
    _sliderTopMargin = sliderTopMargin;
    if (_titleLabelW) {
        //重新计算布局
        self.titleLabelW = _titleLabelW;
    }
}


/**
 设置滑块颜色

 @param sliderColor 滑块颜色
 */
- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    if (_slider) {
        _slider.backgroundColor = sliderColor;
    }
}


/**
 设置选中标题背景色

 @param selectedBackgroundColor 选中标题背景色
 */
- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
    _selectedBackgroundColor = selectedBackgroundColor;
    self.selectedBgView.backgroundColor = selectedBackgroundColor;
}


/**
 设置选中背景色视图的圆角

 @param selectedBgViewCornerRadius 选中背景色视图的圆角
 */
- (void)setSelectedBgViewCornerRadius:(CGFloat)selectedBgViewCornerRadius {
    _selectedBgViewCornerRadius = selectedBgViewCornerRadius;
    self.selectedBgView.layer.cornerRadius = selectedBgViewCornerRadius;
}


/**
 按钮点击事件

 @param button 按钮
 */
- (void)buttonClick:(UIButton *)button {
    
    if (!_outScrollView) {
        [self setButtonSelected:button.tag];
    }
    
    if (_delegate&&[_delegate respondsToSelector:@selector(buttonClick:)]) {
        [_delegate buttonClick:button.tag];
    }
}


/**
 选中按钮、移动视图和滑杆

 @param index 下标
 */
- (void)setButtonSelected:(NSInteger)index {
    CGFloat x = index * _titleSpacing + index * _titleLabelW;
    CGFloat labelH = self.bounds.size.height - _sliderTopMargin -_sliderHeight;
    NSTimeInterval duration = defaultDuration;
    if (_duration) {
        duration = _duration;
    }
    
    [UIView animateWithDuration:duration animations:^{
        _selectedView.frame = CGRectMake(x, 0, _titleLabelW, labelH);
        _topContentView.frame = CGRectMake(-x, 0, _topContentView.bounds.size.width, labelH);
        if (_slider) {
             _slider.frame = CGRectMake(x, _slider.frame.origin.y, _slider.frame.size.width, _slider.frame.size.height);
        }
    }];
}

/**
 根据滚动百分比设置滚动偏移量
 
 @param scrollPercent 百分比
 */
- (void)setScrollOffssetWithScrollPercent:(CGFloat)scrollPercent {
    CGFloat labelH = self.bounds.size.height - _sliderTopMargin -_sliderHeight;
    
    _selectedView.frame = CGRectMake((self.bounds.size.width + _titleSpacing) * scrollPercent, 0, _titleLabelW, labelH);
    _topContentView.frame = CGRectMake(-(self.bounds.size.width + _titleSpacing) * scrollPercent, 0, _titleLabelW, labelH);
    if (_slider) {
        _slider.frame = CGRectMake((self.bounds.size.width + _titleSpacing) * scrollPercent, _slider.frame.origin.y, _slider.frame.size.width, _slider.frame.size.height);
    }
}


/**
 设置外部的滚动视图

 @param outScrollView 外部滚动视图
 */
- (void)setOutScrollView:(UIScrollView *)outScrollView {
    _outScrollView = outScrollView;
    [outScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSValue *value = change[@"new"];
    CGPoint point = [value CGPointValue];
    CGFloat scrollPercent = point.x / _outScrollView.contentSize.width;
    [self setScrollOffssetWithScrollPercent:scrollPercent];
}

- (void)dealloc
{
    if (_outScrollView) {
        [_outScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)bottomLabelArray {
    if (!_bottomLabelArray) {
        _bottomLabelArray = @[].mutableCopy;
    }
    return _bottomLabelArray;
}


- (NSMutableArray *)topLabelArray {
    if (!_topLabelArray) {
        _topLabelArray = @[].mutableCopy;
    }
    return _topLabelArray;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = @[].mutableCopy;
    }
    return _buttonArray;
}

- (UIView *)selectedView {
    if (!_selectedView) {
        _selectedView = [[UIView alloc]init];
        _selectedView.clipsToBounds = YES;
    }
    return _selectedView;
}

- (UIView *)selectedBgView {
    if (!_selectedBgView) {
        _selectedBgView = [[UIView alloc]init];
        _selectedBgView.backgroundColor = [UIColor whiteColor];
    }
    return _selectedBgView;
}

- (UIView *)topContentView {
    if (!_topContentView) {
        _topContentView = [[UIView alloc]init];
    }
    return _topContentView;
}

- (UIView *)slider {
    if (!_slider) {
        _slider = [[UIView alloc]init];
    }
    return _slider;
}

@end
