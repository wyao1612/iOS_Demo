//
//  UtilsMacros.h
//  iOS_demo
//
//  Created by wyao on 2017/6/20.
//  Copyright © 2017年 wyao. All rights reserved.
//

//定义的是一些工具宏，比如获取屏幕宽高，系统版本，数据类型验证等；
#ifndef UtilsMacros_h
#define UtilsMacros_h

#define  MFApp_Secret    @"56180453e4dcc790f4bf0cd3b0d4d7f9"
#define  MFApp_key       @"56180453e"

/**
 日志打印
 */
//DEBUG 模式下打印日志,当前行
#ifdef DEBUG
# define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define NSLog(...)
#endif


#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]


/*
 获取系统版本号
 */
#define Device_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/*
 获取屏幕宽度与高度
 */
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//相对iphone6 屏幕宽度比
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f
//相对iPhone6 屏幕高度比
#define KHeight_Scale [UIScreen mainScreen].bounds.size.height/667.0f

//版本号
#define kVersion_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define kVersionBuild_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]


/*
 获取通知中心
 */
#define WSDNotificationCenter [NSNotificationCenter defaultCenter]
/*
 获取缓存
 */
#define  MFUserDefault [NSUserDefaults standardUserDefaults]
/*
 读取图片
 */
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
/*
 当前view宽高
 */
#define WIDTH_CELL self.frame.size.width
#define HEIGHT_CELL self.frame.size.height
#define STL_ORIGIN_X        self.frame.origin.x                             //坐标X
#define STL_ORIGIN_Y        self.frame.origin.y                             //坐标Y
#define PAGESIZE @20        //每页获取数据数量宏
#define NaviBar_HEIGHT 64   //获取导航栏高度(包括状态栏高度20)
#define TabBar_HEIGHT 49    //获取标签栏高度
/**
 占位图
 */
#define Placeholder_small   IMAGE(@"placeholder60")
#define Placeholder_middle  IMAGE(@"placeholder160")
#define Placeholder_big     IMAGE(@"placeholder750")
#define EmptyImage          IMAGE(@"empty")
/** 经纬度*/
#define LongTi     [GOLFUserDefault objectForKey:@"longti"];
#define LatTi      [GOLFUserDefault objectForKey:@"latti"];
#define AreaID     [GOLFUserDefault objectForKey:@"areaId"];


#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreen_Width/320))

#define kHigher_iOS_6_1 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
#define kHigher_iOS_6_1_DIS(_X_) ([[NSNumber numberWithBool:kHigher_iOS_6_1] intValue] * _X_)
#define kNotHigher_iOS_6_1_DIS(_X_) (-([[NSNumber numberWithBool:kHigher_iOS_6_1] intValue]-1) * _X_)

#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kPaddingLeftWidth 15.0
#define kLoginPaddingLeftWidth 18.0
#define kMySegmentControl_Height 44.0
#define kMySegmentControlIcon_Height 70.0

#define  kBackButtonFontSize 16
#define  kNavTitleFontSize 18
#define  kBadgeTipStr @"badgeTip"

#define kDefaultLastId [NSNumber numberWithInteger:99999999]



// ios7之上的系统
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

// 获取屏幕 宽度、高度 bounds就是屏幕的全部区域
#define IS_IPHONE4 [UIScreen mainScreen].bounds.size.height == 480

// 获取当前屏幕的高度 applicationFrame就是app显示的区域，不包含状态栏
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)
#define kMainScreenWidth  ([UIScreen mainScreen].applicationFrame.size.width)

// 判断字段时候为空的情况
#define IF_NULL_TO_STRING(x) ([(x) isEqual:[NSNull null]]||(x)==nil)? @"":TEXT_STRING(x)
// 转换为字符串
#define TEXT_STRING(x) [NSString stringWithFormat:@"%@",x]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 设置颜色RGB
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//定义UIImage对象
#define IMAGELocal(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
#define ImageNamed(name) [UIImage imageNamed:name]


/*=============================================
 @name Weak Object
 ===============================================*/
#pragma mark - Weak Object
#define ESWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define ESStrong_DoNotCheckNil(weakVar, _var) __typeof(&*weakVar) _var = weakVar
#define ESStrong(weakVar, _var) ESStrong_DoNotCheckNil(weakVar, _var); if (!_var) return;

#define ESWeak_(var) ESWeak(var, weak_##var);
#define ESStrong_(var) ESStrong(weak_##var, _##var);

/** defines a weak `self` named `__weakSelf` */
#define ESWeakSelf      ESWeak(self, __weakSelf);
/** defines a strong `self` named `_self` from `__weakSelf` */
#define ESStrongSelf    ESStrong(__weakSelf, _self);

/**
 block循环引用
 */
#define weak(self)   __weak typeof (self) weakSelf = self;



#endif /* UtilsMacros_h */
