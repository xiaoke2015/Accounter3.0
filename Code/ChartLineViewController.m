//
//  ChartLineViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ChartLineViewController.h"

#import "STSegmentView.h"

#import "BEMSimpleLineGraphView.h"

#import "BillDataBase.h"

#import "ChartTableViewCell.h"

@interface ChartLineViewController ()<STSegmentViewDelegate ,BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate ,UITableViewDelegate,UITableViewDataSource>

@property (retain, nonatomic) BEMSimpleLineGraphView *myGraph;

@property (strong, nonatomic) NSMutableArray *arrayOfValues;
@property (strong, nonatomic) NSMutableArray *arrayOfDates;

@property (nonatomic,strong) STSegmentView *exampleSegmentView1;

@property (nonatomic,strong)NSMutableArray* dataSource;
@property (nonatomic,strong)NSMutableArray* dataSource2;

@property (nonatomic ,strong)NSString *payType;

@property (strong,nonatomic)UITableView*tableView;

@end

@implementation ChartLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@""];
    
    self.payType = @"1";
    
    self.dataSource = [NSMutableArray array];
    self.dataSource2 = [NSMutableArray array];
    
    [self initCustomView];
    
    [self creatView];
    
    [self initTableView];
    
    [self loadData];
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




- (void)creatView {
    
//    self.view.backgroundColor = [UIColor colorWithRed:0 green:118/255.0 blue:1.0 alpha:1.0];
    
    
    //创建表格
    self.myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 20, SCREEM_WIDTH - 20, (SCREEM_HEIGHT - 20) / 3.0)];
    
    //    CGFloat maxY = CGRectGetMaxY(self.myGraph.frame) + 20;
    
    self.myGraph.delegate = self;
    self.myGraph.dataSource = self;
    [self.view addSubview:self.myGraph];
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    // 配置x轴的数据展示
    self.myGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    //设置图表的属性
    self.myGraph.enableTouchReport = YES;
    self.myGraph.enablePopUpReport = YES;
    
    self.myGraph.autoScaleYAxis = YES;
    self.myGraph.alwaysDisplayDots = NO;
    self.myGraph.enableReferenceXAxisLines = YES;
    self.myGraph.enableReferenceYAxisLines = YES;
    self.myGraph.enableReferenceAxisFrame = YES;
    
    //    显示X,Y轴的刻度标签
    self.myGraph.enableXAxisLabel = YES;
    self.myGraph.enableYAxisLabel = YES;
    //设置标签的颜色
    self.myGraph.colorXaxisLabel = RGB(50, 50, 50);
    self.myGraph.colorYaxisLabel = RGB(50, 50, 50);
    
    //开启曲线
    self.myGraph.enableBezierCurve = YES;
    
    // 绘制平均线
    self.myGraph.averageLine.enableAverageLine = NO;
    self.myGraph.averageLine.alpha = 0.6;
    self.myGraph.averageLine.color = MAINCOLOR;
    self.myGraph.averageLine.width = 2;
    self.myGraph.averageLine.dashPattern = @[@(10),@(10)];
    
    
    //设置图表绘制的动画效果
    self.myGraph.animationGraphStyle = BEMLineAnimationDraw;
    
    // Y轴参考线
    self.myGraph.lineDashPatternForReferenceYAxisLines = @[@(5),@(5)];
    
    // 格式化显示Y轴的数据
    self.myGraph.formatStringForValues = @"￥%.1f";
    
    //    self.dayArray = [NSMutableArray arrayWithCapacity:7];
    
    
}




#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    
    
    
    return _dataSource2.count ;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    
    BillDayModel *model = _dataSource2[index];
    
    return model.totalPrice ;// [[self.arrayOfValues objectAtIndex:index] doubleValue];
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    
    return 2;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    
    BillDayModel *model = _dataSource2[index];
    
    return model.day;
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    
    
    //    ForecastWeatherModel *fwModel = (ForecastWeatherModel *)(self.dayArray[index]);
    //
    //    [self updateWeatherInfoViewWithModel:fwModel];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    //    NSSLog(@">>%@", [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]]);
    //    self.labelDates.text = [NSString stringWithFormat:@"between %@ and %@", [self labelForDateAtIndex:0], [self labelForDateAtIndex:self.arrayOfDates.count - 1]];
}

- (NSString *)noDataLabelTextForLineGraph:(BEMSimpleLineGraphView *)graph{
    return @"update...";
}

//- (NSString *)popUpSuffixForlineGraph:(BEMSimpleLineGraphView *)graph {
//    return @"*";
//}

//- (NSString *)popUpPrefixForlineGraph:(BEMSimpleLineGraphView *)graph {
//    return [NSString stringWithFormat:@"# "];
//}




- (void)loadData {
    
    BillDataBase *bill = [[BillDataBase alloc]init];
    
    NSString * date = self.date;
    
    [bill queryLineMouth:date payType:self.payType Data:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:objects];
//        [self.tableView reloadData];
        
//        [self.myGraph reloadGraph];
        
        [self.tableView reloadData];
        
        
    } price:^(CGFloat paynum, CGFloat income) {
        
//        [self.circleView addLayerWithArray:self.dataSource total:paynum];
    }];
    
    
    [bill queryLine2Mouth:date payType:self.payType Data:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [self.dataSource2 removeAllObjects];
        [self.dataSource2 addObjectsFromArray:objects];
        //        [self.tableView reloadData];
        
        [self.myGraph reloadGraph];
    }];
    
    
}




- (void)initTableView  {
    
    CGFloat y = self.myGraph.bottom + 20;
    
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
    ChartTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[ChartTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }

    NSInteger pay = [self.payType integerValue];
    
    BillDayModel * model = _dataSource[indexPath.row];

    if(pay == 1){
        
        cell.textLabel.text = model.day;
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"- %@",@(model.totalPrice)];
    }
    else if (pay == 2){
        
        cell.textLabel.text = model.day;
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"+ %@",@(model.totalPrice)];
    }
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}




@end
