//
//  MyDemoViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/9.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "MyDemoViewController.h"
#import "SpreadCollectionController.h"
#import "SecondLevelTabViewController.h"
#import "CALayerViewController.h"
#import "CAEmitterLayerVC.h"
#import "WeChatVC.h"
#import "ZXPaoMaViewController.h"




@interface MyDemoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *mutDictionary;
@property (nonatomic, copy) NSArray *introduceAry;

@end

@implementation MyDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.500 green:0.000 blue:0.500 alpha:0.560];
    
    
    NSArray *tabViewAry = @[@"SpreadCollectionView(集合视图的展开)", @"SecondLevelTableView(二级tableView)", @"CALayer(各种牛逼特效)", @"CAEmitterLayer(粒子发生器)", @"WeChat(微信掉落表情)", @"ZXPaoMa(跑马灯)"];
    self.introduceAry = @[@"Helps:SDWebImage, UIViewAdditions", @"Helps:AFNetworking", @"", @"", @"", @""];
    
    [self.mutDictionary setValue:tabViewAry forKey:@"0"];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}

#pragma mark - 懒加载
- (NSMutableDictionary *)mutDictionary{
    if (!_mutDictionary) {
        _mutDictionary = [@{} mutableCopy];
    }
    return _mutDictionary;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    }
    return _tableView;
}





#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.mutDictionary[[NSString stringWithFormat:@"%ld", section]] count];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.mutDictionary allKeys].count;
    
}


//tabView的区头字体没有更改字体颜色的属性, 要想更改字体颜色, 就需要走返回区头视图的方法, 将字体放到label上更改
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"表视图和集合视图的二级视图";
    }
    return nil;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    NSString *content = self.mutDictionary[[NSString stringWithFormat:@"%ld", indexPath.section]][indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSMutableAttributedString *str = [self setTwoColorToLabel:content];
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




#pragma mark - 选中的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //加上此句, 选中返回的时候, 此行变为非选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *value = self.mutDictionary[[NSString stringWithFormat:@"%ld", indexPath.section]][indexPath.row];
    
    if ([value isEqualToString:@"SpreadCollectionView(集合视图的展开)"]) {
        SpreadCollectionController *vc = [SpreadCollectionController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"SecondLevelTableView(二级tableView)"]) {
        SecondLevelTabViewController *vc = [SecondLevelTabViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"CALayer(各种牛逼特效)"]) {
        CALayerViewController *vc = [CALayerViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"CAEmitterLayer(粒子发生器)"]) {
        CAEmitterLayerVC *vc = [CAEmitterLayerVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"WeChat(微信掉落表情)"]) {
        WeChatVC *vc = [WeChatVC new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([value isEqualToString:@"ZXPaoMa(跑马灯)"]) {
        ZXPaoMaViewController *vc = [ZXPaoMaViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
    
    
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}


@end
