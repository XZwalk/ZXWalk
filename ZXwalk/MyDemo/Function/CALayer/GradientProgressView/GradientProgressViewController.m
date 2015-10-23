//
//  ViewController.m
//  GradientProgressView
//
//  Created by Nick Jensen on 11/22/13.
//  Copyright (c) 2013 Nick Jensen. All rights reserved.
//

#import "GradientProgressViewController.h"
#import "GradientProgressView.h"

@implementation GradientProgressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置进度条的frame
    CGRect frame = CGRectMake(0, 200.0f, CGRectGetWidth([[self view] bounds]), 1.0f);
    progressView = [[GradientProgressView alloc] initWithFrame:frame];
    
    UIView *view = [self view];
    [view setBackgroundColor:[UIColor blackColor]];
    [view addSubview:progressView];
    
    
    
    //添加使用第三方的介绍
    [self addIntroduceLabel];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // Starts the moving gradient effect
    //执行动画效果
    [progressView startAnimating];
    
    // Continuously updates the progress value using random values
    //执行假的进程
    [self simulateProgress];
}

- (void)simulateProgress {
    
    //延时时间
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    //在延时多久之后在主线程执行以下代码
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //进程的增量
        CGFloat increment = (arc4random() % 5) / 10.0f + 0.1;
        //改变进程的值
        CGFloat progress  = [progressView progress] + increment;
        //给进程赋值
        [progressView setProgress:progress];
        if (progress < 1.0) {
            //如果进程值小于1, 就执行假的进程
            [self simulateProgress];
        } else {
            //可以在进度结束的时候将动画停掉, 或者将进度条移除
            [progressView stopAnimating];
        }
        
        
        //使用帮助: 不管是什么进度, 可以在进度结束的时候将progress置为1, 即可结束进度
        
    });
}



//状态栏的样式
//Light content, for use on dark backgrounds
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}







- (void)addIntroduceLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 40, kScreenWidth - 20, 30)];
    label.text = @"Helps:GradientProgressView";
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}











@end
