//
//  XZMFlowLayout.m
//  CollectViewLayOut
//
//  Created by xzm on 16/2/19.
//  Copyright © 2016年 ypwl. All rights reserved.
//

#import "XZMFlowLayout.h"

@interface XZMFlowLayout ()

@property (nonatomic,strong)NSMutableArray *attrArr; //所有布局属性

@property (nonatomic,strong)NSMutableArray *allColumnHeight; //所有列数高度数组

-(NSInteger)columnNumbers;

-(CGFloat)rowSpace;

-(CGFloat)columnSpace;

-(UIEdgeInsets)edgeInset;

@end

@implementation XZMFlowLayout
/**
 *  列数
 */
static const NSInteger columnNumbers = 3;
/**
 *  行间距
 */
static const CGFloat rowSpace = 10;
/**
 *  列间距
 */
static const CGFloat columnSpace = 10;
/**
 *  collectionView边缘间距
 */
static const UIEdgeInsets defaultInset = {10,10,10,10};

#pragma mark -- get

-(NSMutableArray *)attrArr{
    
    if (_attrArr == nil) {
        
        _attrArr = [NSMutableArray array];
        
    }
    
    return _attrArr;
}

- (NSMutableArray *)allColumnHeight {
    
    if(_allColumnHeight == nil) {
        
        _allColumnHeight = [[NSMutableArray alloc] init];
        
    }
    
    return _allColumnHeight;
}
/**
 *  获取列数
 */
-(NSInteger)columnNumbers{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfColumnsInXZMFlowLayout:)]) {
        
        return [self.delegate numberOfColumnsInXZMFlowLayout:self];
        
    }else{
        
        return columnNumbers;
    }
}
/**
 *  获取行间距
 */
-(CGFloat)rowSpace{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rowSpaceInXZMFlowLayout:)]) {
        
        return [self.delegate rowSpaceInXZMFlowLayout:self];
        
    }else{
        
        return rowSpace;
    }
}
/**
 *  获取列间距
 */
-(CGFloat)columnSpace{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(columnSpaceInXZMFlowLayout:)]) {
        
        return [self.delegate columnSpaceInXZMFlowLayout:self];
        
    }else{
        
        return columnSpace;
    }
}
/**
 *  获取边缘间距
 */
-(UIEdgeInsets)edgeInset{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(edgeInsetInXZMFlowLayout:)]) {
        
        return [self.delegate edgeInsetInXZMFlowLayout:self];
        
    }else{
        
        return defaultInset;
    }
}

/**
 *  准备开始布局,刷新的的时候调用
 */
-(void)prepareLayout{
    
    [super prepareLayout];
    
    [self.attrArr removeAllObjects];
    
    [self.allColumnHeight removeAllObjects];
    
    for (int i = 0 ; i < self.columnNumbers; i ++) {
        
        [self.allColumnHeight addObject:[NSNumber numberWithInteger:self.edgeInset.top]];
    }
    
    //获取colletionView的item个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i ++) {
        
        UICollectionViewLayoutAttributes *layoutAtt = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        [self.attrArr addObject:layoutAtt];
    }
    
}

/**
 *  返回所有cell的布局属性,决定cell的排布
 */
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attrArr;
    
}

/**
 *  返回每个indexPath对应cell的布局属性
 */
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *layoutAtt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat contentW = self.collectionView.frame.size.width;
    
    CGFloat w = (contentW - self.edgeInset.left - self.edgeInset.right  - (self.columnNumbers-1)*self.columnSpace)/self.columnNumbers;
    
    CGFloat h = [self.delegate XZMFlowLayout:self heightForItemAtIndexPath:indexPath WithItemWidth:w];
    
    //找出高度最小的那一列和最小一列的高度
    CGFloat minHeight = [self.allColumnHeight.firstObject floatValue];
    
    NSInteger minHeightColumn = 0;
    
    for (int i = 1; i < self.allColumnHeight.count; i ++) {
        
        CGFloat tempHeight = [self.allColumnHeight[i] floatValue];
        
        if (tempHeight < minHeight) {
            
            minHeight = tempHeight;
            
            minHeightColumn = i;
        }
    }
    
    CGFloat x = self.edgeInset.left + (w + self.columnSpace)*minHeightColumn;
    
    CGFloat y = minHeight == self.edgeInset.top ? minHeight : minHeight + self.rowSpace;
    
    layoutAtt.frame = CGRectMake(x, y, w, h);
    
    //每次计算完之后更新高度最小一列的高度
    self.allColumnHeight[minHeightColumn] = @(CGRectGetMaxY(layoutAtt.frame));
    
    return layoutAtt;
}
/**
 *  设置contentSize
 *
 *  @return contentSize
 */
-(CGSize)collectionViewContentSize{
    
    //找出高度最大的那一列的高度,首先拿到第一列的高度
    CGFloat maxHeight = [self.allColumnHeight.firstObject floatValue];
    
    for (int i = 1; i < self.allColumnHeight.count; i ++) {
        
        CGFloat tempHeight = [self.allColumnHeight[i] floatValue];
        
        if (tempHeight > maxHeight) {
            
            maxHeight = tempHeight;
            
        }
    }
    
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight + self.edgeInset.bottom);

}


@end
