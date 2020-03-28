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
- (void)clear {
    _head = nil;
    _last = nil;
    _size = 0;
}
- (BOOL)containObject:(id)object {
    if (!object) {
        return NO;
    }
    SCXNode *cur = _head;
    for (int i = 0 ; i < _size; i ++) {
        if ([cur.data isEqual:object]) {
            return YES;
        }
        cur = cur.next;
    }
    return NO;
}
- (void)deleteObject:(id)object {
    NSInteger index = [self indexOfObject:object];
    if (index != -1) {
        [self removeObjectAtIndex:index];
    }
}
- (BOOL)hasCircle {
    return YES;
}
-(void)reset{
    _current = _head;
}
-(id)next{
    if (_current == nil) {
        _current = _head;
        return _head.data;
    } else{
        _current = _current.next;
        return _current.data;
    }
}
- (NSInteger)indexOfObject:(id)object {
    if (!object) {
        return -1;
    }
    SCXNode *cur = _head;
    for (int i = 0 ; i < _size; i ++) {
        if ([cur.data isEqual:object]) {
            return i;
        }
        cur = cur.next;
    }
    return -1;
}
- (id)removeFirstObject {
    return [self removeObjectAtIndex:0];
}
- (id)removeLastObject {
    return [self removeObjectAtIndex:_size];
}
- (id)removeObjectAtIndex:(NSInteger)index {
    if (![self enable:index]) {
        return nil;
    }
    if (_size == 1) {
        id data = _head.data;
        _head = nil;
        _last = nil;
        _size --;
        return data;
    } else {
        SCXNode *cur = [self nodeAtIndex:index];
        id data = cur.data;
        SCXNode *pre = cur.pre;
        SCXNode *next = cur.next;
        pre.next = next;
        next.pre = pre;
        if (cur == _head) {
            _head = next;
        }
        if (cur == _last) {
            _last = pre;
        }
        cur = nil;
        _size--;
        return data;
    }
}
- (id)setObject:(id)object atIndex:(NSInteger)index {
    if (![self enable:index] || index == _size) {
        return nil;
    }
    SCXNode *node = [self nodeAtIndex:index];
    id data = node.data;
    node.data = object;
    return data;
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
