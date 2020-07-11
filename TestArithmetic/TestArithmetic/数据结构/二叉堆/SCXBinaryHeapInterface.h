//
//  SCXBinaryHeapInterface.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/6/30.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 二叉堆的接口，
@protocol SCXBinaryHeapInterface <NSObject>

@required
/// 二叉堆大小
- (NSInteger)size;

/// 二叉堆是否为空
- (BOOL)isEmpty;

/// 清空二叉堆
- (void)clear;

/// 添加元素
/// @param object 要添加的元素
- (void)add:(id)object;

/// 获取堆顶元素
- (id)getTopObject;

/// 移除堆顶元素
- (id)removeTopObject;

/// 替换堆顶元素
/// @param object 原堆顶元素
- (id)replaceTopObject:(id)object;
@end

NS_ASSUME_NONNULL_END
