# STSegmentView
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/wing3501/STSegmentView/blob/master/LICENSE)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/STSegmentView.svg)](https://img.shields.io/cocoapods/v/STSegmentView.svg)


**STSegmentView** ios视觉差分段选择器，带滑块,支持与外层scrollview同步滑动

视觉差原理参考:
https://github.com/lizelu/ZLCustomeSegmentControlView



![image](https://github.com/wing3501/STSegmentView/blob/master/screenshot/20170619.gif)
## STSegmentView的使用
在需要用到的地方 `#import <STSegmentView.h>`

简单使用

	STSegmentView *exampleSegmentView = [[STSegmentView alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 50)];
    exampleSegmentView.titleArray = @[@"test1",@"test2",@"test3",@"test4"];
    exampleSegmentView.selectedBackgroundColor = [UIColor redColor];
    exampleSegmentView.selectedBgViewCornerRadius = 25;
    [self.view addSubview: exampleSegmentView];

联动scrollview

	exampleSegmentView.outScrollView = scrollView;


更多属性详见example





## 安装
1. [CocoaPods](https://cocoapods.org/)安装：
```
pod 'STSegmentView' 
```
2. 下载ZIP包,将`STSegmentView`资源文件拖到工程中。



## 其他
为了不影响您项目中导入的其他第三方库，本库没有导入任何其他的第三方内容，可以放心使用。
* 如果您有什么建议可以Issues我，谢谢
* 后续我会持续更新，为它添加更多的功能，欢迎star :)


