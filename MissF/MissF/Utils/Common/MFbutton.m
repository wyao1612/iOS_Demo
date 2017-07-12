//
//  MFbutton.m
//  MissF
//
//  Created by wyao on 2017/7/7.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFbutton.h"

@implementation MFbutton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        [self setTitleColor:BLACKTEXTCOLOR forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = BLACKTEXTCOLOR.CGColor;
        self.layer.borderWidth = 0.5f;
    }
    return self;
}
@end
