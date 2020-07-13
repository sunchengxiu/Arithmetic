//
//  SCXMergeSoft.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/13.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXMergeSoft.h"
/*
 1. 不断的将当前序列，分割成两个子序列,直到分割到一个元素不能分割为止
 2. 不断的将两个子序列合并成一个有序序列，直到最后只剩下一个有序序列
 */
@interface SCXMergeSoft()
@property (nonatomic , strong) NSMutableArray *softArr;
@property (nonatomic , strong) NSMutableArray *leftArr;
@end
@implementation SCXMergeSoft
- (NSArray *)soft:(NSArray<NSNumber *> *)arr{
    NSMutableArray *soft = arr.mutableCopy;
    self.softArr = soft;
    self.leftArr = [NSMutableArray arrayWithCapacity:(soft.count) >> 1];
    [self binary:0 end:soft.count];
    return soft.copy;;
}
- (void)binary:(int)begin end:(int) end{
    // 至少要有两个元素
    if (end - begin < 2) {
        return;
    }
    int mid = (end + begin ) >> 1;
    // 将左边的不断的拆分，直到拆分到一个元素
    [self binary:begin end:mid];
    // 将右边的不断的拆分，直到拆分到一个元素
    [self binary:mid end:end];
    // 不断的将两个元素合并
    [self merge:begin mid:mid end:end];
}
/*
 merge 的原理:
 比如一个数组[1,6,2,7,3,8,4,9];
 1.我们经过不断的拆分之后变成1,6  2,7 3,8 4,9 ,这样的
 2. 然后将上面拆分出来的一个一个数据，两个连个再次合并到一起，[1,6],[2,7],[3,8],[4,9]
 然后再变成[1,2,6,7],[3,4,8,9]
 然后再变成[1,2,3,4,6,7,8,9];
 这个流程
 3.其实我们最终的目的其实就是将所有的元素合并到一个大数组里面，其实我们的最后[1,2,3,4,6,7,8,9];，一次，这个数据就是最终的大数组，而他是由之前的两份数据得来的，所以我们可以将大数组拆分成一个小数组，然后每次将小数组的元素和当前大数组剩余的元素作比较，然后依次比较添加，什么意思呢？
 
 将 [1,2,3,4,6,7,8,9]; ，的左一半copy出来，其余元素不变，也就是
 [1,2,3,4,6,7,8,9]; 和 [1,2,3,4,];
 或者你可以理解为
 [null,null,null,null,6,7,8,9]; 和 [1,2,3,4]; 最后将这两个合并不就是 [1,2,3,4,6,7,8,9];吗
 
 
 */
- (void)merge:(int)begin mid:(int)mid end:(int) end{
    // 定义标记,对应于数组的索引
    // 左边的开始位置的标记
    int lb = 0;
    // 左边的结束位置的标记
    int le = mid - begin;
    // 右边开始位置的标记
    int rb = mid;
    // 右边结束位置的标记
    int re = end;
    // 整个大数组的标记
    int ab = begin;
    
    // 左边备份的数组
    for (int i = lb; i < le; i ++) {
        self.leftArr[i] = self.softArr[begin + i];
    }
    NSLog(@"----%@",self.leftArr);
    // 左右进行比对
    while (lb < le) {
        // 左边没有排完，就将左边的依次放到大数组里面
        // 如果左边排完了，右边不动就行
        // 判断如果左边拿出来的元素比右边拿出来的元素小，就放到大数组里面
        NSNumber *left = self.leftArr[lb];
        NSNumber *right = self.softArr[rb];
        // 如果右边的大或者右边排完了，那么就跳出来这if，跑到下面去，因为右边的大，肯定是将左边放进去，或者右边的所有元素都取完了，那么也跑到else里面
        if (rb< re && left.intValue > right.intValue ) {
            // 如果左边的大于等于右边的，就将右边的放入大数组的前面
            self.softArr[ab++] = right;
            rb++;
        } else {
            // 如果右边的比左边大或者等于左边当前取出的，就将左边的先取出来放到数组里面，这样可以保证算法的稳定性
            self.softArr[ab++] = left;
            lb++;
            
        }
    }
    NSLog(@"~~~~~%@",self.softArr);
}
@end
