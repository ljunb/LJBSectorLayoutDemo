//
//  ViewController.m
//  LJBSectorLayoutDemo
//
//  Created by CookieJ on 16/3/27.
//  Copyright © 2016年 ljunb. All rights reserved.
//  仿薄荷-食物百科首页的扇形布局

#import "ViewController.h"
#import "LJBSectorLayout.h"

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;

@end

static NSString * const kLJBSectorCellIdentifier = @"LJBSectorCellIdentifier";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.frame = CGRectMake(0, 80, self.view.frame.size.width, 200);
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kLJBSectorCellIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLJBSectorCellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        LJBSectorLayout * layout = [[LJBSectorLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
