//
//  MFPublishRoommateTableViewProxy.h
//  MissF
//
//  Created by wyao on 2017/7/17.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PublishRoommateProxySelectBlock)(UIButton *sender,NSIndexPath *indexPath);

@interface MFPublishRoommateTableViewProxy : NSObject<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) PublishRoommateProxySelectBlock PublishRoommateProxySelectBlock;
@property (nonatomic, strong) NSArray *personalityArray;
@end
