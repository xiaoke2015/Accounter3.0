//
//  ZSLImagePicker.m
//  ExtendDemo
//
//  Created by yuyue on 2017/2/13.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "ZSLImagePicker.h"

#import <MobileCoreServices/MobileCoreServices.h>


@interface ZSLImagePicker () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ZSLImagePicker


#pragma mark - public

+ (ZSLImagePicker *)defaultImagePicker
{
    static ZSLImagePicker *imagePicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imagePicker = [self new];
    });
    return imagePicker;
}


- (void)completion:(Completion)completion {
    self.completion = completion;
}


#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        //得到照片
        UIImage *photos = info[UIImagePickerControllerOriginalImage];
        
        if(self.completion != nil){
            self.completion(@[[ZSLImagePicker fixOrientation:photos]]);
        }
        
    }
    else if ([mediaType isEqualToString:@"public.movie"]){
        
        NSString *url = info[@"UIImagePickerControllerMediaURL"];
        
        if(_GetVideoURL != nil){
            _GetVideoURL(url);
        }
        
    }
    
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}




- (void)pickVideoWithVC:(UIViewController *)vc {
    
    
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = (id)self;
    //    ipc.allowsEditing = YES;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [vc presentViewController:picker animated:YES completion:nil];
}



- (void)takePhotoWithVC:(UIViewController *)vc {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePC = [UIImagePickerController new];
        imagePC.delegate = self;
//        imagePC.editing = YES;
        imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [vc presentViewController:imagePC animated:YES completion:nil];
    }else {
        NSLog(@"无相机");
    }
}


- (void)pickImageWithVC:(UIViewController *)vc {
    
    UIImagePickerController *ipc = [UIImagePickerController new];
    ipc.delegate = (id)self;
//    ipc.allowsEditing = YES;
    
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [vc presentViewController:ipc animated:YES completion:nil];
}



+ (UIImage*)fixOrientation:(UIImage *)aImage {
    
    if (aImage.imageOrientation == UIImageOrientationUp){
        
        return aImage;
    }
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height, CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    
    switch (aImage.imageOrientation) {
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}




@end
