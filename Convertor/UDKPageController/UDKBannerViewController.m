//
//  UDKBannerViewController.m
//  BDKAccountTool
//
//  Created by 李加建 on 2017/12/20.
//  Copyright © 2017年 BDK. All rights reserved.
//

#import "UDKBannerViewController.h"

@interface UDKBannerViewController ()

@end

@implementation UDKBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
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



- (UIImageView *)imageView {
    
    if(_imageView == nil){
        
        _imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
        
        [self.view addSubview:_imageView];
        
        _imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap:)];
        
        [_imageView addGestureRecognizer:tap];
    }
    
    return _imageView;
}



- (void)imgTap:(UITapGestureRecognizer*)tap {
    
    NSLog(@"tap");
    
    NSString *url = self.url;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


@end
