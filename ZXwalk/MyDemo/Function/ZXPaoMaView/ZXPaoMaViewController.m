//
//  ZXPaoMaVC.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "ZXPaoMaViewController.h"
#import "ZXPaoMaView.h"


@interface ZXPaoMaViewController ()

@end

@implementation ZXPaoMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString* text = @"两块钱,你买不了吃亏,两块钱,你买不了上当,真正的物有所值,拿啥啥便宜,买啥啥不贵,都两块,买啥都两块,全场卖两块,随便挑,随便选,都两块！";
    
    ZXPaoMaView* paomav = [[ZXPaoMaView alloc] initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width-20, 44) title:text];
    [self.view addSubview:paomav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
