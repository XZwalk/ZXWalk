//
//  UIImage+Crop.h
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import <UIKit/UIKit.h>

//最近遇到这样的需求：从服务器获取到一张照片，只需要显示他的左半部分，或者中间部分等等。也就是截取UIImage指定大小区域。

//我的解决方案是对UIImage进行扩展。通过CGImageRef和CGImage完成截取，调用的方法是：CGImageCreateWithImageInRect。扩展类叫UIImage+Crop

//Crop: 剪切


typedef NS_ENUM(NSInteger, XYCropImageStyle){
    XYCropImageStyleRight               =0,      // 右半部分
    XYCropImageStyleCenter              =1,      // 中间部分
    XYCropImageStyleLeft                =2,      // 左半部分
    XYCropImageStyleRightOneOfThird     =3,      // 右侧三分之一部分
    XYCropImageStyleCenterOneOfThird    =4,      // 中间三分之一部分
    XYCropImageStyleLeftOneOfThird      =5,      // 左侧三分之一部分
    XYCropImageStyleRightQuarter        =6,      // 右侧四分之一部分
    XYCropImageStyleCenterRightQuarter  =7,      // 中间右侧四分之一部分
    XYCropImageStyleCenterLeftQuarter   =8,      // 中间左侧四分之一部分
    XYCropImageStyleLeftQuarter         =9,      // 左侧四分之一部分
};

@interface UIImage (Crop)
//根据要求(裁剪大小)返回一张图片
- (UIImage *)imageByCroppingWithStyle:(XYCropImageStyle)style;

@end
