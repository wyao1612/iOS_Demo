//
//  MFHouseViewModel.m
//  MissF
//
//  Created by wyao on 2017/7/8.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFHouseViewModel.h"
#import <UIKit/UIKit.h>
#import "MFHouseListModel.h"

@interface MFHouseViewModel (){
    NSInteger _page;
    NSInteger _mark;
}

/** 购物车数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MFHouseViewModel

#pragma mark - 网络请求
-(void)requestDataWithRet:(BOOL)ret{
    
    [SVProgressHUD showWithStatus:@"正在加载数据"];
    
    if (ret) {
        _page = 1;
    }else{
        _page += 1;
    }
    
    NSMutableDictionary *parameter = [
                                      @{
                                        @"mark":[NSString stringWithFormat:@"%zd",_mark],
                                        @"page":[NSString stringWithFormat:@"%zd",_page],
                                        @"pageSize":PAGESIZE.stringValue,
                                        @"done":@"0"
                                        }
                                      mutableCopy];
    weak(self);
    [[MFNetAPIClient sharedInstance] getWithUrl:kHouseList refreshCache:YES params:parameter success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            //假数据
            NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"HouseList" ofType:@"json"];
            NSData *data=[NSData dataWithContentsOfFile:jsonPath];
            NSError *error;
            id jsonObject=[NSJSONSerialization JSONObjectWithData:data
                                                          options:NSJSONReadingAllowFragments
                                                            error:&error];
            
            self.dataArray = [MFHouseListModel mj_objectArrayWithKeyValuesArray:jsonObject[@"data"][@"house"]];
            //回调数据源
            [weakSelf.delegate houseListModelRequestDidSuccessWithArray:self.dataArray];
            [SVProgressHUD dismiss];  
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
        }
      
    } fail:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString analyticalHttpErrorDescription:error]];
    }];
}


#pragma mark - 选中对应的商品
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected {
    
    MFHouseListModel *houseListModel = self.dataArray[indexPath.row];
    houseListModel.isSelected = isSelected;
    //其余保持未选中状态
    for (MFHouseListModel *ListModel in self.dataArray) {
        if (ListModel.isSelected == NO) {
            ListModel.isSelected = NO;
        }
    }
    [self.delegate houseViewModelTotalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
}



#pragma mark - 全选商品
- (void)selectAllProductWithStatus:(BOOL)isSelected {
    
    for (MFHouseListModel *productModel in self.dataArray) {
        productModel.isSelected = isSelected;
    }
    [self.delegate houseViewModelTotalCount:[self accountTotalCount]  isAllSelected:[self isAllSelected]];
}


#pragma mark - 开始删除用于提示
- (void)beginToDeleteSelectedProducts {
    
    NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
    for (MFHouseListModel *houseListModel in self.dataArray) {
        if (houseListModel.isSelected) {
            [selectedArray addObject:houseListModel];
        }
    }
    [self.delegate houseListModelWillDeleteSelectedProducts:selectedArray];
}

#pragma mark - 删除对应的商品
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath {
    
    [SVProgressHUD showSuccessWithStatus:@"测试删除提示"];
    
    MFHouseListModel *productModel = self.dataArray[indexPath.row];
    //根据请求结果决定是否删除
    weak(self);
    NSMutableDictionary *parameter = [@{
                                        @"cartId":productModel.ID
                                        } mutableCopy];
    
    [[MFNetAPIClient sharedInstance] requestWithHttpMethod:POST refreshCache:NO url:kHouseDelete params:parameter progress:nil success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            
            [weakSelf.dataArray removeObject:productModel];
            
            if (weakSelf.dataArray.count > 0) {
                for (MFHouseListModel *aProductModel in weakSelf.dataArray) {
                    if (!aProductModel.isSelected) {
                        aProductModel.isSelected = NO;
                        break;
                    }
                }
            }
            
           [self.delegate houseViewModelTotalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
            
            if (weakSelf.dataArray.count == 0) {
                [weakSelf.delegate houseListModelHasDeleteAllProducts];
            }
        }
    } fail:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString analyticalHttpErrorDescription:error]];
    }];

}

#pragma mark - 删除多选的商品
- (void)deleteSelectedProducts:(NSArray *)selectedArray {
    
    //根据请求结果决定是否批量删除
    NSMutableArray *temArr = [NSMutableArray array];
    for (MFHouseListModel *houseListModel in selectedArray) {
        [temArr addObject:houseListModel.ID];
    }
    NSString *cartId =  [self getJsonStringWithtArray:temArr];

    weak(self);
    NSMutableDictionary *parameter = [@{
                                        @"cartId":cartId
                                        } mutableCopy];

    [[MFNetAPIClient sharedInstance] requestWithHttpMethod:POST refreshCache:NO url:kHouseDelete params:parameter progress:nil success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            
            [weakSelf.dataArray removeObjectsInArray:selectedArray];
            
            if (weakSelf.dataArray.count > 0) {
                for (MFHouseListModel *aProductModel in weakSelf.dataArray) {
                    if (!aProductModel.isSelected) {
                        aProductModel.isSelected = NO;
                        break;
                    }
                }
            }
            [self.delegate houseViewModelTotalCount:[self accountTotalCount] isAllSelected:[self isAllSelected]];
            
            if (weakSelf.dataArray.count == 0) {
                [weakSelf.delegate houseListModelHasDeleteAllProducts];
            }

        }
    } fail:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString analyticalHttpErrorDescription:error]];
    }];
}


#pragma mark - 重新发布对应的商品
-(void)publishSelectedProduct:(NSIndexPath*)indexpath{
    [SVProgressHUD showSuccessWithStatus:@"测试重新发布"];
}


#pragma mark private methods
#pragma mark - 数组转字符串
-(NSString*)getJsonStringWithtArray:(NSArray*)array{
    NSString *jsonStr = [array componentsJoinedByString:@","];
    //NSLog(@"jsonStr==%@",jsonStr);
    return jsonStr;
}

#pragma mark - 计算是商品数量
- (NSInteger)accountTotalCount {
    NSInteger totalCount = 0;
    for (MFHouseListModel *productModel in self.dataArray) {
        if (productModel.isSelected) {
            totalCount += 1;
        }
    }
    return totalCount;
}


#pragma mark - 计算是否是全选（只要有一个没选中就不是全选）
- (BOOL)isAllSelected {
    
    if (self.dataArray.count == 0) return NO;
    BOOL isAllSelected = YES;
    for (MFHouseListModel *productModel in self.dataArray) {
        if (productModel.isSelected == NO) {
            isAllSelected = NO;
        }
    }
    return isAllSelected;
}


@end
