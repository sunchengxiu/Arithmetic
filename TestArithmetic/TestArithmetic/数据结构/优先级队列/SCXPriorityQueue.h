//
//  SCXPriorityQueue.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/7.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SCXPriorityQueueDelegate ;
@interface SCXPriorityQueue<Value> : NSObject
-(instancetype)init NS_UNAVAILABLE;
+(instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithDelegate:(id <SCXPriorityQueueDelegate>)delegate;
- (NSInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (void)enQueue:(Value)obj;
- (Value)deQueue;
- (Value)front;
@end
@protocol SCXPriorityQueueDelegate <NSObject>
@required

/// A 和 B 比较，返回 > 0 , 表示 A > B,否则 A < B
/// @param valueA A
/// @param valueB B
- (BOOL)compareA:(id)valueA valueB:(id)valueB;

@end
NS_ASSUME_NONNULL_END
