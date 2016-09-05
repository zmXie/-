//
//  ViewController.m
//  CollectViewLayOut
//
//  Created by xzm on 16/2/19.
//  Copyright © 2016年 ypwl. All rights reserved.
//

#import "ViewController.h"

#import "XZMFlowLayout.h"

#import "XZMcollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XZMFlowLayoutDelegate>

@end

static NSString *const collectionCellIdfier = @"collectionCellIdfier";

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    XZMFlowLayout *flowLayout = [[XZMFlowLayout alloc]init];
    
    flowLayout.delegate = self;
    
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    collectView.backgroundColor = [UIColor whiteColor];
    
    collectView.delegate = self;
    
    collectView.dataSource = self;
    
    [collectView registerNib:[UINib nibWithNibName:@"XZMcollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionCellIdfier];
    
    [self.view addSubview:collectView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 50;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZMcollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdfier forIndexPath:indexPath];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
//    UILabel *label = [cell.contentView viewWithTag:100];
//    
//    if (label == nil) {
//        
//        label = [[UILabel alloc]init];
//        
//        label.tag = 100;
//        
//        [cell.contentView addSubview:label];
//        
//    }
//    
//    if (indexPath.row % 2 == 0) {
//        
//        cell.backgroundColor = [UIColor orangeColor];
//        
//    }else{
//        
//        cell.backgroundColor = [UIColor yellowColor];
//    }
//    
//    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
//    
//    [label sizeToFit];
    
    return cell;
}

#pragma mark -- XZMFlowLayoutDelegate
/**
 *  返回item 高度
 */
-(CGFloat)XZMFlowLayout:(XZMFlowLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath WithItemWidth:(CGFloat)itemWidth{
    
    return 100+arc4random_uniform(100);
}
/**
 *  返回列数
 */
-(NSInteger)numberOfColumnsInXZMFlowLayout:(XZMFlowLayout *)flowLayout{
    
    return 3;
}
/**
 *  返回行间距
 */
-(CGFloat)rowSpaceInXZMFlowLayout:(XZMFlowLayout *)flowLayout{
    
    return 10;
}
/**
 *  返回列间距
 */
-(CGFloat)columnSpaceInXZMFlowLayout:(XZMFlowLayout *)flowLayout{
    
    return 10;
}
/**
 *  返回边缘距离
 */
-(UIEdgeInsets)edgeInsetInXZMFlowLayout:(XZMFlowLayout *)flowLayout{
    
    return UIEdgeInsetsMake(20, 10, 10, 10);
}

@end
