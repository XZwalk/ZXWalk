//
//  SnowLayer.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "SnowLayer.h"

@implementation SnowLayer

- (id)init
{
    NSMutableArray *snowArray = [NSMutableArray array];
    for (int i = 1; i <= 13; i++) {
        [snowArray addObject:[NSString stringWithFormat:@"CUSSenderSnow%2i.png",i]];
    }
    self = [self initWithImageNameArray:snowArray];
    
    return self;
}

-(CAEmitterCell *)createSubLayer:(UIImage *)image{
    CAEmitterCell *cellLayer = [CAEmitterCell emitterCell];
    
    cellLayer.birthRate		= 5.0;
    cellLayer.lifetime		= 20;
    
    cellLayer.velocity		= -100;				// falling down slowly
    cellLayer.velocityRange = 0;
    cellLayer.yAcceleration = 2;
    cellLayer.emissionRange = 0.5 * M_PI;		// some variation in angle
    cellLayer.spinRange		= 0.5 * M_PI;		// slow spin
    cellLayer.scale = 0.2;
    cellLayer.contents		= (id)[image CGImage];
    
    //    cellLayer.color			= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];
    cellLayer.color			= [[UIColor whiteColor] CGColor];
    
    return cellLayer;
}
@end