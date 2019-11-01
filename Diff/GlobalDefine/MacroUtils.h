//
//  MacroUtils.h
//  Shopping
//
//  Created by Fengj on 15/10/27.
//  Copyright © 2015年 wanlink. All rights reserved.
//

#ifndef MacroUtils_h
#define MacroUtils_h

/* 设备型号 */

#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad

#define IS_IPHONE   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )

#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )

#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )

#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )960) < DBL_EPSILON )

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

/*尺寸宏*/

#define XRatio (SCREEN_WIDTH/375.0f)
#define YRatio (SCREEN_HEIGHT/667.0f)

#define StatusBar_HEIGHT (IPHONE_X?44:20)

#define NavigationBar_HEIGHT 44

#define NavigationBarIcon 20

#define TabBar_HEIGHT 49

#define TabBarIcon 30

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define FX(view)    view.frame.origin.x

#define FY(view)    view.frame.origin.y

#define FW(view)    view.frame.size.width

#define FH(view)    view.frame.size.height

#define SW(image)   image.size.width

#define SH(image)   image.size.height

/*打印宏*/


//直接替换NSLog
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

/*工具宏*/
#define UTF8Encode(string) [string dataUsingEncoding:NSUTF8StringEncoding]


/*block 防止循环引用*/
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif


/*系统宏*/

//获取版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


/*图片宏*/

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]


//前两种宏性能高，省内存
//第三个没有必要使用，因为我们可以使用Xcode的插件


/*颜色宏*/

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#define NOTIFY_POST(_notifyName)   [[NSNotificationCenter defaultCenter] postNotificationName:_notifyName object:nil];


/*其他宏*/

//字体定义
/*
 PingFangSC-Medium,
 PingFangSC-Semibold,
 PingFangSC-Light,
 PingFangSC-Ultralight,
 PingFangSC-Regular,
 PingFangSC-Thin
 */
#define FONTR(F) (SYSTEM_VERSION_LESS_THAN(@"9.0")?[UIFont systemFontOfSize:F]:[UIFont fontWithName:@"PingFangSC-Regular" size:F])
#define FONTM(F) (SYSTEM_VERSION_LESS_THAN(@"9.0")?[UIFont systemFontOfSize:F]:[UIFont fontWithName:@"PingFangSC-Medium" size:F])
#define FONTS(F) (SYSTEM_VERSION_LESS_THAN(@"9.0")?[UIFont systemFontOfSize:F]:[UIFont fontWithName:@"PingFangSC-Semibold" size:F])

#define FONTB(F) (SYSTEM_VERSION_LESS_THAN(@"9.0")?[UIFont boldSystemFontOfSize:F]:[UIFont fontWithName:@"PingFangSC-Semibold" size:F])

//程序的本地化,引用国际化的文件
#define STR(x, ...) NSLocalizedString(x, nil)

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define UD [NSUserDefaults standardUserDefaults]

//通知中心
#define NC [NSNotificationCenter defaultCenter]

//文本计算
#define TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#define STR_VALUE(string) (string==nil||[string isKindOfClass:[NSNull class]]||[[NSString stringWithFormat:@"%@", string] length]==0)?@"":string

#define WINDOW ([UIApplication sharedApplication].windows.firstObject)
#endif /* MacroUtils_h */

