//
//  SCXLengthOfLIS.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/9/10.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXLengthOfLIS.h"

@implementation SCXLengthOfLIS
- (int)lengthOfLIS:(NSArray *)arr {
    if (!arr || arr.count <= 0) {
        return 0;
    }
    NSMutableArray *dp = arr.mutableCopy;
    for (int i = 0; i < arr.count; i ++) {
        dp[i] = @0;
    }
    int max = 1;
    // 最长上升子序列
    // 1. 从头往后遍历，两层循环，第一层为所有数据，第二层end为第一层的begin，从第二层，依次往后找，
    // 如果当前值比第一层的当前值大，那么这个值就一定不再上升子序列里面，直接跳过这个值就可以
    // 2. 如果这个值比外层的值小，那么就为之前的最长上升子序列+1
    for (int i = 1; i < arr.count; i ++) {
        // 默认当前这个值的最长上升子序列为它自己也就是1
        dp[i] = @1;
        for (int j = 0; j < i; j ++) {
            int pre = ((NSNumber *)arr[j]).intValue;
            int cur = ((NSNumber *)arr[i]).intValue;
            // 不满足上升的条件
            if (pre >= cur) {
                continue;
            } else {
                // 最大值为要么是自己1，要么是之前的+1
                dp[i] = [NSNumber numberWithInt:MAX(((NSNumber *)dp[i]).intValue, ((NSNumber *)dp[j]).intValue + 1)];
            }
        }
        max = MAX(max, ((NSNumber *)dp[i]).intValue);
    }
    return max;
}
@end
