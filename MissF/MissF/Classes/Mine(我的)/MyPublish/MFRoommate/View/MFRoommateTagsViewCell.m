//
//  MFRoommateTagsViewCell.m
//  MissF
//
//  Created by wyao on 2017/7/13.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFRoommateTagsViewCell.h"
#import "MFTagsView.h"

@interface MFRoommateTagsViewCell ()
@property(strong,nonatomic)MFTagsView *tagsView;
@end


@implementation MFRoommateTagsViewCell

-(MFTagsView *)tagsView{
    if (!_tagsView) {
        _tagsView = [[MFTagsView alloc] init];
    }
    return _tagsView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            // Initialization code
            self.selectionStyle = UITableViewCellSelectionStyleNone;
            self.backgroundColor = WHITECOLOR;
            [self setupUI];
            
        }
        return self;
}

-(void)setupUI{

}

-(void)setUIwithModelArray:(NSArray<MFCommonBaseModel *>*)modelArray andTagsName:(NSString*)tagsName{
    
    CGFloat height =  [self getCellHeightWtihBtnsWithModelArray:modelArray];
    self.tagsView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    [self.contentView addSubview:self.tagsView];
    self.tagsView.tagsName = tagsName;
    [self.tagsView setHeaderDataArr:[NSMutableArray arrayWithArray:modelArray]];
}

-(CGFloat)getCellHeightWtihBtnsWithModelArray:(NSArray*)modelArray{
    CGFloat height = [self.tagsView getCellHeightWtihBtns:modelArray];
    //NSLog(@"%f",height);
    return height;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
