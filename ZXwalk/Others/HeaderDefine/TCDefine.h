//
//  TCDefine.h
//  TransactionSDK
//
//  Created by zmj on 14-6-6.
//  Copyright (c) 2014年 HexinFinance. All rights reserved.
//



#ifndef TransactionSDK_TCDefine_h
#define TransactionSDK_TCDefine_h


#if defined(DEBUG) || defined(_DEBUG) || defined(__DEBUG)
#define TC_IOS_DEBUG
#endif


#ifdef TC_IOS_DEBUG


#define DLog(fmt, ...) \
NSLog(@"%@(%d)\n%s: " fmt, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
__PRETTY_FUNCTION__,## __VA_ARGS__)

#else

#define DLog(...);


#endif


#define RGB_A(r, g, b, a) ([UIColor colorWithRed:(r)/255.0f \
green:(g)/255.0f \
blue:(b)/255.0f \
alpha:(a)/255.0f])

#define RGB(r, g, b) RGB_A(r, g, b, 255)

#define ColorWithHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)/255.0) green:((float)((rgbValue & 0xFF00) >> 8)/255.0) blue:((float)((rgbValue & 0xFF))/255.0) alpha:1.0]

#define ColorWithHexRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)/255.0) green:((float)((rgbValue & 0xFF00) >> 8)/255.0) blue:((float)((rgbValue & 0xFF))/255.0) alpha:(a)]



// 无cache加载png图片
#define IMG_NO_CACHE_2x(str) ( \
[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(str@"@2x") ofType:@"png"]] \
)

//-------------------------------------------------------------------
//是否为空
#define IS_OBJ_AVAILABLE(obj)       (nil != (obj) && [NSNull null] != (NSNull *)(obj))
#define Empty_Collection(param)     (nil == param || param.count < 1)
#define Empty_Str(param)            (nil == param || param.length < 1)

//-------------------------------------------------------------------
//内存警告
#define kSHOULD_DEAL_MEM_WARNING    (self.isViewLoaded && nil == self.view.window)

//-------------------------------------------------------------------
//生成单例
#define SINGLETON_GCD(classname)                        \
\
__strong static classname * shared##classname = nil;\
+ (classname *)sharedInstance {                      \
\
static dispatch_once_t pred;                        \
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}

//-------------------------------------------------------------------
//屏幕尺寸
#define kSCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define kSCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define KIPHONE5_SIZE   (([[UIScreen mainScreen] bounds].size.height>480)?YES:NO)

//-------------------------------------------------------------------
//字体设置
#define FONTSIZE1 16
#define FONTSIZE2 14
#define FONTSIZE3 15
#define BOLDFONT(fontsize) [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontsize]
#define FONT(fontsize) [UIFont systemFontOfSize:fontsize]

//--------------------------------------------------------------------
//常用正则表达式
#define kEMAIL_REGEX     @"[A-Z0-9a-z.]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define kPHONE_REGEX     @"1[0-9]{10}$"
#define kPWD_REGEX       @"[A-Z0-9a-z.]{6,12}?"


//--------------------------------------------------------------------
//打印坐标相关信息
#define DLogRect(rect)     DLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define DLogSize(size)     DLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define DLogPoint(point)   DLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)


//--------------------------------------------------------------------
//真机与模拟器
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif

//--------------------------------------------------------------------
//字典简写
#define OBJC_STRINGIFY(x) @#x
#define encodeObject(x) [aCoder encodeObject:x forKey:OBJC_STRINGIFY(x)]
#define decodeObject(x) x = [aDecoder decodeObjectForKey:OBJC_STRINGIFY(x)]

#define setNoNilObject(x) [data setNoNilObject:x forKey:OBJC_STRINGIFY(x)]
#define setNoNilIntObject(x) [data setNoNilObject:[NSNumber numberWithInteger:x] forKey:OBJC_STRINGIFY(x)]

#define DicSetNoNilObject(dic,x) [dic setNoNilObject:x forKey:OBJC_STRINGIFY(x)]


#define KeyNoNull(dic,x)     [dic valueForKeyExceptNull:OBJC_STRINGIFY(x)]
#define KeyNoNullAndNil(dic,x)  [dic valueForKeyExceptNullAndNil:OBJC_STRINGIFY(x)]
#define KeyIntNoNull(dic,x)  [[dic valueForKeyExceptNull:OBJC_STRINGIFY(x)] intValue]

//--------------------------------------------------------------------
//G－C－D
#define GlobalQueue  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define MainQueue    dispatch_get_main_queue()

#define BACKGROUND(block) dispatch_async(GlobalQueue,block)
#define MAIN(block)       dispatch_async(MainQueue,block)


///---------------------------------------------------------------------------
/// @name Calling Delegates
///---------------------------------------------------------------------------
#define JC_CALL_DELEGATE(_delegate, _selector) \
do { \
id _theDelegate = _delegate; \
if(_theDelegate != nil && [_theDelegate respondsToSelector:_selector]) { \
[_theDelegate performSelector:_selector]; \
} \
} while(0);

#define JC_CALL_DELEGATE_WITH_ARG(_delegate, _selector, _argument) \
do { \
id _theDelegate = _delegate; \
if(_theDelegate != nil && [_theDelegate respondsToSelector:_selector]) { \
[_theDelegate performSelector:_selector withObject:_argument]; \
} \
} while(0);

#define JC_CALL_DELEGATE_WITH_ARGS(_delegate, _selector, _arg1, _arg2) \
do { \
id _theDelegate = _delegate; \
if(_theDelegate != nil && [_theDelegate respondsToSelector:_selector]) { \
[_theDelegate performSelector:_selector withObject:_arg1 withObject:_arg2]; \
} \
} while(0);

///---------------------------------------------------------------------------
/// @name UIDevice Helpers
///---------------------------------------------------------------------------
#define IS_IPAD             (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)



//--------------------------------------------------------------------
// 数据刷新方式
typedef enum
{
    kTCRefreshPages = 0,
    kTCLoadNextPage = 1,
    
} TCLoadDataType;


#endif
