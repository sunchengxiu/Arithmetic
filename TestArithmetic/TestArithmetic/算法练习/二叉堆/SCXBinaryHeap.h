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
@interface SCXBinaryHeap : NSObject<SCXBinaryHeapInterface>
-(instancetype)init NS_UNAVAILABLE;
+(instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithDelegate:(id <SCXBinaryHeapDelegate>)delegate;
@end
@protocol SCXBinaryHeapDelegate <NSObject>
@required

/// A 和 B 比较，返回 > 0 , 表示 A > B,否则 A < B
/// @param valueA A
/// @param valueB B
- (BOOL)compareA:(id)valueA valueB:(id)valueB;

@end
NS_ASSUME_NONNULL_END
