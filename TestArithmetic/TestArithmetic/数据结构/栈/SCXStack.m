//
//  SCXStack.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/4/2.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXStack.h"
@interface SCXStack()

/**
 stack
 */
@property(nonatomic , strong)NSMutableArray *stack;
@end
@implementation SCXStack
- (void)push:(id)obj {
    if (!obj) return;
    [self.stack addObject:obj];
}

-(id)pop{
    if ([self isEmpty]) return nil;
    id last = self.stack.lastObject;
    [self.stack removeLastObject];
    return last;
}
-(id)top{
    if ([self isEmpty]) return nil;
    return self.stack.lastObject;
}

- (BOOL)isEmpty {
    return !self.stack.count;
}
- (NSInteger)length {
    return self.stack.count;
}
-(void)removeAllObjects {
    [self.stack removeAllObjects];
}
- (NSMutableArray *)stack {
    if (!_stack) {
        _stack = [NSMutableArray array];
    }
    return _stack;
}

@end
