//
//  PurchaseViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/11/8.
//  Copyright © 2015年 张祥. All rights reserved.
//

#import "PurchaseViewController.h"
#import "PurchaseExtendBusiness.h"

@interface PurchaseViewController ()
@property (nonatomic, strong)PurchaseExtendBusiness *extendBusiness;

@end

@implementation PurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSDictionary *DataDic = @{@"BuyAgainAndAddBankCard" : @"1", @"RiskAssess" : @"1"};
    
    [self.view addSubview:self.extendBusiness.chooseListView];
    
    self.extendBusiness.showButtonRule = DataDic;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //视图的尺寸设置在viewWillAppear中
    self.extendBusiness.chooseListView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
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




#pragma mark - view kind of property setter and getter


- (PurchaseExtendBusiness *)extendBusiness {
    if (!_extendBusiness) {
        self.extendBusiness = [[PurchaseExtendBusiness alloc] init];
    }
    return _extendBusiness;
}



@end
