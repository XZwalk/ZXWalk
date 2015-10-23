//
//  XZtextViewViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "FirstMethodController.h"
#import "SecondMethodController.h"

@interface FirstMethodController ()<UITextViewDelegate>

@end

@implementation FirstMethodController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    
    /*
     
     1. 把UITextView的text当placeholder使用。
     2. 在开始编辑的代理方法里清除placeholder。
     3.在结束编辑的代理方法里在设置placeholder。
     
    */
    
    
    
    UITextView *textViewPlaceholder = [[UITextView alloc] initWithFrame:CGRectMake(20, 70, kScreenWidth - 40, 100)];
    textViewPlaceholder.backgroundColor = [UIColor whiteColor];
    textViewPlaceholder.text = @"关注微信公众号iOS开发：iOSDevTip";
    textViewPlaceholder.textColor = [UIColor grayColor];
    textViewPlaceholder.delegate = self;
    [self.view addSubview:textViewPlaceholder];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.view addGestureRecognizer:tapGesture];
    
    
    
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(textViewPlaceholder.frame) + 30, 100, 30)];
    [but setTitle:@"第二种方法" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(secondMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    but.backgroundColor = [UIColor orangeColor];
    
   }

- (void)secondMethod{
    SecondMethodController *secondVC = [SecondMethodController new];
    [self presentViewController:secondVC animated:YES completion:nil];
    
}

//轻击手势触发方法, 结束编辑, 即是收回键盘
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}


#pragma mark - UITextViewDelegate
//当textView开始编辑时触发
- (void)textViewDidBeginEditing:(UITextView *)textView {
    //如果textView的text是这个字符串的时候
    if ([textView.text isEqualToString:@"关注微信公众号iOS开发：iOSDevTip"]) {
        //字符串置空
        textView.text = @"";
        //改变字体颜色
        textView.textColor = [UIColor blackColor];
    }
}

//当textView结束编辑时触发
- (void)textViewDidEndEditing:(UITextView *)textView {
    //结束编辑的时候, 而且字体的长度为零的时候, 再次将这个字符串出现, 并改变颜色
    if (textView.text.length<1) {
        textView.text = @"关注微信公众号iOS开发：iOSDevTip";
        textView.textColor = [UIColor grayColor];
    }
}


@end
