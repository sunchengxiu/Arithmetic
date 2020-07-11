//
//  SCXBinaryHeap.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/6/30.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXBinaryHeapInterface.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SCXBinaryHeapDelegate;

/// https://www.jianshu.com/p/16cc93f0bf60

/// 这里演示最大堆，如果最小堆，将compare的比较相反就可以了
@interface SCXBinaryHeap : NSObject<SCXBinaryHeapInterface>
-(instancetype)init NS_UNAVAILABLE;
+(instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithDelegate:(id <SCXBinaryHeapDelegate>)delegate;
// 批量建堆
/*
 自上而下的上滤：拿出数组的第一个元素，然后依次第二个第三个，和前面的元素比，如果比前面的元素大就上滤，依次,时间复杂度nlogn，其实就是深度之和，
 自下而上的下滤：拿出数组的最后一个元素，如果发现比下面的小，就下滤，一般从数组一半开始，也就是从非叶子节点开始，因为飞叶子节点才有叶子节点，才可以 下滤，长度的一半即为非叶子节点的数量。O(n)，其实就是所有节点的高度之和
 */
- (instancetype)initWithArray:(NSArray *)arr delegate:(id <SCXBinaryHeapDelegate>)delegate;
@end
@protocol SCXBinaryHeapDelegate <NSObject>
@required

/// A 和 B 比较，返回 > 0 , 表示 A > B,否则 A < B
/// @param valueA A
/// @param valueB B
- (BOOL)compareA:(id)valueA valueB:(id)valueB;

@end
NS_ASSUME_NONNULL_END
