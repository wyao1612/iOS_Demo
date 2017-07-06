//
//  YWScrollContentView.m
//  YWScrollContentView
//
//  Created by wyao on 2017/5/26.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "YWScrollContentView.h"

static NSString *kContentCellID = @"kContentCellID";
static NSString *tableViewCellId = @"tableViewCellId";

@interface YWScrollContentView()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    CGFloat _startOffsetX;
}

@property (nonatomic, assign) NSInteger colCount;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isForbidScrollDelegate;
@property (nonatomic, strong) UIView *normalView;

@end

@implementation YWScrollContentView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    flowLayout.itemSize = self.bounds.size;
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.scrollsToTop = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.colCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *mycell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    return mycell;
}

#pragma - UITableViewDelegate - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell  * cell =[tableView dequeueReusableCellWithIdentifier:tableViewCellId];
    cell.textLabel.text = @(indexPath.row).description;
    return cell;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isForbidScrollDelegate = NO;
    _startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isForbidScrollDelegate) {
        return;
    }
    CGFloat endOffsetX = scrollView.contentOffset.x;
    //NSLog(@"滑动了%f",endOffsetX);
    NSInteger fromIndex = floor(_startOffsetX / scrollView.frame.size.width);
    CGFloat progress;
    NSInteger toIndex;
    if (_startOffsetX < endOffsetX) {//左滑
        progress = (endOffsetX - _startOffsetX) / scrollView.frame.size.width;
        toIndex = fromIndex + 1;
        if (toIndex > self.colCount - 1) {
            toIndex = self.colCount - 1;
        }
    } else if (_startOffsetX == endOffsetX){
        progress = 0;
        toIndex = fromIndex;
    } else {
        progress = (_startOffsetX - endOffsetX) / scrollView.frame.size.width;
        toIndex = fromIndex - 1;
        if (toIndex < 0) {
            toIndex = 0;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentViewDidScroll:fromIndex:toIndex:progress:)]) {
        [self.delegate contentViewDidScroll:self fromIndex:fromIndex toIndex:toIndex progress:progress];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat endOffsetX = scrollView.contentOffset.x;
    NSInteger startIndex = floor(_startOffsetX / scrollView.frame.size.width);
    NSInteger endIndex = floor(endOffsetX / scrollView.frame.size.width);
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentViewDidEndDecelerating:startIndex:endIndex:)]) {
        [self.delegate contentViewDidEndDecelerating:self startIndex:startIndex endIndex:endIndex];
    }
}


- (void)setCurrentIndex:(NSInteger)currentIndex{
    __weak typeof (self) weakSelf = self;
    if (_currentIndex == currentIndex || _currentIndex < 0 || _currentIndex > self.colCount - 1 || self.colCount <= 0) {
        return;
    }
    _currentIndex = currentIndex;
    self.isForbidScrollDelegate = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    });
}

- (void)reloadViewWithColCount:(NSInteger)colCount{
    self.colCount = colCount;
    [self.collectionView reloadData];
}

@end
