//
//  XZMFlowLayout.h
//  CollectViewLayOut
//
//  Created by xzm on 16/2/19.
//  Copyright © 2016年 ypwl. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  UICollectionViewFlowLayout :是系统基于UICollectionViewLayout封装的流水布局（竖向滑动是按行排列：一行一行排，第一行排满再从第二行第一个开始排，以此类推；  横向滑动则是按列排布：一列一列排，第一列排满再从第二列第一行开始排）
 *
 * 瀑布流：也是基于UICollectionViewLayout来封装，需要自己写布局算法（原理：每次找出高度最小的那一列，然后排在那一列的下面，再更新那个最小一列的高度，然后再找出高度最小一列，以此类推）
 */
@class XZMFlowLayout;

@protocol XZMFlowLayoutDelegate <NSObject>

@required
/**
 *  返回每个item的高度，必须实现
 */
-(CGFloat)XZMFlowLayout:(XZMFlowLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath WithItemWidth:(CGFloat)itemWidth;

@optional
/**
 *  返回列数
 */
-(NSInteger)numberOfColumnsInXZMFlowLayout:(XZMFlowLayout *)flowLayout;
/**
 *  返回行间距
 */
-(CGFloat)rowSpaceInXZMFlowLayout:(XZMFlowLayout *)flowLayout;
/**
 *  返回列间距
 */
-(CGFloat)columnSpaceInXZMFlowLayout:(XZMFlowLayout *)flowLayout;
/**
 *  返回边缘距离
 */
-(UIEdgeInsets)edgeInsetInXZMFlowLayout:(XZMFlowLayout *)flowLayout;

@end


@interface XZMFlowLayout : UICollectionViewLayout

@property(nonatomic,weak)id<XZMFlowLayoutDelegate>delegate;

@end
