//
//  SCXCircleDeque.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/3/29.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 环形双端队列
@interface SCXCircleDeque<ObjectType> : NSObject
-(instancetype)init NS_UNAVAILABLE;
+(instancetype)new NS_UNAVAILABLE;

/// 默认初始化方法
/// @param capacity 队列的容量
- (instancetype)initWithArrayCapacity:(NSInteger)capacity;

/// 类初始化方法
/// @param capacity 队列容量
+ (instancetype)arrayQueueWithCapacity:(NSInteger)capacity;

/// 默认类初始化方法  ，默认容量为20
+ (instancetype)arrayQueue;

/// 入队（从尾部）
/// @param obj 入队对象
- (void)enqueue:(ObjectType)obj;

/// 出对（从头部）
- (id)dequeue;

/// 入队（从头部），如果当前在0位置，则相当于从队尾入队
/// @param obj 入队对象
- (void)enqueueFromFront:(ObjectType)obj;

/// 出对（从尾部）
- (id)dequeueFromTail;

/// 清空队列
- (void) removeAllObjects;

/// 对头
@property (nonatomic,weak,readonly)ObjectType firstObject;

/// 队列所有元素个数
@property (nonatomic,assign,readonly)int size;

/// 队列头结点
@property(nonatomic,strong,readonly)ObjectType front;

/// 队列尾结点
@property(nonatomic,strong,readonly)ObjectType tail;

/// 队列总容量
@property(nonatomic,assign,readonly)int capacity;

/// 队列总使用容量
@property(nonatomic,assign,readonly)int count;

@end

NS_ASSUME_NONNULL_END
