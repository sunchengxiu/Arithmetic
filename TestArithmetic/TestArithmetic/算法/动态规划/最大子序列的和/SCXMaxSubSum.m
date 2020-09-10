//
//  SCXMaxSubSum.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/9/10.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXMaxSubSum.h"

@implementation SCXMaxSubSum
- (NSInteger)maxSubSum:(NSArray *)sub {
    if (!sub || sub.count <= 0) {
        return 0;;
    }
    // 动态规划，最大连续子序列的和
    // 1. 如果前面的值小于0，那么最大子序列的和一定是本身
    // 2. 如果前面的值大于0，那么最大子序列的和，为前面最大子序列的和+当前值
    NSMutableArray *dp = [NSMutableArray arrayWithCapacity:sub.count];
    for (int i = 0 ; i < sub.count; i ++) {
        dp[i] = @0;
    }
    int max = 0;
    for (int i = 1 ; i < sub.count; i ++) {
        int pre = ((NSNumber *)(dp[i - 1])).intValue;
        if (pre <= 0) {
            dp[i] = sub[i];
        } else {
            dp[i] = [NSNumber numberWithInt:pre + ((NSNumber *)sub[i]).intValue];
        }
        max = MAX(max, ((NSNumber *)dp[i]).intValue);
    }
    return max;
}
@end
