//
//  SCXSelectionSoft.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/11.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXSelectionSoft.h"

@implementation SCXSelectionSoft
-(NSArray *)soft:(NSArray *)arr{
    NSMutableArray *soft = arr.mutableCopy;
    // 需要遍历多少趟
    for (int i = soft.count - 1; i > 0; i --) {
        
        // 假设最大的是第一个元素
        int index = 0;
        // 每次遍历除了最后几个已经排好序的元素之外，其余的元素
        // 如果当前的元素比最大值的这个位置的元素要大，更改最大值的位置，继续遍历
        // 这里是选择最大值，这里可以做优化，因为选择最大值，使用堆时间复杂度为logn
        for (int j = 1 ; j <= i; j ++) {
            NSNumber *current = soft[j];
            NSNumber *max = soft[index];
            if (current.intValue > max.intValue) {
                index = j;
            }
        }
        // 找到最大元素的位置，将其放到最后
        if (index != i) {
            NSNumber *tmp = soft[i];
            soft[i] = soft[index];
            soft[index] = tmp;
        }
    }
    return soft.copy;
}
@end
