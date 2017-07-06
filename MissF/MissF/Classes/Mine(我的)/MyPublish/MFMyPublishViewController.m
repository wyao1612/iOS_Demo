//
//  MFMyPublishViewController.m
//  MissF
//
//  Created by wyao on 2017/7/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFMyPublishViewController.h"

@interface MFMyPublishViewController ()
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (assign, nonatomic) NSInteger curIndex;

@end

@implementation MFMyPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    self.curIndex = 0;
}

-(void)setNav{
     self.rightStr_0 = @"编辑";
     self.navigationItem.titleView = self.segmentedControl;
}


-(UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = ({
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"编辑", @"预览"]];
            [segmentedControl setWidth:80 forSegmentAtIndex:0];
            [segmentedControl setWidth:80 forSegmentAtIndex:1];
            segmentedControl.tintColor = [UIColor whiteColor];
            [segmentedControl setTitleTextAttributes:@{
                                                       NSFontAttributeName: [UIFont systemFontOfSize:16],
                                                       NSForegroundColorAttributeName: [UIColor colorWithHex:0xffb2bd]
                                                       }
                                            forState:UIControlStateSelected];
            [segmentedControl setTitleTextAttributes:@{
                                                       NSFontAttributeName: [UIFont systemFontOfSize:16],
                                                       NSForegroundColorAttributeName: [UIColor whiteColor]
                                                       } forState:UIControlStateNormal];
            [segmentedControl addTarget:self action:@selector(segmentedControlSelected:) forControlEvents:UIControlEventValueChanged];
            segmentedControl;
        });
    }
    return _segmentedControl;
}

#pragma mark UISegmentedControl
- (void)segmentedControlSelected:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.curIndex = segmentedControl.selectedSegmentIndex;
}

#pragma mark index_view

- (void)setCurIndex:(NSInteger)curIndex{
    _curIndex = curIndex;
    if (_segmentedControl.selectedSegmentIndex != curIndex) {
        [_segmentedControl setSelectedSegmentIndex:_curIndex];
    }
    if (_curIndex == 0) {
//        [self loadEditView];
    }else{
//        [self loadPreview];
    }
}

-(void)right_0_action{
    [MBProgressHUD showSuccess:@"编辑信息" toView:self.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
