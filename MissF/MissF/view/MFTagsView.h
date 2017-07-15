//
//  MFTagsView.h
//  MissF
//
//  Created by wyao on 2017/7/14.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MFCommonBaseModel;
@protocol headerDelegate <NSObject>
-(void)BtnActionDelegate:(NSMutableArray *)arr;
@end


@interface MFTagsView : UIView
@property (nonatomic ,strong) NSMutableArray<MFCommonBaseModel*> *headerDataArr;
@property (nonatomic ,assign) id<headerDelegate> delegate;
-(CGFloat)getCellHeightWtihBtns:(NSArray*)arrry;
@property (nonatomic ,copy) NSString* tagsName;
@end
