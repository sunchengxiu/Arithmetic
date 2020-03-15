//
//  SCXLinkList.h
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/12.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCXLinkList<ObjectType> : NSObject

/// 头插法
/// @param object 插入的节点
- (ObjectType)addToHead:(ObjectType)object;

/// 尾插法
/// @param object 插入的节点
- (ObjectType)addToTail:(ObjectType)object;

/// 移除某个位置的元素
/// @param index 位置
- (ObjectType)removeObjectAtIndex:(NSInteger)index;

/// 某个额位置的元素
/// @param index 位置
- (ObjectType)objectAtIndex:(NSInteger)index;

/// 移除头结点
- (ObjectType)removeFirstObject;

/// 移除尾结点
- (ObjectType)removeLastObject;

/// 添加到某个位置
/// @param object 元素
/// @param index 位置
- (ObjectType)addObject:(ObjectType)object atIndex:(NSInteger)index;

/// 更新某个位置的元素
/// @param object 元素
/// @param index 位置
- (ObjectType)setObject:(ObjectType)object atIndex:(NSInteger)index;

/// 删除某个值
/// @param object 要删除的值
- (void)deleteObject:(ObjectType)object;

/// 是否包含某个值
/// @param object 检测s的值
- (BOOL)containObject:(ObjectType)object;

/// 某个元素在链表中的位置
/// @param object 查找的元素
- (NSInteger)indexOfObject:(ObjectType)object;

/// 清空链表
- (void)clear;

/// 反转链表
- (void)reverseList;

@end

NS_ASSUME_NONNULL_END
