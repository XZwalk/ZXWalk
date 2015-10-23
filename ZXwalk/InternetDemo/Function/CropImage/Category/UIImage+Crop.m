//
//  UIImage+Crop.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (Crop)

- (UIImage *)imageByCroppingWithStyle:(XYCropImageStyle)style
{
    CGRect rect;
    switch (style) {
        case XYCropImageStyleLeft:
            rect = CGRectMake(0, 0, self.size.width/2, self.size.height);
            break;
        case XYCropImageStyleCenter:
            rect = CGRectMake(self.size.width/4, 0, self.size.width/2, self.size.height);
            break;
        case XYCropImageStyleRight:
            rect = CGRectMake(self.size.width/2, 0, self.size.width/2, self.size.height);
            break;
        case XYCropImageStyleLeftOneOfThird:
            rect = CGRectMake(0, 0, self.size.width/3, self.size.height);
            break;
        case XYCropImageStyleCenterOneOfThird:
            rect = CGRectMake(self.size.width/3, 0, self.size.width/3, self.size.height);
            break;
        case XYCropImageStyleRightOneOfThird:
            rect = CGRectMake(self.size.width/3*2, 0, self.size.width/3, self.size.height);
            break;
        case XYCropImageStyleLeftQuarter:
            rect = CGRectMake(0, 0, self.size.width/4, self.size.height);
            break;
        case XYCropImageStyleCenterLeftQuarter:
            rect = CGRectMake(self.size.width/4, 0, self.size.width/4, self.size.height);
            break;
        case XYCropImageStyleCenterRightQuarter:
            rect = CGRectMake(self.size.width/4*2, 0, self.size.width/4, self.size.height);
            break;
        case XYCropImageStyleRightQuarter:
            rect = CGRectMake(self.size.width/4*3, 0, self.size.width/4, self.size.height);
            break;
            
            //后面还可以根据自己的需求增加剪切范围
            
        default:
            break;
    }
    
    
    /*
     CGImage和CGImageRef这两个应当是用来重绘图形的类，它们在应用时是按照图像的像素矩阵来绘制图片的，它们可以用来处理bitmap。
     */
    
    
    //CGImageRef与UIImage的互转
    
    //UIImage -> CGImageRef, UIImage有一个  - (CGImageRef)CGImage; 方法
    //这是getter方法, 直接点也可以
    CGImageRef imageRef = self.CGImage;
    
    //根据rect重绘图片
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, rect);
    
    
    
    
    //CGImageRef -> UIImage
    UIImage *cropImage = [UIImage imageWithCGImage:imagePartRef];
    
    
    //ARC does not manage C-types, of which CGImage may be considered. You must release the ref manually when you are finished with CGImageRelease(image);
    //在arc模式下 不是什么东西 都可以释放 例如 C-types的对象 都需要手动来进行释放
   //CGImageRef属于c类型, imagePartRef属于c类型的对象, 不属于OC的管理范畴, 在ARC下无法自动释放, 需要手动释放, 不然会发生内存泄露
    
    CGImageRelease(imagePartRef);
    return cropImage;
}

@end
