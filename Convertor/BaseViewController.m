//
//  BaseViewController.m
//  MBDemo
//
//  Created by yuyue on 2017/4/26.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "BaseViewController.h"



@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma detail 设置偏移量
    self.edgesForExtendedLayout = UIRectEdgeNone ;
//    [self.navigationController.navigationBar setBarTintColor:MAINCOLOR];

    
//    _naviLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
//    _naviLine.backgroundColor = GRAY200;
    
    [self reset];
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

#pragma mark 在ios7中，设置setSeparatorInset:UIEdgeInsetsZero 能将空白去掉。
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = NO;
    
    UIColor *color = [UIColor whiteColor] ;//MAINCOLOR;
    
    [self.view addSubview:_naviLine];
    [self.navigationController.navigationBar setBarTintColor:color];
    self.navigationController.navigationBar.translucent = NO;
    

    
}



- (void)reset {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:RGB(25, 25, 25)};
}




- (void)initTitle:(NSString*)title {
    
    [self setTitleViewWithCustomView:[self titleLabelWithTitle:title]];

}


- (void)initNaviBarBtn:(NSString*)title {
    
    [self setLeftBarWithCustomView:[self barBtnWithSEL:@selector(naviBtn)]];

    [self setTitleViewWithCustomView:[self titleLabelWithTitle:title]];
    
}

- (void)initPresentBarBtn:(NSString*)title {
    
    [self setLeftBarWithCustomView:[self barBtnWithSEL:@selector(presentBtn)]];
    
    [self setTitleViewWithCustomView:[self titleLabelWithTitle:title]];
}


- (UIButton*)barBtnWithSEL:(SEL)action {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImage *image = [UIImage imageNamed:@"back_img"];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (UILabel *)titleLabelWithTitle:(NSString*)title {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 30)];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
//    label.textColor = [UIColor whiteColor];
     label.textColor = RGB(25, 25, 25);
    
    return label;
}


- (void)presentBtn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)naviBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)setLeftBarWithCustomView:(UIView *)customView {
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    barButtonItem.width = -16;
    
    self.navigationItem.leftBarButtonItems = @[barButtonItem, buttonItem];
}



- (void)setTitleViewWithCustomView:(UIView *)customView {
    
    self.navigationItem.titleView = customView;
}



- (void)setRightBarWithCustomView:(UIView *)customView  {
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    barButtonItem.width = -16;
    
    self.navigationItem.rightBarButtonItems = @[barButtonItem, buttonItem];
}






@end
