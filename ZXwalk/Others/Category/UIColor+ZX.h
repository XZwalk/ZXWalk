//
//  UIColor+ZX.h
//  ZXwalk
//
//  Created by 张祥 on 15/11/8.
//  Copyright © 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZX)
+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end
