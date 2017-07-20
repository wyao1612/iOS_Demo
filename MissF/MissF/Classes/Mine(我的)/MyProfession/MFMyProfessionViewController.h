//
//  MFMyProfessionViewController.h
//  MissF
//
//  Created by wyao on 2017/7/17.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^cellSelectBlock)(NSString* text);
@interface MFMyProfessionViewController : BaseViewController
@property (nonatomic, copy) cellSelectBlock cellSelectBlock;
@end
