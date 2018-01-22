//
//  ViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/8/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) CAShapeLayer *shapeLayer2;

@property (nonatomic ,strong)NSArray * homeArray;

@property (nonatomic ,strong)NSMutableArray * btnArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    self.navigationController.navigationBarHidden = YES;
    
//    144,119,255
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
