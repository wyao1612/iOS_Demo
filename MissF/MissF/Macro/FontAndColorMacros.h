//
//  FontAndColorMacros.h
//  iOS_demo
//
//  Created by wyao on 2017/6/20.
//  Copyright © 2017年 wyao. All rights reserved.
//

//定义全局用的色值、字体大小，这里建议跟设计师共同维护一个设计规范
#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#import "UIColor+expanded.h"

/**
 颜色
 */
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define RANDOM_COLOR [UIColor colorWithHue: (arc4random() % 256 / 256.0) saturation:((arc4random()% 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]

#define ClearColor              [UIColor clearColor]  //清除背景色
#define BACKGROUNDCOLOR         [UIColor colorWithHex:0xf4f4f4]
#define WHITECOLOR              [UIColor whiteColor]//-- 白色
#define BLACKCOLOR              [UIColor blackColor]//-黑色
#define BLACKTEXTCOLOR          [UIColor colorWithHex:0x333333]//-黑色
#define SHENTEXTCOLOR           RGBColor(102, 102, 102)//深色
#define LIGHTTEXTCOLOR          [UIColor colorWithHex:0xc9c9c9]//灰色
#define GRAYCOLOR               [UIColor colorWithHex:0xf4f4f4]//主题色
#define GLOBALCOLOR             [UIColor colorWithHex:0xffb2bd]
#define OrangeCOLOR             RGBColor(252,84,0)//橘色、价格数据颜色
#define kColorD8DDE4            [UIColor colorWithHex:0xD8DDE4]
#define COVERBACKGROUND         RGBAColor(51,51,51,0.3)
/** 字体*/
#define FONT(F)         [UIFont systemFontOfSize:F]
#define BigFont         FONT(18.0f)
#define MiddleFont      FONT(15.0f)
#define SmallFont       FONT(13.0f)

/** 分割线*/
#define LineColor             [UIColor colorWithHex:0xf4f4f4]
#define LineMargin            120.0f

//链接颜色
#define kLinkAttributes     @{(__bridge NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[[UIColor colorWithHexString:@"0xff798d"] CGColor]}
#define kLinkAttributesActive       @{(NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[[UIColor colorWithHexString:@"0xff798d"] CGColor]}


#endif /* FontAndColorMacros_h */
