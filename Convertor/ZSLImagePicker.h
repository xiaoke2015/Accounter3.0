//
//  ZSLImagePicker.h
//  ExtendDemo
//
//  Created by yuyue on 2017/2/13.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void(^Completion)(NSArray *imgArray);

@interface ZSLImagePicker : NSObject

@property (copy, nonatomic) Completion completion;

@property (nonatomic ,copy) void (^GetVideoURL)(NSString*url);

@property (strong, nonatomic) NSMutableArray * selectedAssets;

/*
 * 图片选择单例初始化
 
 */
+ (ZSLImagePicker *)defaultImagePicker;


/*
 * 图片选择完成
 @program 选择完成 block
 */
- (void)completion:(Completion)completion;


/*
 * 选择图片
 @program 当前响应 VC
 */
- (void)pickImageWithVC:(UIViewController *)vc ;

/*
 * 拍照
 @program 当前响应 VC
 */
- (void)takePhotoWithVC:(UIViewController *)vc ;


/*
 * 视频
 @program 当前响应 VC
 */
- (void)pickVideoWithVC:(UIViewController *)vc ;

@end
