//
//  MainViewController.h
//  GDMapPlaceAroundDemo
//
//  Created by Mr.JJ on 16/6/14.
//  Copyright © 2016年 Mr.JJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^locationSelectBlock)(CGFloat latitude,CGFloat longitude,NSArray *addresArr);
@interface MainViewController : BaseViewController
@property (nonatomic, copy) locationSelectBlock locationSelectBlock;
@end
