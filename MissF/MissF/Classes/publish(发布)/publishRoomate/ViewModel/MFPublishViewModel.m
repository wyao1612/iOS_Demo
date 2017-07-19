//
//  MFPublishViewModel.m
//  MissF
//
//  Created by wyao on 2017/7/18.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFPublishViewModel.h"


@implementation MFPublishViewModel

-(MFPublishModel *)publishModel{
    if (!_publishModel) {
        _publishModel  = [[MFPublishModel alloc] init];
    }
    return _publishModel;
}

// 将string字符串转换为array数组
-(NSArray*)getArrayFromModelStringWithTag:(MFPublishVMTag)tag
{
    NSString *str;
    switch (tag) {
        case MF_PublishVM_personality:
            str = self.publishModel.personality;
            break;
        case MF_PublishVM_roommateRequires:
            str = self.publishModel.roommateRequires;
            break;
        case MF_PublishVM_paymentType:
            str = self.publishModel.paymentType;
            break;
        default:
            break;
    }
    NSArray  *array = [str componentsSeparatedByString:@" "];
    return array;
}

//将array数组转换为string字符串
-(NSString*)setModelStringFromArrayWithTag:(MFPublishVMTag)tag andArray:(NSArray*)array
{
    NSString *str = [array componentsJoinedByString:@" "];
    switch (tag) {
        case MF_PublishVM_personality:
            self.publishModel.personality = str;
            break;
        case MF_PublishVM_roommateRequires:
            self.publishModel.roommateRequires  = str;
            break;
        case MF_PublishVM_paymentType:
             self.publishModel.paymentType  = str;
            break;
        default:
            break;
    }

    return str;
}


-(NSString *)address{
    return self.publishModel.address;
}

-(NSString *)datetime{
    return self.publishModel.datetime;
}

-(NSString *)money{
    return self.publishModel.money;
}
-(NSString *)constellation{
    return self.publishModel.constellation;
}

-(NSString *)desc{
    return self.publishModel.desc;
}
-(NSString *)profession{
    return self.publishModel.profession;
}

@end
