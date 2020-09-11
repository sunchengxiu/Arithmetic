//
//  SCXShortest.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/9/11.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXShortest.h"

@implementation SCXShortest
/*
 矩阵最短路径：
 M ,N 分别代表矩阵的行和列数 dp[i][j] 表示从左上角到矩阵（i，j）位置是的最短路径和。则可知 到（i，j）位置有两种情况：1）由（i-1，j）向下走，2）由（i，j-1）向右走，所以dp[i][j]=Math.min（dp[i-1][j],dp[i][j-1]）+m[i][j];对于dp[0][j] 只能由 dp[0][j-1] 向右走，dp[i][0] 只能由 dp[i-1][0] 向下走。所以 dp[0][j]=dp[0][j-1]+m[0][j], dp[i][0]=dp[i-1][0]+m[i][0].
 */
- (int)shortest:(NSArray *)arr {
    int row = arr.count;
    int col = ((NSArray *)(arr[0])).count;
    // 构造dp
    NSMutableArray *dp = [NSMutableArray arrayWithCapacity:row];
    for (int i = 0 ; i < row; i++) {
        NSMutableArray *dpCol = [NSMutableArray arrayWithCapacity:col];
        for (int j = 0 ; j < col; j ++) {
            dpCol[j] = @0;
        }
        [dp addObject:dpCol.mutableCopy];
    }
    // [0][0] 位置的权值就为arr[0][0]
    dp[0][0] = arr[0][0];
    // 第 0列，只能从上往下走
    for (int i = 1 ; i < row; i++) {
        dp[i][0] = [NSNumber numberWithInt:((NSNumber *)dp[i - 1][0]).intValue + ((NSNumber *)arr[i][0]).intValue];
    }
    // 第一行，只能从左往右走
    for (int i = 1 ; i < col; i++) {
        dp[0][i] = [NSNumber numberWithInt:((NSNumber *)dp[0][i - 1]).intValue + ((NSNumber *)arr[0][i]).intValue];
    }
    // 从上往下和从左往右都可以
    for (int i = 1; i < row; i ++) {
        for (int j = 1; j < col; j ++) {
            // 从左往右和从上往下的最小值
            dp[i][j] = [NSNumber numberWithInt:MIN(((NSNumber *)dp[i - 1][j]).intValue, ((NSNumber *)dp[i][j - 1]).intValue) + ((NSNumber *)arr[i][j]).intValue];
        }
    }
    return ((NSNumber *)dp[row - 1][col - 1]).intValue;
}
@end
