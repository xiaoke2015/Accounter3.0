//
//  ConfMacro.h
//  MBDemo
//
//  Created by yuyue on 2017/5/5.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#ifndef ConfMacro_h
#define ConfMacro_h



//服务器地址

#import <AVOSCloud/AVOSCloud.h>

#import <MJRefresh/MJRefresh.h>

#import <UIImageView+WebCache.h>

#define HOST @"http://jianzhi.vx818.com/"

#define HOSTAPIKEY(key) [HOST stringByAppendingString:key]

typedef void (^ActionBlock)();

#define DictStr(dict ,key) [NSString stringWithFormat:@"%@",(dict[key]==nil?@"":dict[key])]


// 颜色
#define GRAYCOLOR [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]


//144,119,255
#define MAINCOLOR (RGB(144, 119, 255))


#endif /* ConfMacro_h */
