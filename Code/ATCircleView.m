//
//  ATCircleView.m
//  Convertor
//
//  Created by 李加建 on 2017/8/31.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ATCircleView.h"


@interface ATCircleView ()

@property (nonatomic ,strong)CALayer *testLayer;

@end

@implementation ATCircleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    
    [self addLayer];
    
    return self;
}




- (void)addLayer  {
    

    CALayer *testLayer = [CALayer layer];
    testLayer.backgroundColor = [UIColor clearColor].CGColor;
    testLayer.frame = CGRectMake(0, 0, self.width, self.height);
    [self.layer addSublayer:testLayer];
    
    self.testLayer = testLayer;
    

}


- (void)addLayerWithArray:(NSArray*)array total:(CGFloat)total {
    
//    for(CAShapeLayer *shapeLayer in self.testLayer.sublayers){
//        
//        [shapeLayer removeFromSuperlayer];
//    }
    
    [self addShapeLayer:RGB(105, 203, 135) start:0 end:M_PI *2];
    
    CGFloat start = 0;
    CGFloat end = 0;
    
    for(int i=0;i<array.count;i++){
        
        BTypeModel * model = array[i];
        
        CGFloat scale = model.totalPrice/total;
        
        end = start + (M_PI*2 * scale);
        
        [self addShapeLayer:model.color start:start end:end];
        
        start = end;
    }
    
}





- (void)addShapeLayer:(UIColor*)color start:(CGFloat)startAngle end:(CGFloat)endAngle {
    
    CGFloat w = 40;
    
    // 背景layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineCap = kCALineCapButt;
    shapeLayer.lineWidth = w;
    
    // 圆环半径
    CGFloat radius = (self.width - w)/2;
    
    // 圆环中心点
    CGPoint center = CGPointMake(self.width/2, self.height/2);
    
    UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    shapeLayer.path = thePath.CGPath;
    [self.testLayer addSublayer:shapeLayer];
    
}



@end
