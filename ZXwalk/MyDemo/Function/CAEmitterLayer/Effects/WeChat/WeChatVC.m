//
//  WeChatViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "WeChatVC.h"
#import "WeChatDetailVC.h"


@interface WeChatVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, copy) NSArray *dataClasses;
@property (nonatomic, copy) NSArray *dataImages;
@property (nonatomic, copy) NSArray *titleNames;

@end

@implementation WeChatVC

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"CUSSender";
        self.dataClasses = @[@"StarLayer", @"BirthdayLayer", @"KissLayer", @"GoldLayer", @"SnowLayer", @"RainLayer", @"FlowerLayer"];
        
        self.dataImages = @[@"CUSSenderWeixinBG.jpg", @"CUSSenderWeixinBG.jpg", @"CUSSenderWeixinBG.jpg", @"CUSSenderWeixinBG.jpg", @"CUSSenderSnowBG.jpg", @"CUSSenderRainBG.jpg", @"CUSSenderFlowerBG.jpg"];
        
        self.titleNames = @[@"I miss you", @"Happy birthday", @"Kiss", @"Gold", @"Snow", @"Rain", @"Flower"];
        
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UITableView *talbeView = [[UITableView alloc]init];
    talbeView.dataSource = self;
    talbeView.delegate = self;
    talbeView.frame = self.view.bounds;
    [self.view addSubview:talbeView];
    
    
    
    //添加使用第三方的介绍
    [self addIntroduceLabel];
    
    
    
  }


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataImages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CUS_CELL";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
  
    cell.textLabel.text = self.titleNames[indexPath.row];
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeChatDetailVC *vc = [[WeChatDetailVC alloc] init];
    vc.layerClass = self.dataClasses[indexPath.row];
    vc.imageName = self.dataImages[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}


- (void)addIntroduceLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 100, kScreenWidth - 20, 90)];
    label.text = @"Resources:WeChat";
    label.numberOfLines = 0;
    label.textColor = [UIColor blueColor];
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}




@end