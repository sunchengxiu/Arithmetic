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
- (instancetype)initWithArray:(NSArray *)arr delegate:(id<SCXBinaryHeapDelegate>)delegate{
    if (self = [super init]) {
        self.delegate = delegate;
        if (!arr || arr.count == 0) {
            _array = [NSMutableArray arrayWithCapacity:DefaultCapacity];
            _size = 0;
        } else {
            NSInteger count = arr.count;
            _capacity = count;
            _size = count;
            self.array = arr.mutableCopy;
            [self heapify];
        }
    }
    return self;
}
- (void)heapify{
    // 自下而上下滤
    for (NSInteger i = (_size >> 1) - 1; i >= 0; i --) {
        [self siftDown:i];
    }
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
-(id)removeTopObject{
    if ([self isEmpty]) {
        return nil;
    }
    NSInteger lastIndex = --_size;
    id obj = _array[0];
    _array[0] = _array[lastIndex];
    [_array removeObjectAtIndex:lastIndex];
    [self siftDown:0];
    return obj;
}
- (id)replaceTopObject:(id)object{
    if ([self isNULL:object]) {
        return nil;
    }
    id obj = nil;
    if (_size == 0) {
        _size ++;
        _array[0] = object;
    } else {
        obj = _array[0];
        _array[0] = object;
        [self siftDown:0];
    }
    return obj;
}
-(NSInteger)size{
    return _size;
}
-(BOOL)isEmpty{
    return _size == 0;
}

- (void)clear {
    [_array removeAllObjects];
    _size = 0;
}

- (nonnull id)getTopObject {
    return _array.firstObject;
}

// 上滤
- (void)siftDown:(NSInteger)index{
    //第一个叶子节点的所以就是非叶子节点的数量，因为为完全二叉树，所以，要么没有左右子节点，要么只有左节点，不可能出现只有右子节点的情况
    // index < 第一个叶子节点的索引，这样就能保证他能和有子节点的进行交换
    // 必须保证index 位置为非叶子节点，因为这样可以找到左节点，或者左右节点，进行交换
    // 非叶子节点的数量为 二叉树节点数量除以二
    
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
        id rightObj = _array[rightIndex];
        
        // 选出最大值
        id maxObj = leftObjf;
        NSInteger maxIndex = leftIndex;
        
        if (rightIndex < _size && [self.delegate compareA:rightObj valueB:leftObjf]) {
            // 右节点比左节点大
            maxObj = rightObj;
            maxIndex = rightIndex;
        }
        
        // 选出左右最大的节点和index之后，和当前节点进行比较
        if ([self.delegate compareA:obj valueB:maxObj]) {
            // 如果当前节点比左右子节点中最大的那一个都打大，就退出不用交换了
            break;
        }
        // 如果当前节点比左右节点中的其中一个小，那么将当前位置，赋值为最大值,将最大值一次上滤，然后自己下沉，记住位置
        _array[index] = maxObj;
        index = maxIndex;
    }
    _array[index] = obj;
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

-(NSString *)description{
    return _array.description;
}
@end
