//
//  SCXArrayQueue.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/3/29.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXArrayQueue.h"

@implementation SCXArrayQueue{
    NSMutableArray *_arrayQueue;
}
+(instancetype)arrayQueue{
    return [self arrayQueueWithCapacity:20];
}
+ (instancetype)arrayQueueWithCapacity:(NSInteger)capacity {
    return [[SCXArrayQueue alloc] initWithArrayCapacity:capacity];
}
-(instancetype)initWithArrayCapacity:(NSInteger)capacity{
    if (self = [super init]) {
        _arrayQueue = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    return self;
}
- (void)enqueue:(id)obj {
    [_arrayQueue addObject:obj];
}
- (id)dequeue {
    id obj = [_arrayQueue objectAtIndex:0];
    [_arrayQueue removeObjectAtIndex:0];
    return obj;
}

- (id)firstObject {
    return [_arrayQueue firstObject];
}

- (void)removeAllObjects {
    [_arrayQueue removeAllObjects];
}
- (NSInteger)size {
    return _arrayQueue.count;
}
- (BOOL)isEmpty {
    return _arrayQueue.count == 0;
}

- (NSString *)description {
    
    NSMutableString *str = [NSMutableString string];
    for (id obj in _arrayQueue) {
        [str appendFormat:@"%@,",obj];
    }
    return str;
}

@end
