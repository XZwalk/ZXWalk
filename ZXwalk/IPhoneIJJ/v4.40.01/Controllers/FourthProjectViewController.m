//
//  FourthProjectViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/10/25.
//  Copyright © 2015年 张祥. All rights reserved.
//

#import "FourthProjectViewController.h"
#import "FourthProjectCell.h"
#import "TestFrameViewController.h"
#import "OpenAccountTransitionViewController.h"
#import "PurchaseViewController.h"
#import "StandardViewController.h"


@interface FourthProjectViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, copy)NSArray *dataAry;


@end

@implementation FourthProjectViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //这两句代码不加,集合视图绝逼显示不出来
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FourthProjectCell" bundle:nil] forCellWithReuseIdentifier:@"item"];
    
    //这里为了方便直接设置的数据,正常情况下,这里的数据是在其他类里面解析出来的
    self.dataAry = @[@"AutoLayout", @"view在控制器中frame的初始化", @"将一个业务封装成一个类", @"规范的视图控制器的写法"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //集合视图没有系统的cell, 所以没办法直接用, 要进行自定义
    FourthProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.contentLabel.text = self.dataAry[indexPath.row];
    
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        OpenAccountTransitionViewController *openVC = [OpenAccountTransitionViewController new];
        [self.navigationController pushViewController:openVC animated:YES];
    } else if (indexPath.row == 1) {
        
        [self.navigationController pushViewController:[TestFrameViewController new] animated:YES];
        
    } else if (indexPath.row == 2) {
        
        [self.navigationController pushViewController:[PurchaseViewController new] animated:YES];
    } else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[[StandardViewController alloc] initWithNibName:@"StandardViewController" bundle:nil] animated:YES];
    }
    
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.frame.size.width - 40) / 3, 100);
}

//列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - setter and getter

- (NSArray *)dataAry {
    if (!_dataAry) {
        self.dataAry = @[];
    }
    return _dataAry;
}



@end
