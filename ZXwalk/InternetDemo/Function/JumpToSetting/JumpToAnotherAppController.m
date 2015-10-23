//
//  JumpToAnotherAppController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "JumpToAnotherAppController.h"
#import "TabBarViewController.h"

@interface JumpToAnotherAppController ()




@end

@implementation JumpToAnotherAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //更改导航栏左侧返回按钮, 回去的时候让tabBar作为window的根视图控制器
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backToFirstPage)];

    /*                                 程序跳转
     
    在实际开发中，往往要推荐自己其他应用和推荐自己的收费软件，那么我们就需要在程序中直接连接到app store的相应页面。
    实际上的做法很简单，使用的还是UIApplication类的OpenURL方法：
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"程序的相应连接"]];
     
    */
    
    
    
    //在Safari浏览器中输入  xiangzi://?name=xianzgi&phone=1818888888, 即可跳转到本程序
    

    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *jumpSetBut = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpSetBut.frame = CGRectMake(100, 150, 150, 30);
    [jumpSetBut setTitle:@"跳到系统设置界面" forState:UIControlStateNormal];
    [jumpSetBut addTarget:self action:@selector(jumpSetButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpSetBut];
    jumpSetBut.backgroundColor = [UIColor blueColor];
    
    
    UIButton *jumpSafariBut = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpSafariBut.frame = CGRectMake(100, CGRectGetMaxY(jumpSetBut.frame) + 30, 150, 30);
    [jumpSafariBut setTitle:@"跳到Safari界面" forState:UIControlStateNormal];
    [jumpSafariBut addTarget:self action:@selector(jumpSafariButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpSafariBut];
    jumpSafariBut.backgroundColor = [UIColor blueColor];
    
    
    UIButton *jumpMailBut = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpMailBut.frame = CGRectMake(100, CGRectGetMaxY(jumpSafariBut.frame) + 30, 150, 30);
    [jumpMailBut setTitle:@"跳到E-Mail界面" forState:UIControlStateNormal];
    [jumpMailBut addTarget:self action:@selector(jumpMailButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpMailBut];
    jumpMailBut.backgroundColor = [UIColor blueColor];

    
    
    
    UIButton *jumpPhoneBut = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpPhoneBut.frame = CGRectMake(100, CGRectGetMaxY(jumpMailBut.frame) + 30, 150, 30);
    [jumpPhoneBut setTitle:@"跳到Phone界面" forState:UIControlStateNormal];
    [jumpPhoneBut addTarget:self action:@selector(jumpPhoneButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpPhoneBut];
    jumpPhoneBut.backgroundColor = [UIColor blueColor];

    
    
    
    UIButton *jumpSMSBut = [UIButton buttonWithType:UIButtonTypeCustom];
    jumpSMSBut.frame = CGRectMake(100, CGRectGetMaxY(jumpPhoneBut.frame) + 30, 150, 30);
    [jumpSMSBut setTitle:@"跳到SMS界面" forState:UIControlStateNormal];
    [jumpSMSBut addTarget:self action:@selector(jumpSMSButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpSMSBut];
    jumpSMSBut.backgroundColor = [UIColor blueColor];

    
    
    
    
  }


- (void)backToFirstPage{
    [self.navigationController popToRootViewControllerAnimated:YES];
    TabBarViewController *tabVC = [TabBarViewController new];
    self.view.window.rootViewController = tabVC;
    
}





//跳到设置界面
- (void)jumpSetButAction{
    //下面这段代码要在iOS 8以上的系统使用。一般做智能家居app的，需要到设置界面连接wifi，但是苹果没有提供这样的接口。所以可以退而求其次，跳到系统的设置界面。
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}


//跳到Safari浏览器
- (void)jumpSafariButAction{
    //http://www.hzlzh.com
    NSURL *url = [NSURL URLWithString:@"http://www.hzlzh.com"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

//跳到e-Mail浏览器
- (void)jumpMailButAction{
    NSURL *url = [NSURL URLWithString:@"mailto://admin@hzlzh.com"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] canOpenURL:url];
    }
}


//调用phone可以传递号码，调用SMS只能设定号码，不能初始化SMS内容。


//跳到电话浏览器
- (void)jumpPhoneButAction{
    NSURL *url = [NSURL URLWithString:@"tel://8008808888"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] canOpenURL:url];
    }
}

//跳到短信浏览器
- (void)jumpSMSButAction{
    NSURL *url = [NSURL URLWithString:@"sms://800888"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] canOpenURL:url];
    }
}




@end
