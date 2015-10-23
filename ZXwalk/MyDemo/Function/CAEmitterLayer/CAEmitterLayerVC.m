//
//  CAEmitterLayerViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "CAEmitterLayerVC.h"
#import "SnowViewController.h"
#import "HeartViewController.h"
#import "FireViewController.h"
#import "TouchEffectVC.h"
#import "FireworksVC.h"
#import "ButtonEffectVC.h"

@interface CAEmitterLayerVC ()

@end

@implementation CAEmitterLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     
     有时候，项目中需要我们写出下雪或者下雨等无规则随机运动一类的效果，我们可以通过设计某种算法来实现，通过产生无数的视图控件来达到我们的需求，虽然也能实现，但也十分的耗费性能导致卡顿，此时，用 CAEmitterLayer 就可以完美的解决这个问题，并简化我们的设计。
     
     */
    
    
    
    
    
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *snowBut = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 300, 30)];
    snowBut.backgroundColor = [UIColor blueColor];
    [snowBut setTitle:@"下雪" forState:UIControlStateNormal];
    [self.view addSubview:snowBut];
    snowBut.tag = 1000;
    [snowBut  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *heartBut = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(snowBut.frame) + 30, 300, 30)];
    heartBut.backgroundColor = [UIColor blueColor];
    [heartBut setTitle:@"爱心" forState:UIControlStateNormal];
    [self.view addSubview:heartBut];
    heartBut.tag = 1001;
    [heartBut  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton *fireBut = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(heartBut.frame) + 30, 300, 30)];
    fireBut.backgroundColor = [UIColor blueColor];
    [fireBut setTitle:@"火" forState:UIControlStateNormal];
    [self.view addSubview:fireBut];
    fireBut.tag = 1002;
    [fireBut  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
    UIButton *touchBut = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(fireBut.frame) + 30, 300, 30)];
    touchBut.backgroundColor = [UIColor blueColor];
    [touchBut setTitle:@"触摸效果" forState:UIControlStateNormal];
    [self.view addSubview:touchBut];
    touchBut.tag = 1003;
    [touchBut  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    

    UIButton *fireworksBut = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(touchBut.frame) + 30, 300, 30)];
    fireworksBut.backgroundColor = [UIColor blueColor];
    [fireworksBut setTitle:@"烟火" forState:UIControlStateNormal];
    [self.view addSubview:fireworksBut];
    fireworksBut.tag = 1004;
    [fireworksBut  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *buttonEffect = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(fireworksBut.frame) + 30, 300, 30)];
    buttonEffect.backgroundColor = [UIColor blueColor];
    [buttonEffect setTitle:@"给按钮周围添加粒子动画效果" forState:UIControlStateNormal];
    [self.view addSubview:buttonEffect];
    buttonEffect.tag = 1005;
    [buttonEffect  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //添加使用第三方的介绍
    [self addIntroduceLabel];
    
    
}


//记得每种情况后面要加上break, 不然之后的case也会走
- (void)touchAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1000:
        {
            SnowViewController *vc = [SnowViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
            
        case 1001:
        {
            HeartViewController *vc = [HeartViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1002:
        {
            FireViewController *vc = [FireViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1003:
        {
            TouchEffectVC *vc = [TouchEffectVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1004:
        {
            FireworksVC *vc = [FireworksVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1005:
        {
            ButtonEffectVC *vc = [ButtonEffectVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
    
}




- (void)addIntroduceLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 100, kScreenWidth - 20, 90)];
    label.text = @"Frameworks:(QuartzCore未加入也没出错), UIKit, Foundation, CoreGraphics, Resources:CAEmitterLayer";
    label.numberOfLines = 0;
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}







@end
