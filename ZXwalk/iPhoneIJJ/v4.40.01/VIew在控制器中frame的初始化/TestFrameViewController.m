//
//  TestFrameViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/10/25.
//  Copyright © 2015年 张祥. All rights reserved.
//

#import "TestFrameViewController.h"

@interface TestFrameViewController ()

@end

@implementation TestFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //这里view的frame还是xib的尺寸
    
//    <UIView: 0x7be38eb0; frame = (0 0; 320 568); autoresize = W+H; layer = <CALayer: 0x7be38e80>>
    

    
}



- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    
    
    //这里view的frame还是xib得尺寸
    
//    <UIView: 0x7be38eb0; frame = (0 0; 320 568); autoresize = W+H; layer = <CALayer: 0x7be38e80>>

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //这里view的尺寸才是设备的真实尺寸
    
    //在storyboard上和代码上都不会出现这样的问题
    
//    <UIView: 0x7be38eb0; frame = (0 0; 320 480); autoresize = W+H; layer = <CALayer: 0x7be38e80>>

    
    
    //这里又不能设置控件的frame, 不然会闪一下
    
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
