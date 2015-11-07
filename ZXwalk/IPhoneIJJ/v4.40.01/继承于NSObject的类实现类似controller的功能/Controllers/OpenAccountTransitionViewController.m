//
//  OpenAccountTransitionViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/11/7.
//  Copyright © 2015年 张祥. All rights reserved.
//

#import "OpenAccountTransitionViewController.h"
#import "OpenAccountTransitionPrompt.h"


@interface OpenAccountTransitionViewController ()
@property (nonatomic, strong)OpenAccountTransitionPrompt *openAccPrompt;

@end

@implementation OpenAccountTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnAction:(UIButton *)sender {
    
    
    if ([self.openAccPrompt checkIsLoginBefore]) {
        [self.openAccPrompt loginAction];
    } else {
        [self.openAccPrompt show];
    }
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (OpenAccountTransitionPrompt *)openAccPrompt {
    if (!_openAccPrompt) {
        self.openAccPrompt = [[OpenAccountTransitionPrompt alloc] init];
        
    }
    return _openAccPrompt;
}


@end
