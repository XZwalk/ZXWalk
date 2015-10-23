//
//  XZSandBoxViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "XZSandBoxViewController.h"

@interface XZSandBoxViewController ()

@end

@implementation XZSandBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //沙盒根目录
    NSString *directory = NSHomeDirectory();
    NSLog(@"*******沙盒根路径********\n%@\n\n\n", directory);
    
    
    //获取Documents路径
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPaths objectAtIndex:0];
    NSLog(@"*******Documents路径********\n%@\n\n\n", documentsPath);
    
    
    //获取Library路径
    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = [libraryPaths objectAtIndex:0];
    NSLog(@"********Library路径*******\n%@\n\n\n", libraryPath);
    
    //获取Caches路径
    NSArray *cachespaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachespath = [cachespaths objectAtIndex:0];
    NSLog(@"*******Caches路径********\n%@\n\n\n", cachespath);
    
    
    //获取Preferences路径
    NSString *preferencesPath = [libraryPath stringByAppendingPathComponent:@"Preferences"];
    NSLog(@"*******Preferences路径********\n%@\n\n\n", preferencesPath);
    
    
    
    NSString *tmp = NSTemporaryDirectory();
    NSLog(@"********临时文件路径*******\n%@\n\n\n", tmp);
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height)];
    label.text = @"1. 每一个APP都有一个存储空间，就是沙盒。\n2. APP之间不能相互通信。\n3. 沙盒根目录结构：Documents、Library、temp。\n\n\n简述一下Documents、Library、tmp的区别：\n\n1. Documents：用于存储用户数据，iTunes备份和恢复的时候会包括此目录，所以，苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下。\n2. Library：包含两个子目录：Caches 和 Preferences。Caches用来存放用户需要缓存的文件。\nPreferences是APP的偏好设置，可以通过NSUserDefaults来读取和设置。\n3. tmp： 用于存放的临时文件，这个可以放一些当APP退出后不再需要的文件。";
    [self.view addSubview:label];
    label.numberOfLines = 0;
    
    
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
