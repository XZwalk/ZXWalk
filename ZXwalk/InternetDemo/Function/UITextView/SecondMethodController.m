//
//  SecondMethodController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SecondMethodController.h"
#import "XZPlaceholderTextView.h"

@interface SecondMethodController ()

@property (nonatomic, strong) XZPlaceholderTextView *textView;


@end



@implementation SecondMethodController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.textView = [[XZPlaceholderTextView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth , 200)];
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.placeholder = @"关注微信公众号iOS开发：iOSDevTip";
    [self.view addSubview:self.textView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeBackKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(self.textView.frame) + 30, 100, 30)];
    [but setTitle:@"返回上一页" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(backTofirstPage) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor = [UIColor blueColor];
    [self.view addSubview:but];
    
}


#pragma mark - 返回按钮
- (void)backTofirstPage{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 结束编辑(收回键盘)
- (void)takeBackKeyboard{
    [self.textView endEditing:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
