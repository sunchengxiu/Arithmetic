//
//  SCXLCS.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/9/13.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXLCS.h"
//https://leetcode-cn.com/problems/longest-common-subsequence/solution/dong-tai-gui-hua-zhi-zui-chang-gong-gong-zi-xu-lie/
//https://leetcode-cn.com/problems/longest-common-subsequence/solution/dong-tai-gui-hua-tu-wen-jie-xi-by-yijiaoqian/
@implementation SCXLCS
// 最长公共子序列
//我们会发现遍历两个串字符，当不同时需要考虑两层遍历前面的值（关系传递），也就是左边和上边的其中较大的值，当想相同时，需要考虑各自不包含当前字符串的子序列长度，再加上1。
/*
 因此可以得出：
 现在对比的这两个字符不相同的，那么我们要取它的「要么是text1往前退一格，要么是text2往前退一格，两个的最大值」
 dp[i + 1][j + 1] = Math.max(dp[i+1][j], dp[i][j+1]);

 对比的两个字符相同，去找它们前面各退一格的值加1即可：dp[i+1][j+1] = dp[i][j] + 1;

 */
/*
 输入：text1 = "abcde", text2 = "ace"
 输出：3
 解释：最长公共子序列是 "ace"，它的长度为 3。
 */
- (int)LCS:(NSString *)str1 str2:(NSString *)str2 {
    int m = str1.length;
    int n = str2.length;
    // 构造 dp 二维矩阵
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0 ; i < n + 1 ; i ++) {
        [arr addObject:@0];
    }
    NSMutableArray *dp =[NSMutableArray array];
    for (int i = 0 ; i < m + 1; i ++) {
        [dp addObject:arr.mutableCopy];
    }
    // 转移方程
    for (int i = 0; i < m ; i ++) {
        for (int j = 0; j < n ; j ++) {
            // 判断是否相等
            NSString *mstr = [str1 substringWithRange:NSMakeRange(i , 1)];
            NSString *nstr = [str2 substringWithRange:NSMakeRange(j, 1)];
            if ([mstr isEqualToString: nstr]) {
                dp[i + 1][j + 1] = [NSNumber numberWithInt:((NSNumber *)dp[i ][j]).intValue + 1];
            } else {
                // 左边或者上边转移过来
                dp[i + 1][j + 1] = [NSNumber numberWithInt:MAX(((NSNumber *)dp[i ][j + 1]).intValue, ((NSNumber *)dp[i + 1][j]).intValue) ];
            }
        }
    }
    return ((NSNumber *)dp[m][n]).intValue;;
}
@end
