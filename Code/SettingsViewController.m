//
//  SettingsViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SettingsViewController.h"

#import "SettingsTableViewCell.h"

#import <LeanCloudFeedback/LeanCloudFeedback.h>

#import "CLLockVC.h"

#import "AboutViewController.h"

#import "CoreArchive.h"

#import "CoreLockConst.h"

@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UISwitch *switchBtn;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSwitch];
    
    [self initTableView];
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


- (void)initSwitch {
    
    _switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 90, 0, 60, 40)];
    
    [_switchBtn addTarget:self action:@selector(switchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    [_switchBtn setOn:hasPwd];
}


- (void)switchBtnAction:(UISwitch*)switchBtn {
    
    NSLog(@"%@",@(switchBtn.isOn));
    
    if(switchBtn.isOn == YES){
        
        [self shouShiAction];
    }
    else {
        
        [CoreArchive removeStrForKey:CoreLockPWDKey];
    }
}


- (void)initTableView  {
    
    CGFloat y = 0;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y - 50) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = GRAYCOLOR;
    
    
    //    [self creatFootView];
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0){
        return 1;
    }
    else if (section == 1){
        return 2;
    }
    else if (section == 2){
        return 2;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingsTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[SettingsTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];

        cell.textLabel.font = FONT14;
    }
    
    cell.accessoryView = nil;
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            
            cell.textLabel.text = @"手势密码";
            cell.imageView.image = [UIImage imageNamed:@"set_pwd"];
            
            cell.accessoryView = _switchBtn;
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"手势密码";
            
        }
    }
    else if (indexPath.section == 1){
        
        if(indexPath.row == 0){
            
            cell.textLabel.text = @"好评鼓励";
            cell.imageView.image = [UIImage imageNamed:@"set_comment"];
        }
        else if (indexPath.row == 1){
            cell.textLabel.text = @"意见反馈";
            cell.imageView.image = [UIImage imageNamed:@"set_feedback"];
            
        }
    }
    
    else if (indexPath.section == 2){
        
        if(indexPath.row == 0){
            
            cell.textLabel.text = @"分享";
            cell.imageView.image = [UIImage imageNamed:@"set_share"];
        }
        else if (indexPath.row == 1){
            
            cell.textLabel.text = @"关于我们";
            cell.imageView.image = [UIImage imageNamed:@"set_about"];
        }
        
    }
    
    
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if(indexPath.section == 0){
        
        if(indexPath.row == 0){
            
//            cell.textLabel.text = @"手势密码";
//            [self shouShiAction];
        }
        else if (indexPath.row == 1){
//            cell.textLabel.text = @"手势密码";
            
        }
    }
    else if (indexPath.section == 1){
        
        if(indexPath.row == 0){
            
//            cell.textLabel.text = @"好评鼓励";
            [self commentAction];
        }
        else if (indexPath.row == 1){
//            cell.textLabel.text = @"意见反馈";
            
            [self feedbackAction];
            
        }
    }
    
    else if (indexPath.section == 2){
        
        if(indexPath.row == 0){
            
//            cell.textLabel.text = @"分享";
            
            [self shareAction];
        }
        else if (indexPath.row == 1){
            
            AboutViewController *nextVC = [[AboutViewController alloc]init];
            nextVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
        
    }

}


- (void)shareAction {
    
    NSString * string = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",APPSTOREID];
    
    NSString *share_title = @"分享给你";
    NSString *share_url = string;
    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[share_title,[NSURL URLWithString:share_url]] applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}


- (void)commentAction {
    
    NSString *url = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=";
    
    url = [url stringByAppendingString:APPSTOREID];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}


- (void)feedbackAction {
    
    LCUserFeedbackAgent *agent = [LCUserFeedbackAgent sharedInstance];
    /* title 传 nil 表示将第一条消息作为反馈的标题。 contact 也可以传入 nil，由用户来填写联系方式。*/
    [agent showConversations:self title:nil contact:nil];
}



- (void)shouShiAction {
    
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(hasPwd == YES){
        
        [CLLockVC showModifyLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            [lockVC dismiss:0.5f];
        }];
    }
    else {
        
        [CLLockVC showSettingLockVCInVC:self successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            
            NSLog(@"密码设置成功");
            [lockVC dismiss:0.5f];
        }];
    }
    
}



@end
