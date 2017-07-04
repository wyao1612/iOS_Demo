//
//  UIImageView+size.m
//  WSD
//
//  Created by wyao on 2017/4/27.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "UIImageView+size.h"

@implementation UIImageView (size)
- (void)drawImage:(UIImage *)image targetSize:(CGSize )size{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        CGRect newRect = CGRectMake(0, 0, size.width, size.height);
        CGRectIntegral(newRect);
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
        CGAffineTransform transform = CGAffineTransformMake(1, 0, 0, -1, 0, size.height);
        CGContextConcatCTM(context, transform);
        CGContextDrawImage(context, newRect, image.CGImage);
        CGImageRef CGImage = context ? CGBitmapContextCreateImage(context) : nil;
        UIImage *newImage = CGImage ? [UIImage imageWithCGImage:CGImage] : nil;
        UIGraphicsEndImageContext();
        if (CGImage){
            CGImageRelease(CGImage);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (newImage) {
                self.layer.contents = (__bridge id _Nullable)(newImage.CGImage);
            }
        });
    });
}
@end
