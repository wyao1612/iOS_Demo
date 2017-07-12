//
//  MFHouseListModel.h
//  MissF
//
//  Created by wyao on 2017/7/7.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseObject.h"

@interface MFHouseListModel : BaseObject
@property(copy,nonatomic) NSString* ID;
@property(copy,nonatomic) NSString* title;
@property(copy,nonatomic) NSString* desc;
@property(strong,nonatomic) NSArray* images;
@property(copy,nonatomic) NSString* money;
@property(copy,nonatomic) NSString* address;
@property(copy,nonatomic) NSString* room;
@property(copy,nonatomic) NSString* uid;
@property(copy,nonatomic) NSString* paymentType;
@property(copy,nonatomic) NSString* hall;
@property(copy,nonatomic) NSString* toilet;
@property(copy,nonatomic) NSString* floor;
@property(copy,nonatomic) NSString* currentFloor;
@property(copy,nonatomic) NSString* roomNumber;
@property(copy,nonatomic) NSString* facilities;
@property(copy,nonatomic) NSString* roommateRequires;
@property(copy,nonatomic) NSString* updated;
@property(strong,nonatomic) NSArray* houseRoom;
@property(copy,nonatomic) NSString* viewTotal;
@property(copy,nonatomic) NSString* commentTotal;
@property(copy,nonatomic) NSString* shareTotal;
@property(copy,nonatomic) NSString* latitude;
@property(copy,nonatomic) NSString* longitude;
@property(copy,nonatomic) NSString* cover;
/** 记录相应row是否选中（自定义）*/
@property(nonatomic, assign)BOOL isSelected;
@end
