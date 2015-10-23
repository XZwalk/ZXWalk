//
//  Model.h
//  SharedTwoTableVew
//
//  Created by laouhn on 15/8/6.
//  Copyright (c) 2015年 吕桂峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
@property (nonatomic, copy)NSString * category; //参数配置的类别
@property (nonatomic, retain)NSArray * parametersVo; // 一个类别的详细信息
@end
