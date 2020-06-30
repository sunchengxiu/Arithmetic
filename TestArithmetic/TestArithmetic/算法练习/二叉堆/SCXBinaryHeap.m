//
//  SCXBinaryHeap.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/6/30.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXBinaryHeap.h"
#define DefaultCapacity 10
@interface SCXBinaryHeap()
{
    NSInteger _size;
    NSInteger _capacity;
}
@property(nonatomic,weak)id <SCXBinaryHeapDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *array;
@end
@implementation SCXBinaryHeap
-(instancetype)initWithDelegate:(id<SCXBinaryHeapDelegate>)delegate{
    if (self = [super init]) {
        self.delegate = delegate;
        self.array = [NSMutableArray arrayWithCapacity:DefaultCapacity];
        _capacity = DefaultCapacity;
    }
    return self;
}

- (void)add:(nonnull id)object {
    if ([self isNULL:object]) {
        return;
    }
    // 动态扩容
    [self ensureCapcity:_size + 1];
    // 将元素放在最后,然后将当前size+1
    _array[_size++] = object;
    // 将当前最后一个元素上滤
    [self siftUp:_size-1];
}
- (void)siftUp:(NSInteger)index{
    // 取出当前 index 的元素
    id currentValue = _array[index];
    // 循环上滤
    while (index > 0) {
        // 父节点的索引
        NSInteger parentIndex = (index -1) >> 1;
        // 父节点的值
        id parentObj = _array[parentIndex];
        // 比较
        if (![self.delegate compareA:currentValue valueB:parentObj] ) {
            // 如果当前的值比父节点的值小，说明符合大顶堆的要求，直接退出
            break;;
        }
        // 如果当前的值比父节点大，那么交换位置
        _array[index] = parentObj;
        index = parentIndex;
    }
    _array[index] = currentValue;
}
/// 动态扩容
- (void)ensureCapcity:(NSInteger)capcity{
    NSInteger oldCapcity = _capacity;
    if (oldCapcity >= capcity) {
        return;
    }
    NSInteger newCapcity = oldCapcity + (oldCapcity >> 1);
    [self resMemory:newCapcity];
}
- (void)resMemory:(NSInteger)newCapcity{
    NSInteger oldCapcity = _capacity;
    NSMutableArray *newArr = [[NSMutableArray alloc] initWithCapacity:newCapcity];
    for (int i = 0 ; i < [self size]; i ++ ) {
        newArr[i] = _array[i];
    }
    _capacity = newCapcity;
    _array = newArr.mutableCopy;
}
- (BOOL)isNULL:(id)obj{
    if (obj == nil) {
        return YES;
    }
    return NO;
}
-(NSInteger)size{
    return _size;
}
-(NSString *)description{
    return _array.description;
}
@end
