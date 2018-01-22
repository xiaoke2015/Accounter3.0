//
//  DetailViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DetailViewController.h"

#import "DetailHeadView.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)DetailHeadView*headView ;



@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    
    [self initNaviBarBtn:@"详情"];
    
//    [self initLeftItem];
    
    [self initHeadView];
    
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




- (void)initLeftItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [btn setImage:[UIImage imageNamed:@"share_btn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
//    [self setRightBarWithCustomView:btn];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [btn2 setImage:[UIImage imageNamed:@"collect_btn"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(leftBtnAction2) forControlEvents:UIControlEventTouchUpInside];
//    btn2.backgroundColor = [UIColor redColor];
//    btn.backgroundColor = [UIColor orangeColor];
    
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIBarButtonItem *buttonItem2 = [[UIBarButtonItem alloc]initWithCustomView:btn2];

    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    barButtonItem.width = -16;
    
    self.navigationItem.rightBarButtonItems = @[barButtonItem, buttonItem ,buttonItem2];
    
}

- (void)leftBtnAction {
    
    NSString * string = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",APPSTOREID];
    
    NSString *share_title = @"分享给你";
    NSString *share_url = string;
    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[share_title,[NSURL URLWithString:share_url]] applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}


- (void)leftBtnAction2 {
    
    

}



- (void)initHeadView {
    
    
    DetailHeadView *headView = [[DetailHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 100)];
    
    [headView setCommentBlock:^{
        [self commentAction];
    }];
    
    
    _headView = headView;
}


- (void)commentAction {
    
    
}




- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEM_HEIGHT - 64  - 0)];
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
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [footer endRefreshingWithNoMoreData];
    
    
    _tableView.mj_footer = footer;
    
    _tableView.tableHeaderView = _headView;
}


- (void)headRefreshing {
    
    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
    [self loadData];
    
}


- (void)footRefreshing {
    
    [_tableView.mj_footer endRefreshing];
    
    [self loadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
 
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




- (void)loadData {
    
    
    [_headView dataWithModel:_model];
    
    _tableView.tableHeaderView = _headView;
    

}


@end
