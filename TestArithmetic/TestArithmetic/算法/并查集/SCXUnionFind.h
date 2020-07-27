//
//  SCXUnionFind.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/27.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
                    0 --- 1            6                        8 --- 10
                /   |                  |                        |   /
               /    |   /2\            7                        9------11
              4     3 /    5
 */
@interface SCXUnionFind : NSObject

/// 初始化
/// @param capicity 容量
- (instancetype)initWithCapicity:(NSUInteger)capicity;

/// 查找元素
/// @param v 返回根节点
- (NSUInteger)find:(NSUInteger)v;
- (void)unionValue:(NSUInteger)value1 value2:(NSUInteger)value2;
- (BOOL)isSame:(NSUInteger)v1 value2:(NSUInteger)v2;
@end

NS_ASSUME_NONNULL_END
