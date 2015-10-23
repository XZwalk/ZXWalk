
//
//  RainLayer.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/11.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "RainLayer.h"

@implementation RainLayer

- (id)init
{
    self = [self initWithImageName:@"CUSSenderRain.png"];
    
    return self;
}

-(CAEmitterCell*)createSubLayerContainer{
    return nil;
}
-(CAEmitterCell *)createSubLayer:(UIImage *)image{
    CAEmitterCell *cellLayer = [CAEmitterCell emitterCell];
    
    cellLayer.birthRate		= 30.0;
    cellLayer.lifetime		= 5;
    
    cellLayer.velocity		= -1000;				// falling down slowly
    cellLayer.velocityRange = 0;
    
    cellLayer.scale = 0.2;
    cellLayer.contents		= (id)[image CGImage];
    
    cellLayer.color			= [[UIColor grayColor] CGColor];
    cellLayer.emissionLongitude = 0.1 * M_PI;
    cellLayer.spin = 0.1 * M_PI;
    return cellLayer;
}
@end
