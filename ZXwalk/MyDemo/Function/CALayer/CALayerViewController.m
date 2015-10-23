//
//  CALayerViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/10.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "CALayerViewController.h"
#import "MyIrregularityViewController.h"
#import "ThirdIrregularityViewController.h"
#import "CAGradientLayerViewController.h"
#import "GradientProgressViewController.h"
#import "PictureChangeVC.h"



@interface CALayerViewController ()

@end

@implementation CALayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *IrregularityViewBut1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 300, 30)];
    IrregularityViewBut1.backgroundColor = [UIColor blueColor];
    [IrregularityViewBut1 setTitle:@"不规则视图(自己写的)" forState:UIControlStateNormal];
    [self.view addSubview:IrregularityViewBut1];
    IrregularityViewBut1.tag = 1000;
    [IrregularityViewBut1  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *IrregularityViewBut2 = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(IrregularityViewBut1.frame) + 30, 300, 30)];
    IrregularityViewBut2.backgroundColor = [UIColor blueColor];
    [IrregularityViewBut2 setTitle:@"不规则视图(第三方)" forState:UIControlStateNormal];
    [self.view addSubview:IrregularityViewBut2];
    IrregularityViewBut2.tag = 1001;
    [IrregularityViewBut2  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    UIButton *gradientLayerBut = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(IrregularityViewBut2.frame) + 30, 300, 30)];
    gradientLayerBut.backgroundColor = [UIColor blueColor];
    [gradientLayerBut setTitle:@"渐变色以及渐变色动画" forState:UIControlStateNormal];
    [self.view addSubview:gradientLayerBut];
    gradientLayerBut.tag = 1002;
    [gradientLayerBut  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    


    
    UIButton *gradientProgressBut = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(gradientLayerBut.frame) + 30, 300, 30)];
    gradientProgressBut.backgroundColor = [UIColor blueColor];
    [gradientProgressBut setTitle:@"渐变色进度条" forState:UIControlStateNormal];
    [self.view addSubview:gradientProgressBut];
    gradientProgressBut.tag = 1003;
    [gradientProgressBut  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    UIButton *pictureBut = [[UIButton alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(gradientProgressBut.frame) + 30, 300, 30)];
    pictureBut.backgroundColor = [UIColor blueColor];
    [pictureBut setTitle:@"图片的渐变透明效果" forState:UIControlStateNormal];
    [self.view addSubview:pictureBut];
    pictureBut.tag = 1004;
    [pictureBut  addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
    


}


- (void)touchAction:(UIButton *)sender {
    
    
    switch (sender.tag) {
        case 1000:
        {
            MyIrregularityViewController *vc = [MyIrregularityViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
            case 1001:
        {
            ThirdIrregularityViewController *vc = [ThirdIrregularityViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
            case 1002:
        {
            CAGradientLayerViewController *vc = [CAGradientLayerViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            case 1003:
        {
            GradientProgressViewController *vc = [GradientProgressViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
            
            case 1004:
        {
            PictureChangeVC *vc = [PictureChangeVC  new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            
        default:
            break;
    }
    
    
    
}






@end
