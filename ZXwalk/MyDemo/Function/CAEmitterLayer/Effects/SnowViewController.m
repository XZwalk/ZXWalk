//
//  SnowViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SnowViewController.h"

@interface SnowViewController ()
@property (nonatomic, strong) CAEmitterLayer *snowEmitter;

@end

@implementation SnowViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Configure the particle emitter to the top edge of the screen
    // 创建粒子的容器layer(将layer理解为容器较易理解, layer的翻译是图层的意思)
    self.snowEmitter = [CAEmitterLayer layer];
    
    // 粒子发射位置
    self.snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, -30);
    
    // 发射源的尺寸大小
    self.snowEmitter.emitterSize = CGSizeMake(self.view.bounds.size.width * 2.0, 0.0);;
    
    // Spawn points for the flakes are within on the outline of the line
    // 发射模式
    self.snowEmitter.emitterMode = kCAEmitterLayerOutline;
    
    //发射源的形状
    self.snowEmitter.emitterShape = kCAEmitterLayerLine;
    
    // Configure the snowflake emitter cell
    // 创建发射的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    
    // 出生率:每秒发射的粒子数量，一个好的火焰或者瀑布你最少需要几百个粒子，所以我们设置为200
    snowflake.birthRate	= 0;
    //snowflake.birthRate = 1.0;
    
    //生命时间:一个粒子几秒后消失
    snowflake.lifetime	= 120.0;
    
    //生命时间变化范围:你可以用这个东西使粒子的lifetime产生少许变化。粒子系统会随机在这个区间中取一个lifetime出来(lifetime – lifetimeRange, lifetime + lifetimeRange) 在我们的程序中，粒子会存活2.5~3.5秒
    //snowflake.lifetimeRange = 3;
    
    // 速度:粒子每秒移动的像素数.
    snowflake.velocity	= -10;				// falling down slowly
    
    // 速度范围:速度变化范围，和lifetimeRange相似
    snowflake.velocityRange = 10;
    
    // 粒子y方向的加速度分量, x和z方向也可以设置
    snowflake.yAcceleration = 2;
    
    // 发射角度:这是一个cell发射的角度范围(弧度制).M_PI_2(pi/2)是45度(也就是说生成范围会+-45度)
    snowflake.emissionRange = 0.5 * M_PI;		// some variation in angle
    
    // 旋转:每个粒子的旋转速率。我们设置0.5来给粒子一个漂亮的旋转
    //snowflake.spin = 0.2;
    
    // 旋转范围:随机取出一个值作为粒子的旋转速率
    snowflake.spinRange = 0.25 * M_PI;		// slow spin
    
    // 变大速度:每秒修改粒子大小的百分, 我们可以设置让粒子随着时间推移变大, 不设置一直是正常值
    snowflake.scaleSpeed = 0.05;
    
    
    // 内容:用于cell的内容，一般是一个CGImage. 我们把它赋值给粒子图像。
    snowflake.contents = (id) [[UIImage imageNamed:@"DazFlake"] CGImage];
    
    // 颜色:粒子内容的颜色
    snowflake.color	= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    
    // Make the flakes seem inset in the background
    // 阴影的透明度:默认是0, 超过[0, 1]不识别
    self.snowEmitter.shadowOpacity = 1.0;
    
    // 创建阴影的半径, 默认是3.0
    self.snowEmitter.shadowRadius = 0.0;
    
    // 阴影的偏移量, 默认是(0, -3)
    self.snowEmitter.shadowOffset = CGSizeMake(0.0, 1.0);
    
    // 粒子边缘的颜色
    self.snowEmitter.shadowColor = [[UIColor whiteColor] CGColor];
    
    // Add everything to our backing layer below the UIContol defined in the storyboard
    
    
    // 名称:粒子的名字, 你可以给你的cell取一个名字，用来在之后的时间里查找和修改它的属性。
    snowflake.name = @"snow";
    
    
    // 添加粒子
    self.snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
    
    // 将粒子Layer添加进图层中
    [self.view.layer insertSublayer:self.snowEmitter atIndex:0];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}



//添加一个方法来作为粒子发生（发射）器的开关, 通过改变粒子的出生率
-(void)setIsEmitting:(BOOL)isEmitting
{
    //这里使用setValue:forKeyPath:(KVC)方法来改动一个cell, 是因为我们早先将cell的名字添加到了emitter中。我们使用”emitterCells.snow.birthRate”做keypath是因为birthRate是emitterCells数组中一个叫做叫fire的cells的属性。
    //turn on/off the emitting of particles
    [self.snowEmitter setValue:[NSNumber numberWithInt:isEmitting ? 1 : 0]
               forKeyPath:@"emitterCells.snow.birthRate"];
}


//视图加载的时候让动画出现
- (void)viewWillAppear:(BOOL)animated {
    [self setIsEmitting:YES];

}

//触摸屏幕的时候让动画停止
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self setIsEmitting:NO];
}


//视图将要消失的时候让动画停止
//因为每个粒子都是有生命周期的, 所以即使让动画停止, 已经发射的粒子也不会消息, 返回的时候海华丝会产生延迟消失的现象, 按下面的方法写则不会产生延迟
//- (void)viewWillDisappear:(BOOL)animated {
//    
//    [self setIsEmitting:NO];
//}



#pragma mark - 让粒子彻底消失的方法, 不会产生延迟
//当屏幕将要消失的时候
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.snowEmitter removeFromSuperlayer];
    self.snowEmitter = nil;
    
}

@end