//
//  BaseMacro.h
//  MBDemo
//
//  Created by yuyue on 2017/5/5.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#ifndef BaseMacro_h
#define BaseMacro_h




// 尺寸大小
#define SCREEM    [UIScreen mainScreen].bounds

#define SCREEM_WIDTH  SCREEM.size.width

#define SCREEM_HEIGHT  SCREEM.size.height

// 颜色

#define RGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1]
#define RGBA(A,B,C,Alpha) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:Alpha]

#define GRAY50  [UIColor colorWithRed:50/255.f green:50/255.f blue:50/255.f alpha:1]
#define GRAY100 [UIColor colorWithRed:100/255.f green:100/255.f blue:100/255.f alpha:1]
#define GRAY200 [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1]
#define GRAY250 [UIColor colorWithRed:250/255.f green:250/255.f blue:250/255.f alpha:1]


// 文字大小
#define FONT(x) [UIFont systemFontOfSize:x]

#define FONT20 [UIFont systemFontOfSize:20]
#define FONT18 [UIFont systemFontOfSize:18]
#define FONT16 [UIFont systemFontOfSize:16]
#define FONT15 [UIFont systemFontOfSize:15]
#define FONT14 [UIFont systemFontOfSize:14]
#define FONT12 [UIFont systemFontOfSize:12]
#define FONT11 [UIFont systemFontOfSize:11]
#define FONT10 [UIFont systemFontOfSize:10]



#endif /* BaseMacro_h */
