//
//  MFTagsView.h
//  MissF
//
//  Created by wyao on 2017/7/14.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MFTagsViewMoreBlock)(UIButton *sender);

@protocol headerDelegate <NSObject>
-(void)BtnActionDelegate:(NSMutableArray *)arr;
@end


@interface MFTagsView : UIView
@property (nonatomic ,strong) NSMutableArray *headerDataArr;
@property (nonatomic ,assign) id<headerDelegate> delegate;
-(CGFloat)getCellHeightWtihBtns:(NSArray*)arrry;
@property (nonatomic ,copy) NSString* tagsName;
@property (nonatomic ,copy) NSString* tagViewStyle;
@property(nonatomic,strong)UIButton *moreBtn;
@property (nonatomic, copy) MFTagsViewMoreBlock MFTagsViewMoreBlock;
@end
