//
//  HeartViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "HeartViewController.h"

@interface HeartViewController ()

@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) CAEmitterLayer *heartsEmitter;


@end

@implementation HeartViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *fireBut = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 300, 30)];
    fireBut.backgroundColor = [UIColor blueColor];
    [fireBut setTitle:@"启动" forState:UIControlStateNormal];
    [self.view addSubview:fireBut];
    [fireBut  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    // Configure the particle emitter
    self.heartsEmitter = [CAEmitterLayer layer];
    self.heartsEmitter.emitterPosition = CGPointMake(_likeButton.frame.origin.x + _likeButton.frame.size.width/2.0,
                                                     _likeButton.frame.origin.y + _likeButton.frame.size.height/2.0);
    self.heartsEmitter.emitterSize = _likeButton.bounds.size;
    
    // Spawn points for the hearts are within the area defined by the button frame
    self.heartsEmitter.emitterMode = kCAEmitterLayerVolume;
    self.heartsEmitter.emitterShape = kCAEmitterLayerRectangle;
    self.heartsEmitter.renderMode = kCAEmitterLayerAdditive;
    
    // Configure the emitter cell
    CAEmitterCell *heart = [CAEmitterCell emitterCell];
    heart.name = @"heart";
    
    heart.emissionLongitude = M_PI/2.0; // up
    heart.emissionRange = 0.55 * M_PI;  // in a wide spread
    heart.birthRate		= 0.0;			// emitter is deactivated for now
    heart.lifetime		= 10.0;			// hearts vanish after 10 seconds
    
    heart.velocity		= -120;			// particles get fired up fast
    heart.velocityRange = 60;			// with some variation
    heart.yAcceleration = 20;			// but fall eventually
    
    heart.contents		= (id) [[UIImage imageNamed:@"DazHeart"] CGImage];
    heart.color			= [[UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.5] CGColor];
    heart.redRange		= 0.3;			// some variation in the color
    heart.blueRange		= 0.3;
    heart.alphaSpeed	= -0.5 / heart.lifetime;  // fade over the lifetime
    
    heart.scale			= 0.15;			// let them start small
    heart.scaleSpeed	= 0.5;			// but then 'explode' in size
    heart.spinRange		= 2.0 * M_PI;	// and send them spinning from -180 to +180 deg/s
    
    // Add everything to our backing layer
    self.heartsEmitter.emitterCells = [NSArray arrayWithObject:heart];
    [self.view.layer addSublayer:_heartsEmitter];
}


//此API已被苹果启用
//- (void) viewWillUnload
//{
//    [super viewWillUnload];
//    [self.heartsEmitter removeFromSuperlayer];
//    self.heartsEmitter = nil;
//}


#pragma mark - 让粒子彻底消失的方法, 不会产生延迟
//当屏幕将要消失的时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.heartsEmitter removeFromSuperlayer];
    self.heartsEmitter = nil;
    
}




- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}


#pragma mark - 按钮方法


- (void)touchAction:(UIButton *)sender {
    // Fires up some hearts to rain on the view
    
    //设置基本动画
    CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.heart.birthRate"];
    heartsBurst.fromValue		= [NSNumber numberWithFloat:150.0];
    heartsBurst.toValue			= [NSNumber numberWithFloat:  0.0];
    heartsBurst.duration		= 5.0;
    heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //添加动画
    [self.heartsEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
}



@end
