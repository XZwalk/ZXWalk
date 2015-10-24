//
//  TabBarViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadSubControllers];
    
}



- (void)loadSubControllers{
    
    
    NSArray *controllersNames = @[@"DemoViewController",
                             @"MyDemoViewController",
                             @"ThirdPartViewController",
                             @"IJJViewController"];
    
    
    NSArray *titles = @[@"网上", @"MyApp", @"第三方", @"爱基金"];
    
    NSArray *images = @[@"tabbar_contacts", @"tabbar_me", @"tabbar_mainframe", @"tabbar_mainframe"];
    
    
    NSMutableArray *controllers = [@[] mutableCopy];
    
    for (int i = 0; i < 4; i++)
    {
        UIViewController *rootVC = [[NSClassFromString(controllersNames[i]) alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
        rootVC.title = titles[i];
        rootVC.tabBarItem.title = titles[i];
        rootVC.tabBarItem.image = [UIImage imageNamed:images[i]];
        [controllers addObject:naVC];
    }
    
    
    self.viewControllers = controllers;
    
    
}
@end
