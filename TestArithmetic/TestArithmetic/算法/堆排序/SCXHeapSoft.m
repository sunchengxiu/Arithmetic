//
//  SCXHeapSoft.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/11.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXHeapSoft.h"
@interface SCXHeapSoft(){
    
    int _size;
}

@end
@implementation SCXHeapSoft
-(NSArray *)soft:(NSArray *)arr{
    // 建堆
    NSMutableArray *soft = arr.mutableCopy;
    _size = soft.count;
    // 自下而上下滤
    for (NSInteger i = (_size >> 1) - 1; i >= 0; i --) {
        [self siftDown:i arr:soft];
    }
    while (_size > 1) {
        // 将堆顶和堆尾元素互换
        // size --
        NSNumber *tmp = soft[--_size];
        soft[_size] = soft[0];
        soft[0] = tmp;
        
        // 将第0个元素下滤，保证除了最后一个元素之外，其余的元素组成一个堆
        [self siftDown:0 arr:soft];
    }
    return soft.copy;
}
// 下滤
- (void)siftDown:(NSInteger)index arr:(NSMutableArray *)_array{
    //第一个叶子节点的索引就是非叶子节点的数量，因为为完全二叉树，所以，要么没有左右子节点，要么只有左节点，不可能出现只有右子节点的情况
    // index < 第一个叶子节点的索引，这样就能保证他能和有子节点的进行交换
    // 必须保证index 位置为非叶子节点，因为这样可以找到左节点，或者左右节点，进行交换
    // 非叶子节点的数量为 二叉树节点数量除以二
    if (index >= _array.count) {
        return;
    }
    id obj = _array[index];
    // 第一个非叶子节点的索引
    NSInteger half = _size >> 1;
    while (index < half) {
        // 要么只有左子节点
        // 要么右左右子节点
        // 左子节点的索引为 2i +1 ,右子节点的索引为 2i+2
        NSInteger leftIndex = (index << 1) + 1;
        id leftObjf = _array[leftIndex];
        NSInteger rightIndex = leftIndex +1;
        
        
        // 选出最大值
        id maxObj = leftObjf;
        NSInteger maxIndex = leftIndex;
        if (rightIndex < _size ) {
            id rightObj = _array[rightIndex];
            if ([self compareA:rightObj valueB:leftObjf]) {
                // 右节点比左节点大
                maxObj = rightObj;
                maxIndex = rightIndex;
            }
        }
        
        // 选出左右最大的节点和index之后，和当前节点进行比较
        if ([self compareA:obj valueB:maxObj]) {
            // 如果当前节点比左右子节点中最大的那一个都打大，就退出不用交换了
            break;
        }
        // 如果当前节点比左右节点中的其中一个小，那么将当前位置，赋值为最大值,将最大值一次上滤，然后自己下沉，记住位置
        _array[index] = maxObj;
        index = maxIndex;
    }
    _array[index] = obj;
}
- (BOOL)compareA:(NSNumber *)valueA valueB:(NSNumber *)valueB{
    return valueA.intValue > valueB.intValue;
}
@end
