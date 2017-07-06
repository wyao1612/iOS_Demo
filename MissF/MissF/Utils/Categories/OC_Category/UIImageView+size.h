//
//  UIImageView+size.h
//  WSD
//
//  Created by wyao on 2017/4/27.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (size)
- (void)drawImage:(UIImage *)image targetSize:(CGSize )size;
@end
