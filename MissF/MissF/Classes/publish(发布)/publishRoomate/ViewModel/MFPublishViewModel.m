//
//  MFPublishViewModel.m
//  MissF
//
//  Created by wyao on 2017/7/18.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFPublishViewModel.h"


@implementation MFPublishViewModel

-(MFPublishRoomateModel *)roomateModel{
    if (!_roomateModel) {
        _roomateModel  = [[MFPublishRoomateModel alloc] init];
    }
    return _roomateModel;
}

-(MFPublishHouseModel *)houseModel{
    if (!_houseModel) {
        _houseModel = [[MFPublishHouseModel alloc] init];
    }
    return _houseModel;
}

// 将string字符串转换为array数组
-(NSArray*)getArrayFromModelStringWithTag:(MFPublishVMTag)tag
{
    NSString *str;
    switch (tag) {
        case MF_PublishVM_personality:
            str = self.roomateModel.personality;
            break;
        case MF_PublishVM_roommateRequires:
            str = self.roomateModel.roommateRequires;
            break;
        case MF_PublishVM_paymentType:
            str = self.roomateModel.paymentType;
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
            self.roomateModel.personality = str;
            break;
        case MF_PublishVM_roommateRequires:
            self.roomateModel.roommateRequires  = str;
            break;
        case MF_PublishVM_paymentType:
             self.roomateModel.paymentType  = str;
            break;
        default:
            break;
    }

    return str;
}


-(NSString *)address{
    return self.roomateModel.address;
}

-(NSString *)datetime{
    return self.roomateModel.datetime;
}

-(NSString *)money{
    return self.roomateModel.money;
}
-(NSString *)constellation{
    return self.roomateModel.constellation;
}

-(NSString *)desc{
    return self.roomateModel.desc;
}
-(NSString *)profession{
    return self.roomateModel.profession;
}


-(NSMutableArray *)allTagsSelectedArray{
    if (!_allTagsSelectedArray) {
        MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
        _allTagsSelectedArray = [NSMutableArray arrayWithCapacity:3];
        if (model.tag.interest.count>0) {
            for (int  i = 0; i<3; i++) {
                [_allTagsSelectedArray addObject:model.tag.interest[i].name];
            }
        }
    }
    return _allTagsSelectedArray;
}

-(NSMutableArray *)roommateRequiresSelectedArray{
    if (!_roommateRequiresSelectedArray) {
        MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
        _roommateRequiresSelectedArray = [NSMutableArray arrayWithCapacity:3];
        if (model.roommateRequires.count>0) {
            for (int  i = 0; i<3; i++) {
                [_roommateRequiresSelectedArray addObject:model.roommateRequires[i].name];
            }
        }
    }
    return _roommateRequiresSelectedArray;
}

-(NSMutableArray *)facilitiesSelectedArray{
    if (!_facilitiesSelectedArray) {
        MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
        _facilitiesSelectedArray = [NSMutableArray arrayWithCapacity:3];
        if (model.roommateRequires.count>0) {
            for (int  i = 0; i<3; i++) {
                [_facilitiesSelectedArray addObject:model.facilities.common[i].name];
            }
        }
    }
    return _facilitiesSelectedArray;
}


-(NSMutableArray<houseRoomModel *> *)houseRoomModelArray{
    if (!_houseRoomModelArray) {
        _houseRoomModelArray = [[NSMutableArray alloc] init];
    }
    return _houseRoomModelArray;
}


-(NSString *)getHouseNameFromIndex:(NSInteger)index{
    NSString *name = self.houseRoomModelArray[index].name;
    name = [NSString iSBlankString:name]?@"":name;
    return name;
}
-(NSString *)getHousePriceFromIndex:(NSInteger)index{
    NSString *price = self.houseRoomModelArray[index].price;
    price = [NSString iSBlankString:price]?@"":price;
    return price;
}
-(NSString *)getHouseRoomTypeFromIndex:(NSInteger)index{
    NSString *roomType = self.houseRoomModelArray[index].roomType;
    roomType = [NSString iSBlankString:roomType]?@"":roomType;
    return roomType;
}

