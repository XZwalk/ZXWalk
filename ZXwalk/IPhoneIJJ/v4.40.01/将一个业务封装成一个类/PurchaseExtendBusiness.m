//
//  PurchaseExtendServer.m
//  IphoneIJiJin
//
//  Created by ttyy on 15/10/20.
//
//

#import "PurchaseExtendBusiness.h"
#import "JSONKit.h"
#import "ExtentBusinessViewCell.h"

#define buyAgain @"快速再买一笔"
#define addBankCard @"添加其他银行卡"



@interface PurchaseExtendBusiness ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSMutableArray *recordInfoAry;

@end

@implementation PurchaseExtendBusiness

- (id)init {
    self = [super init];
    if (self) {
        self.chooseListView.delegate = self;
        self.chooseListView.dataSource = self;
    }
    return self;
}




- (void)setShowButtonRule:(NSDictionary *)showButtonRule {
    _showButtonRule = showButtonRule;
    //拿到数据之后去加载视图
    [self handleData];
    
    //加载之后刷新视图
    [self.chooseListView reloadData];

}

#pragma mark - private api

//处理数据
- (void)handleData {
    
    if ([self.showButtonRule[@"BuyAgainAndAddBankCard"] isEqualToString:@"1"]) {
        
        
        NSArray *buyAry = @[buyAgain];
        [self.recordInfoAry addObject:buyAry];
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"获得更高支付限额"];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x5d5d5d] range:NSMakeRange(2, 2)];
        
        NSArray *addCardAry = @[addBankCard, str];

        [self.recordInfoAry addObject:addCardAry];
        }
    
    if ([self.showButtonRule[@"RiskAssess"] isEqualToString:@"1"]) {
        
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"我要购买流程更简畅"];
        
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:0x5d5d5d] range:NSMakeRange(str.length - 3, 3)];
        
        NSArray *riskAry = @[@"完成风险测评", str];
        [self.recordInfoAry addObject:riskAry];
     
    }
}




//跳转到另一个页面
- (void)gotoPurchasePage {
    NSString *recordStr = [self.showButtonRule JSONString];
    NSString *fundCode = [self.showButtonRule objectForKey:@"FundCode"];
    
    //取到当前视图控制器
    
    //转换为正确的视图控制器(购买成功页面)
    
    NSString *urlString = nil;
    
    //取到跳到购买成功的页面的前一个页面的类型
    
    //如果是收益宝购买
    
    
    //此处不能用IFNavigator  openURL那套,这样会冲掉回调的popUrl,所以此处跳转需携带之前的popUrl
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExtentBusinessViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    cell.layer.borderColor = [UIColor darkGrayColor].CGColor;
    cell.layer.borderWidth = .3;
    
    //取出数据(小数组)
    if (self.recordInfoAry.count > 0) {
        NSArray *infoAry = self.recordInfoAry[indexPath.row];
        cell.leftLabel.text = infoAry[0];
        if (infoAry.count == 2) {
            cell.rightLabel.attributedText = infoAry[1];
        }
    }
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recordInfoAry.count;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    NSString *infoStr = [self.recordInfoAry[indexPath.row] objectAtIndex:0];
    
    if ([infoStr isEqualToString:buyAgain]) {
        
        
        
        [self gotoPurchasePage];
    } else if ([infoStr isEqualToString:addBankCard]) {
        
        
    } else  {
        
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 50);
}


//分区缩进
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


#pragma mark - view kind of property setter and getter
- (NSMutableArray *)recordInfoAry {
    if (!_recordInfoAry) {
        self.recordInfoAry = [@[] mutableCopy];
    }
    return _recordInfoAry;
}

- (UICollectionView *)chooseListView {
    if (!_chooseListView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.chooseListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        self.chooseListView.scrollEnabled = NO;
        
        self.chooseListView.backgroundColor = [UIColor whiteColor];
        [self.chooseListView registerNib:[UINib nibWithNibName:@"ExtentBusinessViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    }
    return _chooseListView;
}

@end
