//
//  SCXCircleList.m
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/19.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import "SCXCircleList.h"
@interface SCXNode<ObjectType> : NSObject

/**
 pre
 */
@property(nonatomic , strong)SCXNode *pre;

/**
 value
 */
@property(nonatomic , strong)ObjectType data;

/**
 next
 */
@property(nonatomic , strong)SCXNode *next;
- (instancetype)initWithPre:(SCXNode *)pre data:(ObjectType)data next:(SCXNode *)next;
@end
@implementation SCXNode

-(instancetype)initWithPre:(SCXNode *)pre data:(id)data next:(SCXNode *)next{
    if (self = [super init]) {
        self.pre = pre;
        self.data = data;
        self.next = next;
    }
    return self;
}
@end

@implementation SCXCircleList{
    SCXNode *_head;
    SCXNode *_current;
    SCXNode *_last;
    int _size;
}
-(id)objectAtIndex:(NSInteger)index{
    SCXNode *node = [self nodeAtIndex:index];
    return node.data;
}
- (id)addObject:(id)object atIndex:(NSInteger)index {
    if (![self enable:index]) {
        return nil;
    }
    id obj = nil;
    if (_size == index) {
        SCXNode *oNode = _last;
        obj = oNode.data;
        SCXNode *first = _head;
        SCXNode *newNode = [[SCXNode alloc] initWithPre:oNode data:object next:first];
        _last = newNode;
        if (oNode == nil) {
            _head = newNode;
            _head.next = _last;
            _last.pre = _head;
        } else {
            oNode.next = newNode;
            first.pre = newNode;
        }
    } else {
        SCXNode *next = [self nodeAtIndex:index];
        obj = next.data;
        SCXNode *pre = next.pre;
        SCXNode *newNode = [[SCXNode alloc] initWithPre:pre data:object next:next];
        pre.next = newNode;
        next.pre = newNode;
        // 0 的位置
        if (_head == next) {
            _head = newNode;
        }
    }
    _size ++;
    return obj;
}

- (id)addToHead:(id)object {
    return [self addObject:object atIndex:0];
}

- (id)addToTail:(id)object {
    return [self addObject:object atIndex:_size];
}

- (id)nodeAtIndex:(NSInteger)index{
    if (![self enable:index]) {
        return NULL;
    }
    SCXNode *node = _head;
    for (NSInteger i = 0 ; i < index; i ++) {
        node = node.next;
    }
    return node;
}
- (BOOL)enable:(NSInteger)index{
    if (index < 0 || index > _size) {
        return NO;
    }
    return YES;
}
-(int)count{
    return _size;
}
-(id)firstNode{
    return [self nodeAtIndex:0];
}
-(id)lastNode{
    return [self nodeAtIndex:_size];
}
-(NSString *)description{
    NSMutableString *str = [NSMutableString string];
    SCXNode *cur = _head;
    for (int i = 0 ; i < [self count] * 2; i ++ ) {
        if (i % [self count] == 0) {
            NSLog(@"-------");
        }
        NSLog(@"%@",cur.data);
        cur = cur.next;
    }
    return str;
}
@end
