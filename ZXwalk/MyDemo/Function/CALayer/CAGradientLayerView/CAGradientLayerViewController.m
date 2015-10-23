//
//  CAGradientLayerViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "CAGradientLayerViewController.h"
#import "GCD.h"


@interface CAGradientLayerViewController ()
@property (nonatomic, strong) GCDTimer  *timer;
@property (nonatomic, strong) CAGradientLayer *colorLayer;

@end

@implementation CAGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //CAGradientLayer 是 CALayer 的子类，专门处理渐变色层级结构，它既可以将 CAShapeLayer 当做 mask 蒙版用于自身，又可以独立的使用透明色与其他颜色组合实现色差动画。它可以实现 png 图片所无法做到的动态色差蒙版效果，提高应用效率的同时并增强用户交互体验，是 CoreAnimation 中使用较少但却效果拔群的一个类。
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:aView];
    
    
    
    //CAGradientLayer可以方便的处理颜色渐变。
    
    // 创建一个gradientLayer
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    //设置颜色渐变的范围
    gradientLayer.frame = aView.bounds;
    //渐变颜色的数组
    [gradientLayer setColors:[NSArray arrayWithObjects:
                              (id)[[UIColor redColor] CGColor],
                              (id)[[UIColor yellowColor] CGColor],
                              (id)[UIColor blueColor], nil]];
    
    //locations并不是表示颜色值所在位置, 更不是视图的frame的坐标, 它表示的是颜色在Layer坐标系相对位置处要开始进行渐变颜色了.
    //iOS中Layer的坐标系统:是一个以(0, 0)为起点, 宽高都为1的正方形
    
    //渐变颜色的区间分布
    [gradientLayer setLocations:@[@0.25 ,@0.5 ,@0.75]];
    //映射locations中第一个位置，用单位向量表示，比如（0，0）表示从左上角开始变化。默认值是(0.5,0.0)。
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    //映射locations中最后一个位置，用单位向量表示，比如（1，1）表示到右下角变化结束。默认值是(0.5,1.0)。
    [gradientLayer setEndPoint:CGPointMake(1, 0)];
    
    
    //将gradientLayer添加进图层
    [aView.layer addSublayer:gradientLayer];
    
    
    
    
    //添加渐变动画的视图
    [self addGradientLayerAnimation];
    
    //添加使用的第三方的介绍
    [self addIntroduceLabel];

}


- (void)addGradientLayerAnimation {
    self.colorLayer = [CAGradientLayer layer];
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //这也是一种初始化frame的代码, 以前没用过
    //colorLayer.frame	= (CGRect){CGPointZero, CGSizeMake(200, 200)};
    
    //设置渐变色块的范围
    self.colorLayer.frame = CGRectMake(100, 350, 200, 200);

    //加上这句代码的话色块就会处于屏幕的中心, 也就是上面设置的frame的原点(x, y)失效
    //colorLayer.position = self.view.center;
    
    //将colorLayer添加进图层
    [self.view.layer addSublayer:self.colorLayer];
    
    // 颜色分配
    self.colorLayer.colors = @[(__bridge id)[UIColor cyanColor].CGColor,
                          (__bridge id)[UIColor orangeColor].CGColor,
                          (__bridge id)[UIColor magentaColor].CGColor];
    
    // 起始点
    self.colorLayer.startPoint = CGPointMake(0, 0);
    
    // 结束点
    self.colorLayer.endPoint   = CGPointMake(1, 0);
    
    
    
    
    UIButton *changeDirectionBut = [[UIButton alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.colorLayer.frame) + 30, 150, 30)];
    [changeDirectionBut setTitle:@"渐变色分界线" forState:UIControlStateNormal];
    changeDirectionBut.backgroundColor = [UIColor blueColor];
    [self.view addSubview:changeDirectionBut];
    [changeDirectionBut addTarget:self action:@selector(setChangeType:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //有待查询
    _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [_timer event:^{
        
        static CGFloat test = - 0.1f;
        
        if (test >= 1.1)
        {
            test = - 0.1f;
            [CATransaction setDisableActions:YES];
            //渐变颜色的区间分布
            self.colorLayer.locations  = @[@(test), @(test + 0.05), @(test + 0.1)];
        }
        else
        {
            [CATransaction setDisableActions:NO];
            //渐变颜色的区间分布
            self.colorLayer.locations  = @[@(test), @(test + 0.05), @(test + 0.1)];
        }
        
        test += 0.1f;
        
    } timeInterval:NSEC_PER_SEC];
    [_timer start];
}


#pragma mark - 点击button的处理事件

//因为我们给button设置的有标题, 因此可以根据标题的内容来更改button的相关参数, 而不用再用bool或其他的记录它是第几次点击

- (void)setChangeType:(UIButton *)sender {
    
    
    
    if ([sender.titleLabel.text isEqualToString:@"渐变色分界线"]) {
        //这样更改button的标题是无用的, 因为button的titleLabel属性是只读的, 只可以用来取值
        //@property(nonatomic,readonly,retain) UILabel *titleLabel;
        //sender.titleLabel.text = @"fdaw";
        
        //销毁计时器(其实不销毁也没关系, 只是更改了计时器的参数而已)
        [_timer destroy];
        
        [sender setTitle:@"非渐变色分界线" forState:UIControlStateNormal];
        
        _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
        [_timer event:^{
            
            static CGFloat test = - 0.1f;
            
            if (test >= 1.1)
            {
                test = - 0.1f;
                [CATransaction setDisableActions:NO];
                //渐变颜色的区间分布
                self.colorLayer.locations  = @[@(test), @(test + 0.01), @(test + 0.011)];
            }
            else
            {
                [CATransaction setDisableActions:NO];
                //渐变颜色的区间分布
                self.colorLayer.locations  = @[@(test), @(test + 0.01), @(test + 0.011)];
            }
            
            test += 0.1f;
            
        } timeInterval:NSEC_PER_SEC];
        //启动计时器
        [_timer start];
        
    } else{
        
        
        [_timer destroy];

        
        [sender setTitle:@"渐变色分界线" forState:UIControlStateNormal];

        
        _timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
        [_timer event:^{
            
            static CGFloat test = - 0.1f;
            
            if (test >= 1.1)
            {
                test = - 0.1f;
                [CATransaction setDisableActions:YES];
                self.colorLayer.locations  = @[@(test), @(test + 0.05), @(test + 0.1)];
            }
            else
            {
                [CATransaction setDisableActions:NO];
                self.colorLayer.locations  = @[@(test), @(test + 0.05), @(test + 0.1)];
            }
            
            test += 0.1f;
            
        } timeInterval:NSEC_PER_SEC];
        [_timer start];
    }
    
}


- (void)addIntroduceLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 40, kScreenWidth - 20, 30)];
    label.text = @"渐变动画 -> Helps:GCD";
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}


@end
