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


@interface OpenAccountTransitionViewController ()

@end

@implementation OpenAccountTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    TransitionView *view = [[[NSBundle mainBundle] loadNibNamed:@"TransitionView" owner:self options:nil] objectAtIndex:0];
    
    
    
    view.titleLabel.text = @"现在加入爱基金";
    view.contentLabel1.text = @"立享新人神秘礼包的辅导辅导辅导辅导辅导辅导辅导辅导辅导辅导费大幅度";
    view.contentLabel2.text = @"买基金手续费最低2折";
    view.contentLabel3.text = @"高手一对一投资解答";
    
    CGSize s = [view sizeThatFits:CGSizeMake(200, 300)];
    
    view.frame = CGRectMake(0, 0, s.width, s.height);
    
    STModal *modal = [STModal  modalWithContentView:view];
    
    
    modal.hideWhenTouchOutside = YES;
    
    [modal show:YES];
    
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
