//
//  GoldLayer.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "GoldLayer.h"

@implementation GoldLayer

- (id)init
{
    self = [self initWithImageName:@"CUSSenderGold.png"];
    
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
    //    cellLayer.spinRange		= 0.25 * M_PI;		// slow spin
    cellLayer.scale = 0.35;
    cellLayer.contents		= (id)[image CGImage];
    
    cellLayer.color			= [[UIColor whiteColor] CGColor];
    return cellLayer;
}
@end
