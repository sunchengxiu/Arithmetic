//
//  SCXInsertionSoft.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/12.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXInsertionSoft.h"

@implementation SCXInsertionSoft
// 插入排序更优的优化
- (NSArray *)soft:(NSArray<NSNumber *> *)arr{
    NSMutableArray *soft = arr.mutableCopy;
    for (int i = 1 ; i < soft.count; i ++) {
        // 原始位置元素
        NSNumber *cur = soft[i];
        // 从第一个位置开始查找当前这个位置的元素应该放的位置，因为是依次查找，所以顺便排序了
        // 这个当前元素应该插入的索引
        // 优化了比较次数
        int index = [self binarySearch:soft index:i];
        // 找到这个index之后开始挪动元素位置，区间为[index,begin);
        for (int j = i ; j > index; j --) {
            soft[j] = soft[j - 1];
        }
        soft[index] = cur;
    }
    return soft.copy;
}

/// 二分查找找到index位置应该插入的位置
/// @param arr 查找的数组
/// @param index 要查找区间最大值
/// @return 元素的索引
// 下面的另一个二分查找的方法有弊端，比如有重复的元素，1，2，3，5，5，5，5，5，6，7，8，其中有多个5，在我们二分查找的过程中可能元素个数的不同，返回5的索引位置也不同，这样是不行的，我们应该返回第一个元素的位置，不影响原来相同元素位置的排序，这样才是稳定的
- (int)binarySearch:(NSArray *)arr index:(int)index{
    if (arr == nil || arr.count <= 0 || index >= arr.count) {
        return -1;
    }
    NSNumber *obj = arr[index];
    // 开始索引
    int begin = 0;
    // 结束索引
    // 区间为[begin,end);,左闭由开
    int end = index;
    int value = obj.intValue;
    while (begin < end) {
        int mid = (begin + end) >> 1;
        NSNumber *midValue = arr[mid];
        // 要查找的值在左边
        if (value < midValue.intValue) {
            // 更改end的位置
            end = mid;
        } else {
            // 这里是找到第一个大于当前值得位置，因为如果valu比midValue大的话，那么插入的位置肯定在后面
            // 如果vaalue 和 midvalue 相等的话，我们这里也向后查找，如上面举的例子，存在好几个5，那么第一次出现5的位置并不一定是我们要找的位置，但是我们可以确定，一定在这个值得后面。
            // 要查找的值在右边
            // 更改begin的位置
            begin = mid + 1;
        }
    }
    return begin;
}
/// 二分查找
/// @param arr 查找的数组
/// @param obj 要查找的值
/// @return 元素的索引
- (int)binarySearch1:(NSArray *)arr obj1:(NSNumber *)obj{
    if (arr == nil || arr.count <= 0 || obj == nil) {
        return -1;
    }
    // 开始索引
    int begin = 0;
    // 结束索引
    // 区间为[begin,end);,左闭由开
    int end = arr.count;
    int value = obj.intValue;
    while (begin < end) {
        int mid = (begin + end) >> 1;
        NSNumber *midValue = arr[mid];
        // 要查找的值在左边
        if (value < midValue.intValue) {
            // 更改end的位置
            end = mid;
        } else if (value > midValue.intValue){
            // 要查找的值在右边
            // 更改begin的位置
            begin = mid + 1;
        } else {
            // 命中
            return mid;
        }
    }
    return -1;
}
// 插入排序优化
-(NSArray *)soft2:(NSArray<NSNumber *> *)arr{
    NSMutableArray *soft = arr.mutableCopy;
    // 插入排序的优化的思想就是将元素向后挪，挪出一个位置之后，再将待插入的元素放进去
    // 1，2，4，5，然后插入3,相当于,1,2,[],4,5,4和5，向后挪动了，中间留了一个位置给3，最后把3放进去
    for (int i = 1 ; i < soft.count - 1; i ++) {
        int index = i;
        // 当前待插入的元素
        NSNumber *cur = soft[index];
        while (index > 0 && [self compareA:soft[index - 1] valueB:cur]) {
            // 比当前要插入的对象要大的那个元素往后移动，流出来当前位置给要插入的那个元素
            // 下面的插入排序方法，这里每次都需要交换，三行代码，这里只需要向后挪动，一行代码
            soft[index] = soft[index - 1];
            index --;
        }
        // 将腾出来的那个位置赋值
        soft[index] = cur;
    }
    
    return soft.copy;
}
// 普通插入排序
-(NSArray *)soft1:(NSArray *)arr{
    NSMutableArray *soft = arr.mutableCopy;
    // 把插入排序看成打扑克牌，每次抓一张牌然后插入到已经有的牌当中，原来抓到手的牌是有序的，插入之后还是有序的。
    // 每次抓取一张牌
    for (int i = 1; i < soft.count - 1; i ++) {
        // 如果当前牌索引大于0，并且前一张牌比后一张牌大
        // 如果判断的时候，相等，那么是不稳定排序，会交换两个相等的元素的位置，这里只是compare为大于
        // 时间复杂度取决于逆序对的数量，如，10，9，8，3，2，1，【10，1】，【9，2】，【8，3】，互为逆序对，最后面的牌，需要经历很远的路程，才可以排到前面
        // 时间复杂度与逆序对的数量成正比
        // 逆序对的数量越多，插入排序的时间复杂度越高
        // 时间复杂度为O(n^2),最好的时间复杂度为O(n),如果没有逆序对，就是最优的情况
        // 属于稳定排序
        // 数量不大的时候，插入排序的效率很高
        int index = i;
        while (index > 0 && [self compareA:soft[index - 1] valueB:soft[index]]) {
            // 交换牌的位置
            NSNumber *tmp = soft[index];
            soft[index] = soft[index - 1];
            soft[index - 1] = tmp;
            
            // 一次向前推，直到排到最前面有序的位置
            index --;
        }
    }
    return soft.copy;
}
- (BOOL)compareA:(NSNumber *)valueA valueB:(NSNumber *)valueB{
    return valueA.intValue > valueB.intValue;
}
@end
