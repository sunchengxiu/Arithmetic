//
//  SCXGraph.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/8/2.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// V:顶点 E:边
@interface SCXGraph<V,E> : NSObject

/// 顶点数
- (NSUInteger)verticesSize;

/// 边的个数
- (NSUInteger)edgesSize;

/// 添加顶点
/// @param v 顶点
- (void)addVertex:(V)v;

/// 添加边
/// @param from 边的起点
/// @param to 边的终点
- (void)addEdge:(V)from to:(V)to;

/// 添加边，带有权重
/// @param from 边的起点
/// @param to 边的终点
/// @param weight 权值
- (void)addEdge:(V)from to:(V)to weigth:(E)weight;

/// 移除顶点
/// @param v 要移除的顶点
- (void)removeVertex:(V)v;

/// 移除一条边
/// @param from 边的起点
/// @param to 边的终点
- (void)removeEdge:(V)from to:(V)to;

/// 打印图
- (void)printGraph;
@end

NS_ASSUME_NONNULL_END
