//
//  SCXQuickSoft.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/14.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXQuickSoft.h"
@interface SCXQuickSoft()
@property(nonatomic,strong) NSMutableArray *softArr;
@end
@implementation SCXQuickSoft
-(NSArray *)soft:(NSArray<NSNumber *> *)arr{
    NSMutableArray *soft = arr.mutableCopy;
    self.softArr = soft;
    [self beginSoft:0 end:soft.count];
    return soft.copy;
}
- (void)beginSoft:(NSInteger)begin end:(NSInteger)end{
    if (end - begin < 2) {
        return;
    }
    // 找到轴点，然后依次在进行分割
    // 时间复杂度 O(n)
    NSInteger pivotIndex = [self pivotIndex:begin end:end];
    // 左半边
    // T(n/2)
    [self beginSoft:begin end:pivotIndex];
    // 右半边
    // T(n/2)
    [self beginSoft:pivotIndex+1 end:end];
    // 如果左右分布均匀，此时为最好的情况想，总时间复杂度 T(n) = 2 * T(n/2) + O(n) = O(nlogn)
    // 如果分布不均匀，如，7，6，5，4，3，2，1，7 为轴点，7右边的都比7小，那么需要将每一个都调到7的左边
    // T(n) = T(n - 1) + O(n) =O(n^2)
}

/// 获取轴点位置，也就是那个分割点的位置，每次将序列分为两个，这个分割点的左边都比这个轴点小，右边都比这个轴点大
/// @param begin 开始位置
/// @param end 结束位置
- (NSInteger)pivotIndex:(NSInteger)begin end:(NSInteger)end{
    /*
     1.取出第一元素来一次进行比较，从后往前比较
     2.如果后面的元素比当前元素大，那么不用动，然后end--
     ,如果发现后面的元素小于等于当前轴点元素，那么将end的位置的元素，
     覆盖当前begin位置的元素，然后从begin开始比较,
     调到步骤3
     3.如果发现当前元素大小比轴点元素大小小，那么begin++，
     如果当前元素比轴点元素大，那么将begin位置的元素赋值给end，
     然后再从end往回比较，
     调到步骤2.
     
     */
    
    // 为了优化，随机选择一个元素和begin位置元素作为交换，不要每次都选第一个，有局限性
    int rand = begin + (arc4random() %(end - begin + 1));
    NSNumber *tmp = self.softArr[begin];
    self.softArr[begin] = self.softArr[rand];
    self.softArr[rand] = tmp;
    
    // 1. 取出来第一个元素，当做轴点元素,备份
    NSNumber *first = self.softArr[begin];
    // 最后一个元素的位置
    end --;
    // begin 和 end 没有重合
    while (begin < end) {
        // 最后一个元素，从后往前走
        while (begin < end) {
            // 取出最后一个元素，然后和轴点元素比较
            NSNumber *last = self.softArr[end];
            // 2. 从后往前比较，如果后面的比前面大，那么不用交换，end--
            if (last.intValue > first.intValue) {
                // 2. 后面的大，一直往前走就可以
                end --;
            } else {
                // 2. 后面的比前面的小或者等于，需要调换位置
                // 2. 将end元素覆盖到begin位置，然后begin++，然后调用，从begin开始，从前往后比较。
                self.softArr[begin++] = last;
                break;
            }
        }
        
        // 如果这时候begin和end重合了，那么久说明找到了
        // 3.如果没有重合，就说明掉头了，需要从前往后走
        while (begin < end) {
            // 3。取出第一个元素，和当前轴点元素作比较
            NSNumber *last = self.softArr[begin];
            // 3.如果当前元素比轴点元素小，那么只需要begin++ 就可以，继续向后找
            // 等于放到下面是为了均匀分割，分布均匀之后，效率会大大增高，差别很大
            if (first.intValue > last.intValue) {
                begin ++;
            } else {
                // 3. 如果当前位置元素比轴点元素大，那么需要将这个begin位置的元素，覆盖到end位置，然后end--；
                // 2. 然后跳到步骤2，从后往前走
                self.softArr[end--] = last;
                break;;
            }
        }
        
    }
    // 然后将备份的元素放到轴点位置
    self.softArr[begin] = first;
    // 当开始哨兵和结束的哨兵位置重合的时候，就是轴点的位置，说明已经分割好了
    return begin;
}
@end
