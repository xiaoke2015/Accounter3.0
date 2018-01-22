//
//  HomeViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeHeadView.h"

#import "BillDataBase.h"

#import "HomeTableViewCell.h"

#import "ITDatePickerController.h"

#import "CLLockVC.h"

#import "GifImageView.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource ,ITDatePickerControllerDelegate>

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic,strong)HomeHeadView* headView;

@property (nonatomic ,strong)GifImageView *gifImageView;
@property (nonatomic ,strong)NSString *gifurl;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    
    [self initHeadView];
    
    [self initTableView];
    
//    [self loadData];
    
    [self verifyLock];
    
    [self loadGift];
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


- (void)verifyLock {
    
    BOOL hasPwd = [CLLockVC hasPwd];
    
    if(hasPwd == YES){
        
        [CLLockVC showVerifyLockVCInVC:self forgetPwdBlock:^{
            NSLog(@"忘记密码");
        } successBlock:^(CLLockVC *lockVC, NSString *pwd) {
            NSLog(@"密码正确");
            [lockVC dismiss:0.5f];
        }];
    }
}




- (void)initHeadView {
    
    
    HomeHeadView *headView = [[HomeHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 220)];
    
    headView.goBlock = ^{
        
        [self dateSelect];
    };
    
    
    [self.view addSubview:headView];
    
    _headView = headView;
    
    
//    BillDataBase *bill = [[BillDataBase alloc]init];
//    
//    [bill insertTableWithBill];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    [_headView .dateBtn setTitle:strDate forState:UIControlStateNormal];
    
}



- (void)dateSelect {
    
    ITDatePickerController *datePickerController = [[ITDatePickerController alloc] init];
    datePickerController.tag = 100;                     // Tag, which may be used in delegate methods
    datePickerController.delegate = self;               // Set the callback object
    datePickerController.showToday = NO;                // Whether to show "today", default is yes
//    datePickerController.defaultDate = self.startDate;  // Default date
//    datePickerController.maximumDate = self.endDate;    // maxinum date
    
    [self presentViewController:datePickerController animated:YES completion:nil];
}


- (void)datePickerController:(ITDatePickerController *)datePickerController didSelectedDate:(NSDate *)date dateString:(NSString *)dateString {
    
    [_headView.dateBtn setTitle:dateString forState:UIControlStateNormal];
    
    [self loadData];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];

    [self loadData];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}




- (void)initTableView  {
    
    CGFloat y = _headView.height;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height - y - 50)];
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
    _tableView.backgroundColor = [UIColor whiteColor];
    
  
    
    //    [self creatFootView];
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    BillDayModel * billDay = _dataSource[section];
    
    return billDay.billArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
        
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
//    cell.textLabel.font = FONT15;
//    cell.textLabel.text = _dataSource[indexPath.row];
//    NSString *imgName = _tableArr[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:imgName];
//    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    BillDayModel * billDay = _dataSource[indexPath.section];
    
    BillModel *model = billDay.billArray[indexPath.row];
    
    BillTypeModel *typeModel = [BillTypeModel shareInstance];
    
    NSInteger tag = [model.type integerValue] - 1;
    
    
    NSInteger payType = [model.pay integerValue];
    
    if(payType == 1){
        
        NSString *title = typeModel.titleArray[tag];
        
        NSString *imgName = typeModel.imgSelArray[tag];
        
        cell.imageView.image = [UIImage imageNamed:imgName];
        
        cell.textLabel.text = title;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"- %@",model.price];
    }
    else {
        
        NSString *title = typeModel.title2Array[tag];
        
        NSString *imgName = typeModel.img2SelArray[tag];
        
        cell.imageView.image = [UIImage imageNamed:imgName];
        
        cell.textLabel.text = title;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"+ %@",model.price];
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
    
    return 44;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 44)];
    headView.backgroundColor = RGB(240, 240, 240);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 44)];
    BillDayModel * billDay = _dataSource[section];

    label.font = FONT15;
    label.text = billDay.day;
    [headView addSubview:label];
    
    return headView;
}



//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      
        BillDayModel * billDay = _dataSource[indexPath.section];
        
        BillModel *model = billDay.billArray[indexPath.row];
        
//        [self.dataSource removeObjectAtIndex:indexPath.row];
        
        BillDataBase * dataBase = [[BillDataBase alloc]init];
        [dataBase delWithBillId:model.Id];
        
        [self loadData];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}






- (void)loadData {
    
    BillDataBase *bill = [[BillDataBase alloc]init];
    
    NSString * date = _headView.dateBtn.titleLabel.text;

    [bill queryMouth:date Data:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [self.dataSource removeAllObjects];
        
        [self.dataSource addObjectsFromArray:objects];
        
        [self.tableView reloadData];
        
    } price:^(CGFloat paynum, CGFloat income) {
        
        [self.headView dataWithPayNum:paynum income:income];
    }];
}






- (GifImageView*)gifImageView {
    
    if(_gifImageView == nil){
        
        
        GifImageView *imgView = [[GifImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 80, 20, 80, 80)];
        
        [imgView gif_setImageWithURL:[NSURL URLWithString:@"http://ac-kjvcmly8.clouddn.com/1582e87e2ec671b6408f.gif"]];
        
        [self.view addSubview:imgView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gifTap:)];
        
        [imgView addGestureRecognizer:tap];
        
        _gifImageView = imgView;
    }
    
    return _gifImageView;
}


- (void)gifTap:(UITapGestureRecognizer*)tap {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.gifurl]];
}


- (void)loadGift {
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    BOOL isopen = [currentLanguage isEqualToString:@"zh-Hans-CN"] || [currentLanguage isEqualToString:@"zh-Hans"];
    
    if(isopen == NO){
        return;
    }
    
    
    [AVAnalytics updateOnlineConfigWithBlock:^(NSDictionary *dict, NSError *error) {
        if (error == nil) {
            // 从 dict 中读取参数，dict["k1"] 值应该为 v1
            
            NSDictionary * parameters = dict[@"parameters"];
            
            NSString *bid2 = BUNDLEID;
            
            NSInteger tag = [parameters[bid2] integerValue];
            
            if(tag == 1){
                
        
                AVQuery *query = [AVQuery queryWithClassName:@"banner"];
                
                [query whereKey:@"ispop" equalTo:@"1"];
                
                [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                    
                    if(objects.count > 0){
                        
                        AVObject * object = objects[0];
                        
                        NSString * url = [object objectForKey:@"url"];
                        self.gifurl = url;
                        
                        [self.view addSubview:self.gifImageView];
                        
                        
                    }
                    
                }];
                
                
                
            }
            else {
                
            }
            
        }
    }];

}




@end
