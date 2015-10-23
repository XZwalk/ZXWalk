//
//  XZCropImageViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "XZCropImageViewController.h"
#import "UIImage+Crop.h"
#import "XZAutoSimplingShowView.h"

@interface XZCropImageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *mutArray;
@property (nonatomic, strong) XZAutoSimplingShowView *showView;
@property (nonatomic, assign) XYSimplingStyle style;
@end

@implementation XZCropImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    
    //将几个图片合成一张图片, 在合成的时候对图片进行裁剪
    
    
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    [mutableArray addObject:[UIImage imageNamed:@"test.jpg"]];
    [mutableArray addObject:[UIImage imageNamed:@"test2.jpg"]];
    [mutableArray addObject:[UIImage imageNamed:@"test3.jpg"]];
    [mutableArray addObject:[UIImage imageNamed:@"test4.jpg"]];
    self.mutArray = mutableArray;
    
    //    XYAutoSimplingShowView *showView = [[XYAutoSimplingShowView alloc] init];
    //    showView.frame = CGRectMake(0, 64, SCREEN.width, SCREEN.width/4*3);
    //    showView.backgroundColor = [UIColor orangeColor];
    //    showView.imageArray = mutableArray;
    //    [self.view addSubview:showView];
    //    self.showView = showView;
    //
    //    self.style = XYSimplingStyleOriginal;
    //    [self.showView autoSimplingViewWithStyle:self.style];
    //
    //    UIButton *button = [[UIButton alloc] init];
    //    button.frame = CGRectMake( 100, SCREEN.width/4*3 + 100, SCREEN.width - 200, 40);
    //    [button addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    //    [button setBackgroundColor:[UIColor orangeColor]];
    //    [button setTitle:@"Test" forState:UIControlStateNormal];
    //    [self.view addSubview:button];
    
    //    UIImage *image = [UIImage imageNamed:@"ganggang"];
    //    [image imageByCroppingWithStyle:XYCropImageStyleLeft];
    //    [image imageByCroppingWithStyle:XYCropImageStyleCenter];
    //    [image imageByCroppingWithStyle:XYCropImageStyleRight];
    //    [image imageByCroppingWithStyle:XYCropImageStyleLeftOneOfThird];
    //    [image imageByCroppingWithStyle:XYCropImageStyleCenterOneOfThird];
    //    [image imageByCroppingWithStyle:XYCropImageStyleRightOneOfThird];
    //    [image imageByCroppingWithStyle:XYCropImageStyleLeftQuarter];
    //    [image imageByCroppingWithStyle:XYCropImageStyleCenterLeftQuarter];
    //    [image imageByCroppingWithStyle:XYCropImageStyleCenterRightQuarter];
    //    [image imageByCroppingWithStyle:XYCropImageStyleRightQuarter];
    
    self.style = -1;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //UIImage *img = [UIImage imageNamed:@"some.png"];
    //NSData *dataObj = UIImageJPEGRepresentation(img, 1.0);
}

- (void)actionClick:(UIButton *)button
{
    self.style++;
    
    if (self.style > 6) {
        self.style = 0;
    }
    
    [self.showView autoSimplingViewWithStyle:self.style];
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CellUserSelect%d",(int)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = [UIColor blackColor];
    XZAutoSimplingShowView *showView = [[XZAutoSimplingShowView alloc] init];
    showView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth / 4 * 3);
    showView.backgroundColor = [UIColor orangeColor];
    showView.imageArray = self.mutArray;
    [cell.contentView addSubview:showView];
    self.style++;
    if (self.style > 6) {
        self.style = 0;
    }
    [showView autoSimplingViewWithStyle:self.style];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenWidth / 4 * 3 + 5.0;
}


@end
