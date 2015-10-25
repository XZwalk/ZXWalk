//
//  OpenAccountTransitionViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/10/24.
//  Copyright © 2015年 张祥. All rights reserved.
//

#import "OpenAccountTransitionViewController.h"
#import "TransitionView.h"
#import "STModal.h"
#import "WrongAutoLayoutView.h"

@interface OpenAccountTransitionViewController ()

@property (nonatomic, strong) UIButton *rightBut;

@property (nonatomic, strong) UIButton *wrongBut;

@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation OpenAccountTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    self.rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBut setTitle:@"正确的做法" forState:UIControlStateNormal];
    [self.view addSubview:self.rightBut];
    [self.rightBut addTarget:self action:@selector(rightButAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.wrongBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wrongBut setTitle:@"错误的做法" forState:UIControlStateNormal];
    [self.view addSubview:self.wrongBut];
    
    [self.wrongBut addTarget:self action:@selector(wrongButAction) forControlEvents:UIControlEventTouchUpInside];
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.text = @"这样之所以错误的原因是\n该label距离上端163,距离下端302,这些距离都是死的,也就是说不管在哪个view上,不管view的frame怎样,这些尺寸都是不会变的,只有当view的高度大于163+302 = 465的时候label才会显示出来,所以造成label上下显示不全";
    self.infoLabel.numberOfLines = 0;
    self.infoLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.infoLabel];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.rightBut.frame = CGRectMake(100, 100, 100, 40);
    
    self.wrongBut.frame = CGRectMake(100, 200, 100, 40);
    
    self.infoLabel.frame = CGRectMake(10, 250, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - 250);
    
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
    
}


#pragma mark - event response

- (void)rightButAction {
    
    
    TransitionView *view = [[[NSBundle mainBundle] loadNibNamed:@"TransitionView" owner:self options:nil] objectAtIndex:0];
    
    
    
    view.titleLabel.text = @"现在加入爱基金";
    view.contentLabel1.text = @"立享新人神秘礼包的辅导辅导辅导辅导辅导辅导辅导辅导辅导辅导费大幅度";
    view.contentLabel2.text = @"买基金手续费最低2折";
    view.contentLabel3.text = @"高手一对一投资解答";
    
    
    view.frame = CGRectMake(0, 0, 300, 350);
    
    STModal *modal = [STModal  modalWithContentView:view];
    
    
    modal.hideWhenTouchOutside = YES;
    
    [modal show:YES];
    
    
    
    
    
    
    
}

- (void)wrongButAction {
    
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"WrongAutoLayoutView" owner:self options:nil];
    
    WrongAutoLayoutView *wrongView = [nibViews objectAtIndex:0];
    
    wrongView.frame = CGRectMake(50, 100, 300, 468);
    
    [self.view addSubview:wrongView];
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
