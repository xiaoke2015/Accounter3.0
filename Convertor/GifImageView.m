//
//  GifImageView.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/29.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "GifImageView.h"

@interface GifImageView ()

@property (nonatomic ,strong)UIWebView *webView;

@end

@implementation GifImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
//    _webView.userInteractionEnabled = NO;
    [self addSubview:_webView];
    _webView.opaque = NO;
    [_webView setBackgroundColor:[UIColor clearColor]];
    _webView.scalesPageToFit = YES;
    _webView.userInteractionEnabled = NO;
    [_webView sizeToFit];
    
    return self;
}



- (void)gif_setImageWithURL:(NSURL *)url {
   
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:url];
    
    [_webView loadRequest:req];
   
}

@end
