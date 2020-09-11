//
//  SCXPalindrome.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/9/10.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXPalindrome.h"

@implementation SCXPalindrome
- (BOOL)palindrome:(NSString *)str {
    int count = str.length;
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0 ; i < count; i ++) {
        arr1[i] = @0;
    }
    NSMutableArray *dp = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        [dp addObject:arr1.mutableCopy];
    }
    int max = 0;
    NSString *maxStr;
    // 1. 如果 dp[i][j] 为回文，那么dp[i+1][j-1] 也一定是回文;
    for (int i = 0; i < count; i ++) {
        dp[i][i] = @1;
        for (int j = 0; j < i; j ++) {
            NSString *pre = [str substringWithRange:NSMakeRange(j, 1)];
            NSString *end = [str substringWithRange:NSMakeRange(i, 1)];
            // [i][j] 或者 [i + 1][j-1] 为回文，或者长度为1，也一定是回文
            if ([pre isEqualToString:end]) {
                NSLog(@"");
            }
            if ([pre isEqualToString:end] && ((i - j < 2) || ((NSNumber *)dp[j + 1][i - 1]).intValue)) {
                dp[j][i] = @1;
            }
            if (((NSNumber *)dp[j][i]).intValue) {
                if (i - j + 1> max) {
                    maxStr = [str substringWithRange:NSMakeRange(j, i - j + 1)];
                }
                max = MAX(max, i - j +1);
            }
        }
    }
    NSLog(@"------%d",max);
    NSLog(@"~~~~~~%@",maxStr);
    return max == str.length ? YES : NO;
}
@end
