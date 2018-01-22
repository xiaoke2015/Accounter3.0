//
//  UDKPageViewController.m
//  BDKAccountTool
//
//  Created by 李加建 on 2017/12/20.
//  Copyright © 2017年 BDK. All rights reserved.
//

#import "UDKPageViewController.h"

#import "UDKBannerViewController.h"

static NSString * const EnterForeground = @"EnterForeground";

@interface UDKPageViewController ()

@end

@implementation UDKPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:EnterForeground object:nil];
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


+ (void)PostEnterForeground {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EnterForeground object:nil];
}



- (void)loadData {
    
    [self loadType2];
}


- (void)loadType2 {
    
    

    AVQuery *query = [AVQuery queryWithClassName:@"LaunchScreen"];
    
    NSString * objectId = OBJECTID;
    
    [query getObjectInBackgroundWithId:objectId block:^(AVObject *object, NSError *error) {
        // object 就是 id 为 558e20cbe4b060308e3eb36c 的 Todo 对象实例
        
        if(object != nil){
            
            NSString * bid = [object objectForKey:@"bid"];
            
            NSArray *languages = [NSLocale preferredLanguages];
            NSString *currentLanguage = [languages objectAtIndex:0];
            
            BOOL isopen = [currentLanguage isEqualToString:@"zh-Hans-CN"] || [currentLanguage isEqualToString:@"zh-Hans"];
            
            if(isopen){
                
                if([bid isEqualToString:BUNDLEID] == YES){
                    
                    //当前BID 且中文版本
                    
                    NSString* url = [object objectForKey:@"url"];
                    AVFile *file = [object objectForKey:@"image"];
                    
                    NSString* imgUrl = file.url;
                    
                    UDKBannerViewController *nextVC = [[UDKBannerViewController alloc]init];
                    nextVC.imgUrl = imgUrl;
                    nextVC.url = url;
                    
                    [UIApplication sharedApplication].keyWindow.rootViewController = nextVC;
                    
                }
                else {
                    
                    //当前BID
                    if(_successBlock != nil){
                        _successBlock();
                    }
                }
            }
            else {
                // 不是中文版本
                if(_successBlock != nil){
                    _successBlock();
                }
            }
            
        }
        else {
            // 网络请求错误
            if(error.code == -1009){
                
                [self alertView];
            }
            
        }
        
    }];
    
}



- (void)alertView {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络未开启，请检测网络设置\n （点击无线数据-选择WLAN与蜂窝移动网）" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"设置", nil];
    
    [alert show];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(buttonIndex == 0){
        
        [self loadData];
    }
    else if(buttonIndex == 1){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
    
}



@end
