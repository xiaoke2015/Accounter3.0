//
//  AboutViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic ,strong)UILabel *label;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"关于我们"];
    
    [self creatView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:RGB(25, 25, 25)};
}



- (void)longPress {
    
    NSLog(@"longPress");
    
    self.label.hidden = NO;
}


- (void)creatView {
    
    
    CGFloat w = SCREEM_WIDTH/5*2;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - w/2, 30, w, w)];
    
    imgView.image = [UIImage imageNamed:@"about_img.jpg"];
//    imgView.layer.masksToBounds = YES;
//    imgView.layer.cornerRadius = 15;
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    
    
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)];
    [imgView addGestureRecognizer:longPress];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imgView.bottom+10, SCREEM_WIDTH, 40)];
    
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGB(25, 25, 25);
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    label.text = @"试客";
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottom, SCREEM_WIDTH, 30)];
    
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = RGB(25, 25, 25);
    label1.font = FONT14;
    label1.text = @"好用的手机工具";
    [self.view addSubview:label1];
    
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT - 64 - 50, SCREEM_WIDTH, 30)];
    
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = RGB(25, 25, 25);
    label3.font = FONT14;
    label3.text = @"V 2.0";
    [self.view addSubview:label3];
    

    
    
}


@end
