//
//  MFPublishRoommateTableViewProxy.h
//  MissF
//
//  Created by wyao on 2017/7/17.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RoommateProxySelectBlock)(BOOL isSelected,NSIndexPath *indexPath);
typedef void(^RoommateProxyPublishBlock)(UIButton*sender,NSIndexPath *indexPath);
typedef void(^RoommateProxyDeleteBlock)(NSIndexPath *indexPath);


@interface MFPublishRoommateTableViewProxy : NSObject<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) RoommateProxySelectBlock RoommateProxySelectBlock;
@property (nonatomic, copy) RoommateProxyPublishBlock RoommateProxyPublishBlock;
@property (nonatomic, copy) RoommateProxyDeleteBlock RoommateProxyDeleteBlock;
@end
