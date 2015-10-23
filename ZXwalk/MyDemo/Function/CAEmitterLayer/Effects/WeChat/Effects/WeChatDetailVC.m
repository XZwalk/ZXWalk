//
//  DetailViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "WeChatDetailVC.h"

@interface WeChatDetailVC ()

@end

@implementation WeChatDetailVC



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //得到不同的粒子layer
    self.rootLayer = [self createLayer];
    
    //因为我的下雨的那个的粒子是空, 所以如果这里给消失时间, 就会走消失方法, 就会给粒子的birthRate(出生率)赋值, 然后必崩
    //这里不加判断的话, 下雨那个会崩溃
    if (![self.layerClass isEqualToString:@"RainLayer"]) {
        
        //延期隐藏粒子的时间, 也就是在给定的时间后粒子消失
        self.rootLayer.delayHideTime = 1;
    }
    
    // 将粒子Layer添加进图层的layer中
    [self.view.layer addSublayer:self.rootLayer];
}




-(void)viewDidLoad{
    [super viewDidLoad];
    //加一个安全判断, 当图片存在的时候
    if ([self getBackgroundImageName]) {
        //创建聊天界面的背景图
        UIImage *image = [UIImage imageNamed:[self getBackgroundImageName]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self.view addSubview:imageView];
    }
}


//当页面将要消失的时候移除粒子
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //如果粒子layer存在
    if (self.rootLayer) {
        //则将粒子layer从图层的layer中移除
        [self.rootLayer removeFromSuperlayer];
    }
}








//调用此方法得到不同的layer参数(下雪, 下雨等)
-(FallLayer *)createLayer{
    return [[[NSClassFromString(self.layerClass) class] alloc]init];
}


//此方法返回当前详情页的背景图片
-(NSString *)getBackgroundImageName{
    return self.imageName;
}
@end



