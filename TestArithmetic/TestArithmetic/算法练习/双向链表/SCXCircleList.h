//
//  SCXCircleList.h
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/19.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCXCircleList : NSObject

/**
 size
 */
@property(nonatomic , assign , readonly)int count;

/**
 first
 */
@property(nonatomic , strong , readonly)id firstObject;

/**
 lastNode
 */
@property(nonatomic , strong , readonly)id lastObject;
/// 头插法
/// @param object 插入的节点
- (id)addToHead:(id)object;

/// 尾插法
/// @param object 插入的节点
- (id)addToTail:(id)object;

/// 移除某个位置的元素
/// @param index 位置
- (id)removeObjectAtIndex:(NSInteger)index;

/// 某个额位置的元素
/// @param index 位置
- (id)objectAtIndex:(NSInteger)index;

/// 移除头结点
- (id)removeFirstObject;

/// 移除尾结点
- (id)removeLastObject;

/// 添加到某个位置
/// @param object 元素
/// @param index 位置
- (id)addObject:(id)object atIndex:(NSInteger)index;

/// 更新某个位置的元素
/// @param object 元素
/// @param index 位置
- (id)setObject:(id)object atIndex:(NSInteger)index;

/// 删除某个值
/// @param object 要删除的值
- (void)deleteObject:(id)object;

/// 是否包含某个值
/// @param object 检测s的值
- (BOOL)containObject:(id)object;

/// 某个元素在链表中的位置
/// @param object 查找的元素
- (NSInteger)indexOfObject:(id)object;

/// 清空链表
- (void)clear;

/// 链表是否有环
- (BOOL)hasCircle;


/// 重置
- (void)reset;

/// next
- (id)next;

@end

NS_ASSUME_NONNULL_END
