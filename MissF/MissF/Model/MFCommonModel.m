//
//  MFCommonModel.m
//  MissF
//
//  Created by wyao on 2017/7/14.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFCommonModel.h"

@implementation MFCommonBaseModel
@end

@implementation MFSymbolicBaseModel
@end

@implementation MFPaymentTypeModel
@end

@implementation MFProfessionModel
@end

@implementation MFCommonModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"paymentType" : @"MFPaymentTypeModel",
             @"constellation":@"MFSymbolicBaseModel",
             @"chineseZodiac":@"MFSymbolicBaseModel",
             @"tag":@"MFtagsModel",
             @"roommateRequires":@"MFCommonBaseModel",
             @"profession":@"MFProfessionModel"
             };
}
@end


@implementation facilitiesModel
@end




@implementation MFtagsModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"interest" : @"MFCommonBaseModel",
             @"habit":@"MFCommonBaseModel",
             @"personality":@"MFCommonBaseModel"
             };
}
@end




