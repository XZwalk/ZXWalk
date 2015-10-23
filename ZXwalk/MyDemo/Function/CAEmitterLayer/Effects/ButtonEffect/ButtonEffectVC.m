//
//  ButtonEffectViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ButtonEffectVC.h"
#import "CustomButton.h"

@interface ButtonEffectVC ()

@end

@implementation ButtonEffectVC

- (void)viewDidLoad
{
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CustomButton *button = [[CustomButton alloc] initWithFrame:CGRectMake(100, 100, 75, 30)];
    button.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:button];
    
    //添加使用第三方的介绍
    [self addIntroduceLabel];
    
}




- (void)addIntroduceLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 100, kScreenWidth - 20, 90)];
    label.text = @"Resources:CAEmitterLayer/ButtonEffect";
    label.numberOfLines = 0;
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}





@end
