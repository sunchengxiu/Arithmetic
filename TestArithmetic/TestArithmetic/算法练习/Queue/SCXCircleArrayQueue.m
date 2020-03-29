
//
//  SCXCircleArrayQueue.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/3/29.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXCircleArrayQueue.h"
static NSInteger const defaultCapacity = 20;
typedef void * AnyObject;
@interface SCXCircleArrayQueue()
{
    int _frontIdx;
    NSMutableArray * _arrayQueue;
}

/// 队列所有元素个数
@property (nonatomic,assign)NSInteger size;
///capacity
@property (nonatomic,assign) NSInteger capacity;
@end
@implementation SCXCircleArrayQueue
+(instancetype)arrayQueue{
    return [self arrayQueueWithCapacity:defaultCapacity];
}
+ (instancetype)arrayQueueWithCapacity:(NSInteger)capacity {
    return [[SCXCircleArrayQueue alloc] initWithArrayCapacity:capacity];
}
-(instancetype)initWithArrayCapacity:(NSInteger)capacity{
    if (self = [super init]) {
        _capacity = capacity;
        _arrayQueue = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    return self;
}
-(void)enqueue:(id)obj{
    if (!obj) {
        return;
    }
    /*
     假设环形队列，容量为4，如果0，1，2，3的位置插入了元素，如果这时候删除0，1，位置的元素，那么0，1位置的空间还在没有释放，这时候只不过我们的 frontIdx 位置w后移了，这时候如果我们再添加一个元素4，实际上应该插入到我们的0位置，所以应该为 (_frontIdx + _size ) % _capacity = (2 + 2 )  % 4,size是我们的真实元素个数,_capacity 为容量
     */
    _arrayQueue[(_frontIdx + _size) % _capacity] = obj;
    // 动态扩容
}
-(id)dequeue{
    if ([self isEmpty]) {
        return nil;
    }
    id obj = _arrayQueue[_frontIdx];
    _arrayQueue[_frontIdx] = [NSNull null];;
    _frontIdx = (_frontIdx + 1) % _capacity;
    _size --;
    return obj;
}
-(id)front{
    return _arrayQueue[_frontIdx];
}
-(NSInteger)size{
    return _size;
}
- (BOOL)isEmpty{
    return _size == 0;
}
-(NSString *)description{
    NSMutableString *str = [NSMutableString string];
    for (int i = 0 ; i < self.size; i ++ ) {
        id obj = _arrayQueue[i];
        NSLog(@"%@",obj);
    }
    return str;
}
@end
