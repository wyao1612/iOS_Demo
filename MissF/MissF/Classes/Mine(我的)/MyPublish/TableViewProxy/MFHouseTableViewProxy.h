//
//  MFHouseTableViewProxy.h
//  MissF
//
//  Created by wyao on 2017/7/12.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^HouseProxySelectBlock)(BOOL isSelected,NSIndexPath *indexPath);
typedef void(^HouseProxyPublishBlock)(UIButton*sender,NSIndexPath *indexPath);
typedef void(^HouseProxyDeleteBlock)(NSIndexPath *indexPath);

@interface MFHouseTableViewProxy : NSObject <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) HouseProxySelectBlock HouseProxySelectBlock;
@property (nonatomic, copy) HouseProxyPublishBlock HouseProxyPublishBlock;
@property (nonatomic, copy) HouseProxyDeleteBlock HouseProxyDeleteBlock;
@property (nonatomic, assign) BOOL isExpend;
@end
