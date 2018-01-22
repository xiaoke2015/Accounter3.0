//
//  TabBarViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "TabBarViewController.h"

#import "HomeViewController.h"
#import "ChartViewController.h"
#import "FinderViewController.h"
#import "SettingsViewController.h"


#import "MyTabBar.h"

#import "BillViewController.h"

#import "CLLockVC.h"

@interface TabBarViewController ()<MyTabBarDelegate ,UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    
    [self initTabBar];
    
//    [self verifyLock];
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





- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if([viewController class ] == [UIViewController class]){
        
        BillViewController *root = [[BillViewController alloc]init];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:root];
        
        [self presentViewController:navi animated:YES completion:nil];
        
        return NO;
    }
    
    return YES;
}



- (void)initTabBar {
    
    HomeViewController *vc1 = [[HomeViewController alloc]init];
    UINavigationController *navi1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    vc1.title = @"收支";
    
    
    
    ChartViewController *vc2 = [[ChartViewController alloc]init];
    
    UINavigationController *navi2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    
    vc2.title = @"图标";
    SettingsViewController *vc3 = [[SettingsViewController alloc]init];
    
    UINavigationController *navi3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    
    vc3.title = @"我的";
    
    
    FinderViewController *vc4 = [[FinderViewController alloc]init];
    
    UINavigationController *navi4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    
    vc4.title = @"发现";
    
    
    [self setVC:vc1 image:@"tabbar_002" selectedImage:@"tabbar_001"];
    [self setVC:vc2 image:@"tabbar_004" selectedImage:@"tabbar_003"];
    [self setVC:vc4 image:@"tabbar_006" selectedImage:@"tabbar_005"];
    [self setVC:vc3 image:@"tabbar_008" selectedImage:@"tabbar_007"];
    
    
    UIViewController *vc = [[UIViewController alloc]init];
    
    
    self.tabBar.translucent = NO;
    self.viewControllers = @[navi1, navi2, vc, navi4, navi3];
    
    [[UITabBar appearance] setTintColor:MAINCOLOR];
//    [[UITabBar appearance] setUnselectedItemTintColor:RGB(25, 25, 25)];
    
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
    
    navi1.navigationBar.translucent = NO;
    navi2.navigationBar.translucent = NO;
    navi3.navigationBar.translucent = NO;
    navi4.navigationBar.translucent = NO;
    
    
    //    [[UINavigationBar appearance] setBarTintColor:MAINCOLOR];
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] ,NSFontAttributeName:FONT18 }];
    
    
    //    tabBar 画线颜色
    CGRect rect = CGRectMake(0, 0, SCREEM_WIDTH, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, RGB(200, 200, 200).CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[UITabBar appearance] setShadowImage:img];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
    
    //    self.viewControllers = @[navi1];
    
    
    
    MyTabBar *tab = [[MyTabBar alloc]init];
    //设置代理（监听控制器的切换， 控制器一旦切换了子控制器，就会调用代理的(tabBarController:didSelectViewController:)的方法
    tab.mdelegate = self;
    //取代系统的tabBar,kvc修改系统的taBbar
    tab.translucent = NO;
    
    [self setValue:tab forKeyPath:@"tabBar"];
    
    
    self.selectedViewController = navi1;
}


//实现代理的方法
- (void)PlusBtnClick:(MyTabBar *)tabBar {
    
    
}



- (void)setVC:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    
    //    vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    
    [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
}



@end
