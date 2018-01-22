//
//  MyTabBar.m
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MyTabBar.h"

//#import "UIView+Extension.h"


@interface MyTabBar()
//添加一个plus按钮控件
@property(nonatomic,weak)UIButton *PlusButton;

@end

@implementation MyTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//调用init会先初始化这个方法
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
    [self SetplusBtn];
    }
    return self;
}


//布局子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置plus的frame
    [self SetPlusBtnFrame];
    //设置所有的tab的frame
    [self SetAllTabBtn];

}


//设置plus按钮
-(void)SetplusBtn{
    
    UIButton *Plusbtn=[[UIButton alloc]init];
    [Plusbtn addTarget:self action:@selector(PlusClick) forControlEvents:UIControlEventTouchUpInside];
    [Plusbtn setBackgroundImage:[UIImage imageNamed:@"tabbar_add"] forState:UIControlStateNormal];
    [Plusbtn setBackgroundImage:[UIImage imageNamed:@"tabbar_add"] forState:UIControlStateHighlighted];
    [Plusbtn setImage:[UIImage imageNamed:@"tabbar_add"] forState:UIControlStateNormal];
    [Plusbtn setImage:[UIImage imageNamed:@"tabbar_add"] forState:UIControlStateHighlighted];
    [self addSubview:Plusbtn];
    self.PlusButton=Plusbtn;
    
}


//plus点击事件的代理
-(void)PlusClick{
    
    
    if([self.mdelegate respondsToSelector:@selector(PlusBtnClick:)]) {
        [self.mdelegate PlusBtnClick:self];
    }
}


//设置plus按钮的frame
-(void)SetPlusBtnFrame{
    //设置plus按钮的frame和中心坐标
    self.PlusButton.size = self.PlusButton.currentBackgroundImage.size;
    self.PlusButton.center=CGPointMake(self.width/2, self.height/2);
}


/**
 *  设置每一个btn的frame
 *
 *  @param tabbarbtn  要设置的按钮
 *  @param index      索引值
 */
-(void)SetTabbarBtnFrame:(UIView *)tabbarbtn Index:(NSInteger)index{
    //计算按钮的尺寸
    CGFloat btnw=self.width/(self.items.count+1);
    CGFloat btnh=self.height;
    tabbarbtn.width=btnw;
    tabbarbtn.height=btnh;
    
    if (index>=2) {
        //计算中间按钮右边的位置
        tabbarbtn.left=btnw*(index+1);
    }
    else{
        //计算中间按钮左边的位置
        tabbarbtn.left=btnw*index;
    }
    tabbarbtn.top=0;
}


/**
 *  设置tabbtn文字的颜色
 *
 *  @param tabbtn 按钮
 *  @param index  索引
 */
/***
 -(void)SetBtnColor:(UIView *)tabbtn Index:(NSInteger)index{
 //获取当前选中的index
 NSInteger seletindex=[self.items indexOfObject:self.selectedItem];
 for (UILabel *label in tabbtn.subviews) {
 if (![label isKindOfClass:[UILabel class]])
 continue;
 label.font=[UIFont systemFontOfSize:10];
 if (seletindex==index) {
 //设置文字颜色
 label.textColor=[UIColor orangeColor];
 }
 else{
 label.textColor=[UIColor blackColor];
 }
 }
 }
 **/


//设置底部所有菜单栏按钮
-(void)SetAllTabBtn {
    NSInteger index=0;
    for (UIView *tabbtn in self.subviews) {
        //使用NSClassFromString来判断是否属于这个类
        if (![tabbtn isKindOfClass:NSClassFromString(@"UITabBarButton")])
            //跳出for循坏语句
            continue;
        [self SetTabbarBtnFrame:tabbtn Index:index];
        
        // [self SetBtnColor:tabbtn Index:index];
        //索引自增
        index++;
        
    }
}


@end
