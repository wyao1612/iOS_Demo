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
#define ClearColor [UIColor clearColor]  //清除背景色
#define BACKGROUNDCOLOR RGBColor(240, 240, 240)//背景色 f0f0f0
#define WHITECOLOR [UIColor whiteColor]//-- 白色
#define BLACKCOLOR [UIColor blackColor]//-黑色
#define BLACKTEXTCOLOR RGBColor(51, 51, 51)//-黑色///33333
#define SHENTEXTCOLOR RGBColor(102, 102, 102)//深色/666666
#define LIGHTTEXTCOLOR RGBColor(153, 153, 153)//灰色///999999
#define GRAYCOLOR RGBColor(230, 230, 230)//---浅色//e6e6e6、/切割线色
#define GLOBALCOLOR [UIColor colorWithHex:0xffffff]
#define OrangeCOLOR RGBColor(252,84,0)//橘色、价格数据颜色
#define kColorD8DDE4 [UIColor colorWithHex:0xD8DDE4]
/**
 字体
 */
#define FONT(F)  [UIFont systemFontOfSize:F]

#define kColorNavBG                 [UIColor colorWithString:@"0xF8F8F8"]
#define kColorNavTitle              [UIColor colorWithString:@"0x323A45"]
#define kColorTableBG               [UIColor colorWithString:@"0xFFFFFF"]
#define kColorTableSectionBg        [UIColor colorWithString:@"0xF2F4F6"]
#define kColor222                   [UIColor colorWithString:@"0x222222"]
#define kColor666                   [UIColor colorWithString:@"0x666666"]
#define kColor999                   [UIColor colorWithString:@"0x999999"]
#define kColorBrandGreen            [UIColor colorWithString:@"0x2EBE76"]
#define kColorBrandRed              [UIColor colorWithString:@"0xF56061"]

#pragma mark New Color
#define kColorDark3                 [UIColor colorWithString:@"0x323A45"]
#define kColorDark4                 [UIColor colorWithString:@"0x425063"]
#define kColorDark7                 [UIColor colorWithString:@"0x76808E"]
#define kColorDarkA                 [UIColor colorWithString:@"0xA9B3BE"]
#define kColorDarkD                 [UIColor colorWithString:@"0xD8DDE4"]
#define kColorDarkF                 [UIColor colorWithString:@"0xF2F4F6"]
#define kColorWhite                 [UIColor colorWithString:@"0xFFFFFF"]
#define kColorActionGreen           [UIColor colorWithString:@"0x2EBE76"]
#define kColorActionRed             [UIColor colorWithString:@"0xF56061"]
#define kColorActionYellow          [UIColor colorWithString:@"0xF3C033"]


///正常字体
#define H30 [UIFont systemFontOfSize:30]
#define H29 [UIFont systemFontOfSize:29]
#define H28 [UIFont systemFontOfSize:28]
#define H27 [UIFont systemFontOfSize:27]
#define H26 [UIFont systemFontOfSize:26]
#define H25 [UIFont systemFontOfSize:25]
#define H24 [UIFont systemFontOfSize:24]
#define H23 [UIFont systemFontOfSize:23]
#define H22 [UIFont systemFontOfSize:22]
#define H20 [UIFont systemFontOfSize:20]
#define H19 [UIFont systemFontOfSize:19]
#define H18 [UIFont systemFontOfSize:18]
#define H17 [UIFont systemFontOfSize:17]
#define H16 [UIFont systemFontOfSize:16]
#define H15 [UIFont systemFontOfSize:15]
#define H14 [UIFont systemFontOfSize:14]
#define H13 [UIFont systemFontOfSize:13]
#define H12 [UIFont systemFontOfSize:12]
#define H11 [UIFont systemFontOfSize:11]
#define H10 [UIFont systemFontOfSize:10]
#define H8 [UIFont systemFontOfSize:8]

///粗体
#define HB20 [UIFont boldSystemFontOfSize:20]
#define HB18 [UIFont boldSystemFontOfSize:18]
#define HB16 [UIFont boldSystemFontOfSize:16]
#define HB14 [UIFont boldSystemFontOfSize:14]
#define HB13 [UIFont boldSystemFontOfSize:13]
#define HB12 [UIFont boldSystemFontOfSize:12]
#define HB11 [UIFont boldSystemFontOfSize:11]
#define HB10 [UIFont boldSystemFontOfSize:10]
#define HB8 [UIFont boldSystemFontOfSize:8]


//链接颜色
#define kLinkAttributes     @{(__bridge NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[[UIColor colorWithHexString:@"0xff798d"] CGColor]}
#define kLinkAttributesActive       @{(NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:NO],(NSString *)kCTForegroundColorAttributeName : (__bridge id)[[UIColor colorWithHexString:@"0xff798d"] CGColor]}


#endif /* FontAndColorMacros_h */