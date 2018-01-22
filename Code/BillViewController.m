//
//  BillViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BillViewController.h"

#import "STSegmentView.h"

#import "BillCollectionViewCell.h"

#import "BillTypeModel.h"

#import "KeyboardView.h"

#import "BillDataBase.h"

#import "UICustomDatePicker.h"

@interface BillViewController ()<STSegmentViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout >

@property (strong, nonatomic)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (nonatomic,strong) STSegmentView *exampleSegmentView1;

@property (nonatomic,strong) KeyboardView *keyboardView;

@property (nonatomic ,assign)NSInteger selTag;

@property (nonatomic ,strong)NSString *payType;

@property (nonatomic ,strong)NSString *selDate;

@property (nonatomic ,strong)UIButton *dateBtn;

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _selTag = -1;
    
    self.payType = @"1";
    
    [self initCustomView];
    
    [self initRigthItem];
    
    [self initData];
    
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



- (void)selStrWithDate:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    self.selDate = [dateFormatter stringFromDate:date];
}



- (KeyboardView *)keyboardView {
    
    if(_keyboardView == nil){
        KeyboardView * keyboardView = [[KeyboardView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, 50*5)];
        
        [self.view addSubview:keyboardView];
        
        keyboardView.doneBlock = ^(NSString *price) {
            [self doneBlockWithPrice:price];
        };
        
        _keyboardView = keyboardView;
        
       
        CGFloat w = SCREEM_WIDTH/4;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, keyboardView.height - 50, w, 50)];
        
        btn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:18];
        
        [btn setTitle:@"今天" forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn setTitleColor:RGB(25, 25, 25) forState:UIControlStateNormal];
        [keyboardView addSubview:btn];
        
        [btn addTarget:self action:@selector(selDateWithCustom) forControlEvents:UIControlEventTouchUpInside];
        
        [self selStrWithDate:[NSDate date]];
        self.dateBtn = btn;
        
    }
    return _keyboardView;
}



- (void)selDateWithCustom {
    
    [UICustomDatePicker showCustomDatePickerAtView:self.navigationController.view choosedDateBlock:^(NSDate *date) {
        
        NSLog(@"current Date:%@",date);
        
        [self selStrWithDate:date];
        
        [self.dateBtn setTitle:self.selDate forState:UIControlStateNormal];
        
    } cancelBlock:^{
        
    }];
}




- (void)doneBlockWithPrice:(NSString*)price {
 
    BillDataBase * dataBase = [[BillDataBase alloc]init];
    
    NSString *type = [NSString stringWithFormat:@"%@",@(_selTag + 1)];
    
    [dataBase insertTableWithBill:type
                            price:price
                              pay:self.payType
                              day:self.selDate];
 
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




- (void)initData {
    
    BillTypeModel * model = [BillTypeModel shareInstance];
    
    self.dataSource = [NSMutableArray arrayWithArray:model.titleArray];
    
}



- (void)initRigthItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    [btn setImage:[UIImage imageNamed:@"del_btn"] forState:UIControlStateNormal];
    
    [self setRightBarWithCustomView:btn];
    
    [btn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)rightItemAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    BillTypeModel * model = [BillTypeModel shareInstance];
    
    if(index == 0){
        self.payType = @"1";
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:model.titleArray];

    }
    else if (index == 1){
        self.payType = @"2";
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:model.title2Array];
    }
    
    [self.collectionView reloadData];
    
    NSLog(@"paytype = %@",self.payType);
}




- (void)creatView {
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH,SCREEM_HEIGHT -50 ) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = NO;
    //注册Cell，必须要有
    [self.collectionView registerClass:[BillCollectionViewCell class] forCellWithReuseIdentifier:@"BillCollectionViewCell"];
    
    
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
    
    [self.view addSubview:self.collectionView];
    
    
    //    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
}



#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataSource.count;
    
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}






//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"BillCollectionViewCell";
    BillCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
  
//    cell.backgroundColor = RGB(10*indexPath.row, 20, 100);
    
    BillTypeModel * model = [BillTypeModel shareInstance];
    
    
    NSInteger pay = [self.payType integerValue];
    
    if(pay == 1){
    
        cell.label.text = model.titleArray[indexPath.row];
        
        if(_selTag == indexPath.row) {
            
            cell.imgView.image = [UIImage imageNamed:model.imgSelArray[indexPath.row]];
        }
        else {
            cell.imgView.image = [UIImage imageNamed:model.imgArray[indexPath.row]];
        }
    }
    else if(pay == 2){
        
        cell.label.text = model.title2Array[indexPath.row];
        
        if(_selTag == indexPath.row) {
            
            cell.imgView.image = [UIImage imageNamed:model.img2SelArray[indexPath.row]];
        }
        else {
            cell.imgView.image = [UIImage imageNamed:model.img2Array[indexPath.row]];
        }
    }
    
    
    
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CGFloat w = SCREEM_WIDTH/5;
    CGFloat h = w/3.f*4.f;
    
    return CGSizeMake(w, h);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    _selTag = indexPath.row;
    
    [self.collectionView reloadData];
    
    
    [self.keyboardView show];
    
    self.collectionView.frame = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64 - self.keyboardView.height);
}





@end
