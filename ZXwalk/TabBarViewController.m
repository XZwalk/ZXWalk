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
    
    NSArray *controllersNames = @[@"IJJViewController"];
    
    NSArray *titles = @[@"爱基金"];
    
    NSArray *images = @[@"tabbar_mainframe"];
    
    NSMutableArray *controllers = [@[] mutableCopy];
    
    for (int i = 0; i < controllersNames.count; i++)
    {
        ZXViewController *rootVC = [[NSClassFromString(controllersNames[i]) alloc] init];
        ZXNavigationController *naVC = [[ZXNavigationController alloc] initWithRootViewController:rootVC];
        rootVC.title = titles[i];
        rootVC.tabBarItem.title = titles[i];
        rootVC.tabBarItem.image = [UIImage imageNamed:images[i]];
        [controllers addObject:naVC];
    }
    
    
    self.viewControllers = controllers;
    
    
}
@end
