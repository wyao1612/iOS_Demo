//
//  YW_TextField.h
//  WSD
//
//  Created by wyao on 2017/2/5.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YW_TextField : UITextField
@property(nonatomic,strong)UIColor *borderColor;
/**
 设置左侧图像
 
 @param image 图像名称
 */
-(void)setTextFiledLeftImageName:(NSString*)image;
@end
