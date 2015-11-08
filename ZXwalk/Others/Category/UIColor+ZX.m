//
//  UIColor+ZX.m
//  ZXwalk
//
//  Created by 张祥 on 15/11/8.
//  Copyright © 2015年 张祥. All rights reserved.
//

#import "UIColor+ZX.h"

@implementation UIColor (ZX)

+ (UIColor *)colorWithHex:(long)hexColor {
    return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity {
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

@end
