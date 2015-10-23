//
//  IrregularityViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "MyIrregularityViewController.h"
#import "GCD.h"


@interface MyIrregularityViewController ()

@end

@implementation MyIrregularityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //创建一个五边形
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    aView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:aView];
    
    //创建一个贝塞尔曲线
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    //给贝塞尔曲线设置起点
    [aPath moveToPoint:CGPointMake(100, 0)];
    //设置贝塞尔曲线的其他点(也就是贝塞尔曲线的直线路径)
    [aPath addLineToPoint:CGPointMake(200, 70)];
    [aPath addLineToPoint:CGPointMake(170, 200)];
    [aPath addLineToPoint:CGPointMake(30, 200)];
    [aPath addLineToPoint:CGPointMake(0, 70)];
    //让贝塞尔曲线回到起点, 也就是形成一个封闭的曲线
    [aPath closePath];
    
    
    CAShapeLayer *masklayerA = [CAShapeLayer layer];
    aView.layer.mask = masklayerA;
    masklayerA.path = [aPath CGPath];

    //CALayer的两个重要的subClass：CAGradientLayer和CAShapeLayer
    
    
    /*
     普通CALayer在被初始化时是需要给一个frame值的,这个frame值一般都与给定view的bounds值一致,它本身是有形状的,而且是矩形.
     
     CAShapeLayer在初始化时也需要给一个frame值,但是,它本身没有形状,它的形状来源于你给定的一个path,然后它去取CGPath值,它与CALayer有着很大的区别
     */
    
    
    
    /*                       CAShapeLayer有着几点很重要
     
     1. 它依附于一个给定的path,必须给与path,而且,即使path不完整也会自动首尾相接
     
     2. strokeStart以及strokeEnd代表着在这个path中所占用的百分比
     
     3. CAShapeLayer动画仅仅限于沿着边缘的动画效果,它实现不了填充效果
     
     */
    
    
    
    
    //创建一个心形
    UIView *bView = [[UIView alloc] initWithFrame:CGRectMake(100, 350, 200, 200)];
    bView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bView];
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    //设定贝塞尔曲线的起点
    [bPath moveToPoint:CGPointMake(100, 200)];
    //给贝塞尔曲线添加曲线路径
    [bPath addCurveToPoint:CGPointMake(190, 75) controlPoint1:CGPointMake(100, 150) controlPoint2:CGPointMake(175, 150)];
    [bPath addCurveToPoint:CGPointMake(100, 50) controlPoint1:CGPointMake(200, 0) controlPoint2:CGPointMake(100, 0)];
    [bPath addCurveToPoint:CGPointMake(10, 75) controlPoint1:CGPointMake(100, 0) controlPoint2:CGPointMake(0, 0)];
    [bPath addCurveToPoint:CGPointMake(100, 200) controlPoint1:CGPointMake(10, 150) controlPoint2:CGPointMake(100, 150)];
    [bPath closePath];
    CAShapeLayer *masklayerB = [CAShapeLayer layer];
    bView.layer.mask = masklayerB;
    masklayerB.path = [bPath CGPath];
    
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame         = bView.bounds;                // 与showView的frame一致
    layer.strokeColor   = [UIColor blueColor].CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
    layer.lineCap       = kCALineCapSquare;               // 边缘线的类型
    layer.path          = bPath.CGPath;                    // 从贝塞尔曲线获取到形状
    layer.lineWidth     = 4.0f;                           // 线条宽度
    layer.strokeStart   = 0.0f;
    layer.strokeEnd     = 0.1f;
     
     
     // 将layer添加进图层
     [bView.layer addSublayer:layer];
     
     // 3s后执行动画操作(直接赋值就能产生动画效果)
     [[GCDQueue mainQueue] execute:^{
     layer.speed       = 0.1;
     layer.strokeStart = 0.5;
     layer.strokeEnd   = 0.9f;
     layer.lineWidth   = 1.0f;
     } afterDelay:NSEC_PER_SEC * 3];
     
    
    //添加使用第三方的介绍
    [self addIntroduceLabel];
}



- (void)addIntroduceLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 40, kScreenWidth - 20, 30)];
    label.text = @"心形的边界动画 -> Helps:GCD";
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}



@end
