//
//  SCXPriorityQueue.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/7.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXPriorityQueue.h"
#import "SCXBinaryHeap.h"
@interface SCXPriorityQueue()<SCXBinaryHeapDelegate>
@property (nonatomic , strong) SCXBinaryHeap *heap;
@property (nonatomic , weak) id<SCXPriorityQueueDelegate> delegate;
@end
@implementation SCXPriorityQueue
-(instancetype)initWithDelegate:(id)delegate{
    if (self = [super init]) {
        self.delegate = delegate;
        self.heap = [[SCXBinaryHeap alloc] initWithDelegate:self];
    }
    return self;;
}
-(NSInteger)size{
    return self.heap.size;
}
-(BOOL)isEmpty{
    return self.heap.isEmpty;
}
-(void)clear{
    [self.heap clear];
}
- (id)deQueue{
    return [self.heap removeTopObject];
}
- (void)enQueue:(id)obj{
    [self.heap add:obj];
}
-(id)front{
    return [self.heap getTopObject];;
}
-(BOOL)compareA:(id)valueA valueB:(id)valueB{
    if (self.delegate && [self.delegate respondsToSelector:@selector(compareA:valueB:)]) {
        return [self.delegate compareA:valueA valueB:valueB];
    }
    return YES;
}
-(NSString *)description{
    return self.heap.description;
}
@end
