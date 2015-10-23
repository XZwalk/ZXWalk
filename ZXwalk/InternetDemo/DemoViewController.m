//
//  ViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "DemoViewController.h"
#import "UIWebViewViewController.h"
#import "UIDataDetectorTypesViewController.h"
#import "NSTimerViewController.h"
#import "XZSandBoxViewController.h"
#import "XZCropImageViewController.h"
#import "XZImageViewController.h"
#import "XZAlbumViewController.h"
#import "FirstMethodController.h"
#import "JumpToAnotherAppController.h"



@interface DemoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mutArray;
@property (nonatomic, copy) NSArray *introduceAry;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mutArray = [NSMutableArray arrayWithObjects:@"UITextView(textView占位符)",@"Album(保存相片到系统相册或指定相册)", @"UIImage(压缩图片)", @"CropImage(合成和裁剪图片)",@"SandBox(沙盒路径)",@"System Setting(程序间相互跳转)", @"NSTimer(计时器)",@"UIDataDetectorTypes(检测电话, 邮箱等)",@"UIWebView(网页)", nil];
    
    self.introduceAry = @[@"", @"Helps:ALAssetsLibrary+CustomPhotoAlbum, Resources:test", @"", @"Resources:test", @"", @"", @"", @"", @""];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UITableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellUserSelect";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSMutableAttributedString *str = [self setTwoColorToLabel:self.mutArray[indexPath.row]];
    cell.textLabel.attributedText = str;
    
    cell.detailTextLabel.text = self.introduceAry[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor blueColor];
    return cell;
}


#pragma mark - 给label添加两种颜色字体
- (NSMutableAttributedString *)setTwoColorToLabel:(NSString *)str {
    NSArray *strAry = [str componentsSeparatedByString:@"("];
    if (strAry.count > 1) {
    NSMutableAttributedString *colorStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@(%@", strAry[0], strAry[1]]];
    [colorStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([strAry[0] length], [strAry[1] length] + 1)];
    return colorStr;
    }else{
        NSMutableAttributedString *colorStr = [[NSMutableAttributedString alloc] initWithString:str];
        return colorStr;
    }
}






#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //加上此句, 选中返回的时候, 此行变为非选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *value = self.mutArray[indexPath.row];
    if ([value isEqualToString:@"UIWebView(网页)"]) {
        UIWebViewViewController *vc = [[UIWebViewViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"UIDataDetectorTypes(检测电话, 邮箱等)"]){
        UIDataDetectorTypesViewController *vc = [[UIDataDetectorTypesViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"NSTimer(计时器)"]){
        NSTimerViewController *vc = [[NSTimerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"System Setting(程序间相互跳转)"]){
        
        JumpToAnotherAppController *vc = [[JumpToAnotherAppController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"SandBox(沙盒路径)"]){
        XZSandBoxViewController *vc = [[XZSandBoxViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"CropImage(合成和裁剪图片)"]){
        XZCropImageViewController *vc = [[XZCropImageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"UIImage(压缩图片)"]){
        XZImageViewController *vc = [[XZImageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"Album(保存相片到系统相册或指定相册)"]){
        XZAlbumViewController *vc = [[XZAlbumViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"UITextView(textView占位符)"]){
        FirstMethodController *vc = [[FirstMethodController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
    
    
    self.tabBarController.tabBar.hidden = YES;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


#pragma mark - 牛逼的方法
//页面被push出去之后, 再回来的时候不会走viewDidLoad:方法, 但是这个方法每次都走
- (void)viewWillAppear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = NO;
}




@end
