//
//  ChartViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ChartViewController.h"

#import "STSegmentView.h"

#import "ChartLineViewController.h"

#import "BillDataBase.h"

#import "ITDatePickerController.h"

#import "HomeTableViewCell.h"

#import "ATCircleView.h"

@interface ChartViewController () <STSegmentViewDelegate , UITableViewDelegate,UITableViewDataSource ,ITDatePickerControllerDelegate>

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic,strong) STSegmentView *exampleSegmentView1;

@property (nonatomic ,strong)NSString *payType;

@property (nonatomic,strong)ATCircleView * circleView;

@property (nonatomic,strong)UIButton * mouthBtn;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.payType = @"1";
    
    [self initCustomView];
    
    [self initRightItem];
    
    self.dataSource = [NSMutableArray array];
    
    [self creatView];
    
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


- (void)initRightItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    [btn setImage:[UIImage imageNamed:@"btn_chart"] forState:UIControlStateNormal];
    
    [self setRightBarWithCustomView:btn];
    
    [btn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightItemAction {
    
    
    ChartLineViewController *nextVC = [[ChartLineViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    nextVC.date = self.mouthBtn.titleLabel.text;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}



- (void)initCustomView {
    
    _exampleSegmentView1 = [[STSegmentView alloc]initWithFrame:CGRectMake(0, 30, 150, 30)];
    _exampleSegmentView1.titleArray = @[@"支出",@"收入"];
    _exampleSegmentView1.selectedBackgroundColor = MAINCOLOR;
    _exampleSegmentView1.selectedBgViewCornerRadius = 15;
    //    _exampleSegmentView1.sliderTopMargin = 3;
    //    _exampleSegmentView1.sliderTopMargin = 3;
    _exampleSegmentView1.labelFont = [UIFont systemFontOfSize:14];
    
    _exampleSegmentView1.backgroundColor = RGB(228, 228, 238);
    _exampleSegmentView1.layer.cornerRadius = 15;
    _exampleSegmentView1.layer.masksToBounds = YES;
    
    _exampleSegmentView1.delegate = self;
    
    //    [self.view addSubview:_exampleSegmentView1];
    [self setTitleViewWithCustomView:_exampleSegmentView1];
}


- (void)buttonClick:(NSInteger)index {
    
 
    if(index == 0){
        self.payType = @"1";
    }
    else if (index == 1){
        self.payType = @"2";
    }
    
    [self loadData];
    
    NSLog(@"paytype = %@",self.payType);
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
    
    [self.mouthBtn setTitle:dateString forState:UIControlStateNormal];
    
    [self loadData];
}



- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self loadData];
}



- (void)creatView {
    
    ATCircleView * circle = [[ATCircleView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2-90, 30, 180, 180)];
    [self.view addSubview:circle];
    
    self.circleView = circle;
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 240 - 0.5, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [self.view addSubview:line];
    
  
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 80, 30)];

    [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    [self.view addSubview:btn];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    [btn setTitle:strDate forState:UIControlStateNormal];
  
    self.mouthBtn = btn;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnAction {
    
    [self dateSelect];
}



- (void)initTableView  {
    
    CGFloat y = 220;
    
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





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
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
    
    BTypeModel * billType = _dataSource[indexPath.row];
    
    NSInteger pay = [self.payType integerValue];
    
    BillTypeModel *typeModel = [BillTypeModel shareInstance];
    
    NSInteger tag = [billType.type integerValue] - 1;
    
    cell.badge.backgroundColor = billType.color;
    
    if(pay == 1){
        
        NSString *title = typeModel.titleArray[tag];
        
        NSString *imgName = typeModel.imgSelArray[tag];
        
        cell.imageView.image = [UIImage imageNamed:imgName];
        
        cell.textLabel.text = title;
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"- %@",@(billType.totalPrice)];
    }
    else if (pay == 2){
        
        NSString *title = typeModel.title2Array[tag];
        
        NSString *imgName = typeModel.img2SelArray[tag];
        
        cell.imageView.image = [UIImage imageNamed:imgName];
        
        cell.textLabel.text = title;
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"+ %@",@(billType.totalPrice)];
    }
    
    
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}






- (void)loadData {
    
    BillDataBase *bill = [[BillDataBase alloc]init];
    
    NSString * date = self.mouthBtn.titleLabel.text;
    
    [bill queryMouth:date payType:self.payType Data:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:objects];
        [self.tableView reloadData];
    
        
    } price:^(CGFloat paynum, CGFloat income) {
       
         [self.circleView addLayerWithArray:self.dataSource total:paynum];
    }];
}







@end