-(NSString *)getHouseOrientateFromIndex:(NSInteger)index{
    NSString *orientate = self.houseRoomModelArray[index].orientate;
    orientate = [NSString iSBlankString:orientate]?@"":orientate;
    return orientate;
}


-(NSMutableArray<NSMutableArray *>*)allUrlArray{
    if (!_allUrlArray) {
        _allUrlArray = [[NSMutableArray alloc] init];
    }
    return _allUrlArray;
}
-(NSMutableArray<NSMutableArray *> *)allPhotoArray{
    if (!_allPhotoArray) {
        _allPhotoArray = [[NSMutableArray alloc] init];
    }
    return _allPhotoArray;
}


#pragma mark - 上传图片
-(void)upLoadPhotos:(NSArray<HXPhotoModel *> *)photos withPhotoView:(UIView*)photoView{
    
    //判断是增加还是减少
    //1.增加需要单独上传增加的照片
    //2.减少的话只减少对应的url数组
    
    NSMutableArray  *uploadPhotoArray = [NSMutableArray array];
    NSMutableArray  *uploadUrlArray  = [NSMutableArray array];
    
    if (photoView.tag == 100) {//头部视图
        uploadPhotoArray = self.allPhotoArray[0];
        uploadUrlArray = [NSMutableArray arrayWithArray:self.allUrlArray[0]];
    }else{
        uploadPhotoArray = self.allPhotoArray[photoView.tag-2+1];//组选择器-2 + 1
        uploadUrlArray = [NSMutableArray arrayWithArray:self.allUrlArray[photoView.tag-2+1]];
    }
    
    NSMutableArray *tempArray = [NSMutableArray array];//临时数组记录增加的图片
    
    if (uploadPhotoArray.count == 0) {//数组为空
        [uploadPhotoArray addObjectsFromArray:photos];
        [tempArray addObjectsFromArray:photos];
    }else{//数组存在元素，说明已经有上传的图片
        if (uploadPhotoArray.count>photos.count) {//图片减少了
            for (int i = 0; i<uploadPhotoArray.count; i++) {
                if (![photos containsObject:uploadPhotoArray[i]]) {
                    //记录下标 移除地址数组对应下标的元素
                    if (uploadUrlArray.count> 0) {
                        [uploadUrlArray removeObjectAtIndex:i];
                    }
                }
            }
            
            //地址数组重新赋值
            if (photoView.tag == 100) {
                [self.allUrlArray replaceObjectAtIndex:0 withObject:uploadUrlArray];
            }else{
                [self.allUrlArray replaceObjectAtIndex:photoView.tag-2+1 withObject:uploadUrlArray];
            }
            
            //照片数组清空再赋值
            [uploadPhotoArray removeAllObjects];
            [uploadPhotoArray addObjectsFromArray:photos];
        }else{//图片增加了之前的保持不变 仅加入增加的元素
            for (int i = 0; i<photos.count; i++) {
                if (![uploadPhotoArray containsObject:photos[i]]) {
                    //如果不包含就添加到需要上传的图片数组中
                    [tempArray addObject:photos[i]];
                    [uploadPhotoArray addObject:photos[i]];
                }
            }
        }
    }
    
    if (tempArray.count>0) {
        [SVProgressHUD showWithStatus:@"正在上传图片"];
        NSDictionary *parameter = @{@"file":@".png",
                                    @"type":@"roommate"};
        weak(self);
        //上传图片
        [[MFNetAPIClient sharedInstance] uploadImageWithUrlString:kupload parameters:parameter ImageArray:tempArray  SuccessBlock:^(id responObject) {
            [SVProgressHUD showInfoWithStatus:responObject[@"message"]];
            
            [uploadUrlArray addObjectsFromArray:responObject[@"data"][@"list"]];
            
            if (photoView.tag == 100) {
                [weakSelf.allUrlArray replaceObjectAtIndex:0 withObject:uploadUrlArray];
            }else{
                [weakSelf.allUrlArray replaceObjectAtIndex:photoView.tag-2+1 withObject:uploadUrlArray];
            }
            
            NSLog(@"整个url地址的数组---->%@",weakSelf.allUrlArray);
        } FailurBlock:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showInfoWithStatus:errorMsg];
        } UpLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        }];
    }
}


@end
