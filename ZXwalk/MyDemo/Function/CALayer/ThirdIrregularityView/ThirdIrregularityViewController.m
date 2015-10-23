//
//  ViewController.m
//  IrregularImages
//
//  Created by OranWu on 13-4-10.
//  Copyright (c) 2013年 Oran Wu. All rights reserved.
//

#import "ThirdIrregularityViewController.h"
#import "IrregularView.h"
#import "UIBezierPath+BasicShapes.h"


@interface ThirdIrregularityViewController (){
    IrregularView *userShape;
    IrregularView *martiniShape;
    IrregularView *starShape;
    IrregularView *beakerShape;
}

@end

@implementation ThirdIrregularityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"2013011.jpg"]];
    //    + (UIBezierPath *)userShape:(CGRect)originalFrame;
    //    + (UIBezierPath *)martiniShape:(CGRect)originalFrame;
    //    + (UIBezierPath *)beakerShape:(CGRect)originalFrame;
    //    + (UIBezierPath *)starShape:(CGRect)originalFrame;

    
    martiniShape = [[IrregularView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    martiniShape.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:martiniShape];
    [martiniShape setMaskWithPath:[UIBezierPath martiniShape:martiniShape.frame]];
    martiniShape.center = CGPointMake(80, 180);
    [martiniShape onGesture:^(UIGestureRecognizer *tapGestrue) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"喝一杯麽！"
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    userShape = [[IrregularView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    userShape.backgroundColor = [UIColor blackColor];
    [self.view addSubview:userShape];
    [userShape setMaskWithPath:[UIBezierPath userShape:userShape.frame]];
    userShape.center = CGPointMake(160+80, 180);
    [userShape onGesture:^(UIGestureRecognizer *tapGestrue) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"不要碰我！"
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];

    starShape = [[IrregularView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    starShape.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:starShape];
    [starShape setMaskWithPath:[UIBezierPath starShape:starShape.frame]];
    starShape.center = CGPointMake(80, 160+80+100);
    [starShape onGesture:^(UIGestureRecognizer *tapGestrue) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"粉色星星！"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
    }];
    
    beakerShape = [[IrregularView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    beakerShape.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:beakerShape];
    [beakerShape setMaskWithPath:[UIBezierPath beakerShape:beakerShape.frame]];
    beakerShape.center = CGPointMake(160+80, 160+80+100);
    [beakerShape onGesture:^(UIGestureRecognizer *tapGestrue) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"绝命毒师！"
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    [self.view addGestureRecognizer:tap];
    
    
    
}

- (void)tapImage:(UITapGestureRecognizer *)tapGestrue{
    float size = 40;
    CGPoint tapPoint = [tapGestrue locationInView:tapGestrue.view];
    IrregularView *tapIndicator = [[IrregularView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    CALayer *handLayer = [CALayer layer];
    handLayer.contents = (id)[[UIImage imageNamed:@"hand.png"] CGImage];
    handLayer.frame = CGRectMake(0, 0, size, size);
    [tapIndicator.layer addSublayer:handLayer];
    [self.view addSubview:tapIndicator];
    tapIndicator.center = CGPointMake(tapPoint.x, tapPoint.y);
    [UIView animateWithDuration:0.8 animations:^{
        tapIndicator.alpha = 0;
    }completion:^(BOOL finished) {
        [tapIndicator removeFromSuperview];
    }];
}



- (void)addIntroduceLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight - 40, kScreenWidth - 20, 30)];
    label.text = @"Helps:IrregularView, Resources:IrregularView";
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
}


@end
