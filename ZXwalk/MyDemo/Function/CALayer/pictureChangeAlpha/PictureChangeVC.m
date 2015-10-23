//
//  PictureChangeVC.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "PictureChangeVC.h"
#import "GCD.h"

@interface PictureChangeVC ()
@property (nonatomic, strong) GCDTimer   *timer;

@end

@implementation PictureChangeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    self.view.backgroundColor = [UIColor redColor];
    
    // 背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"test.jpg"];
    [self.view addSubview:imageView];
    
    UIView *yourGradientView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    // 渐变图层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = yourGradientView.bounds;
    
    // 设置颜色
    gradientLayer.colors = @[(id)[[UIColor clearColor] colorWithAlphaComponent:0.0f].CGColor,
                             (id)[[UIColor redColor] colorWithAlphaComponent:1.0f].CGColor];
    gradientLayer.locations = @[[NSNumber numberWithFloat:0.7f],
                                [NSNumber numberWithFloat:1.0f]];
    
    // 添加渐变图层
    [yourGradientView.layer addSublayer:gradientLayer];
    [self.view addSubview:yourGradientView];
    
    // 开始动画效果
    _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [_timer event:^{
        gradientLayer.locations = @[[NSNumber numberWithFloat:arc4random()%100/100.f],
                                    [NSNumber numberWithFloat:1.0f]];
        
        gradientLayer.colors = @[(id)[[UIColor clearColor] colorWithAlphaComponent:0.0f].CGColor,
                                 (id)[[UIColor colorWithRed:arc4random()%255/255.f
                                                      green:arc4random()%255/255.f
                                                       blue:arc4random()%255/255.f
                                                      alpha:1.0] colorWithAlphaComponent:1.0f].CGColor];
    } timeInterval:NSEC_PER_SEC];
    [_timer start];
    
    
    
    //添加使用第三方的介绍
    [self addIntroduceLabel];
    
    
    
    
}






- (void)addIntroduceLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 69, kScreenWidth - 20, 90)];
    label.text = @"Helps:GCD, Resources:test/test.jpg";
    label.numberOfLines = 0;
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}








@end