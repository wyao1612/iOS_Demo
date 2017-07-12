//
//  MFHouseViewModel.h
//  MissF
//
//  Created by wyao on 2017/7/8.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MFHouseViewModelDelegate <NSObject>

@required

/**
 网络数据请求成功的代理返回数据源

 @param dataArray 数据源
 */
- (void)houseListModelRequestDidSuccessWithArray:(NSMutableArray *)dataArray;

/**
 VM做网络请求 将数据源给控制器
 @param dataArray 数据源
 */
- (void)houseListModelRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray;

/**
 记录是否全选和选中的个数

 @param totalCount 选中的个数
 @param isAllSelected 是否全选
 */
- (void)houseViewModelTotalCount:(NSInteger)totalCount isAllSelected:(BOOL)isAllSelected;
/**
 让控制器弹窗提示是否删除

 @param selectedProducts 选中的商品列表
 */
- (void)houseListModelWillDeleteSelectedProducts:(NSArray *)selectedProducts;

/**
 已经删除对应的商品 让控制器刷新数据源
 */
- (void)houseListModelHasDeleteAllProducts;
@end



@interface MFHouseViewModel : NSObject

@property (nonatomic, weak) id <MFHouseViewModelDelegate> delegate;
/**
 网络请求
 
 @param ret 是否刷新数据
 */
-(void)requestDataWithRet:(BOOL)ret;

/**
 选中对应的商品

 @param indexPath 对应的商品的indexPath
 @param isSelected 是否选中
 */
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;
/**
 全选商品
 */
- (void)selectAllProductWithStatus:(BOOL)isSelected;

/**
 删除对应商品(应用于左滑删除单个)

 @param indexPath 对应的商品的indexPath
 */
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath;

/**
   删除对应选中的多个商品
 */
- (void)deleteSelectedProducts:(NSArray *)selectedArray;

/**
 将要删除对应选中单个的商品 下一步让控制器弹出提示窗
 */
- (void)beginToDeleteSelectedProducts;

/**
 重新发布对应的商品

 @param indexpath 对应的商品的indexPath
 */
-(void)publishSelectedProduct:(NSIndexPath*)indexpath;
@end
