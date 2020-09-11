//
//  SCXMinCoins.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/9/11.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXMinCoins.h"

@implementation SCXMinCoins
//https://leetcode-cn.com/problems/coin-change/solution/322-ling-qian-dui-huan-by-leetcode-solution/
/*如果arr为空，或长度为0，或aim<1，不需要任何货币，返回0。
对于N*（aim+1）的dp矩阵，
1）dp[0][0,..aim+1]表示只能用货币arr[0]来找aim值的最小货币数。可以看出，只有当aim为arr[0]的倍数时，才找得开，这些位置为1,2,3，…。而其他不是倍数的地方，aim是找不开的，即不存在最小货币数，无解，我们设为max=Intefer.MAX_VALUE，表示32位整数的最大值，即2^31-1=2147483647。
2）dp[0,..N][0]表示aim为0需要的最小货币数，即不需要找，应该全为0。
3）对于i>0，j>0的行，我们从左往右，从上到下进行计算。对于位置(i，j），最小货币数dp[i][j]的值可能来自以下几种情况之一：
（1）完全不使用当前货币arr[i]，只使用arr[0,…i-1]货币的情况下的最少张数，即dp[i-1][j]的值；
（2）使用1张当前货币arr[i]情况下的最少张数，即dp[i-1][j-arr[i]]+1;（考虑dp[i-1][j-arr[i]]，返回到上次未使用arr[i]的地方，即第i-1行，这个值代表可以任意使用arr[0,..i-1]情况下，组成钱数j-arr[i]所需的最小张数。从钱数为j-arr[i]到钱数为j，只需要加上当前货币arr[i]。所以dp[i][j]可能等于dp[i-1][j-arr[i]]+1。）
（3）使用2张当前货币arr[i]情况下的最少张数，即dp[i-1][j-2*arr[i]]+2;
以此类推，在所有情况中，取张数最小的，即
dp[i][j]=min{dp[i-1][j-k*arr[i]] + k},其中0<=k
化简上面这个式子:
dp[i][j]=min{dp[i-1][j],min{dp[i-1][j-k*arr[i]]+k}},其中k>=1
dp[i][j]=min{dp[i-1][j],min{dp[i-1][j-(y+1)*arr[i]]+(y+1)}}
=min{dp[i-1][j],min{dp[i-1][j-y*arr[i]-arr[i]]+y+1}},其中y>=0
又因dp[i-1][j-yarr[i]]+y=dp[i][j]，（考虑dp[i-1][j-y\arr[i]](返回到上次未使用y*arr[i]的地方，即第[i-1]行），这个值代表可以任意使用arr[0,..i-1]情况下，组成钱数j-y*arr[i]所需的最小张数。从钱数为j-y*arr[i]到钱数为j，只需要加上k张当前货币y*arr[i]。所以dp[i][j]可能等于dp[i-1][j-y*arr[i]]。）
min{dp[i-1][j-arr[i]-y*arr[i]]+y}=dp[i][j-arr[i]],其中y>=0
最终得到:
dp[i][j]=min{dp[i-1][j],dp[i][j-arr[i]]+1}.
如果j-arr[i]<0表示arr[i]太大，用一张都会超过aim=j的值，令dp[i][j]=dp[i-1][j]即可。
4）若最终不存在最少货币数，返回-1；存在的话，则返回最小货币数。（注意计算过程中是用max表示不存在，而最终为了好看，不存在用-1表示）
 */



/*
  1,2,5 -> 11
 f[11] = min{f[11- 1] , f[11 - 2], f[11 -5]} + 1 ;
 dp[i] = min{dp[i],dp[i - coins[j]] + 1}
 */
/*
 输入: coins = [1, 2, 5], amount = 11
 输出: 3
 解释: 11 = 5 + 5 + 1
 */
- (int)coins:(NSArray *)coins amount:(int)amount {
    int all = amount + 1;
    NSMutableArray *dp = [NSMutableArray arrayWithCapacity:all];
    for(int i = 0; i < all ;i ++) {
        dp[i] = @(amount + 1);
    }
    // 金额0不能又硬币组成
    dp[0] = @0;
    for(int i = 1 ; i <= amount ; i ++) {
        for( int j = 0 ; j< coins.count ; j ++) {
            if(i >= ((NSNumber *)coins[j]).intValue) {
                int cur = ((NSNumber *)dp[i]).intValue;
                int coinValue = ((NSNumber *)coins[j]).intValue;
                int preDp = (i - coinValue) >= 0 ? ((NSNumber *)dp[i - coinValue]).intValue : all;
                int pre = preDp + 1;
                NSNumber *dpi = [NSNumber numberWithInt:MIN(cur, pre)];
                dp[i] = dpi;
            }
        }
    }
    return ((NSNumber *)dp[amount]).intValue;;
}
@end
