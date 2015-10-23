//
//  DetailViewController.h
//  ZXwalk
//
//  Created by 张祥 on 15/8/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FallLayer.h"


@interface WeChatDetailVC : UIViewController

@property (nonatomic, copy) NSString *layerClass;

@property (nonatomic, copy) NSString *imageName;

@property(nonatomic,strong)FallLayer *rootLayer;


@end
