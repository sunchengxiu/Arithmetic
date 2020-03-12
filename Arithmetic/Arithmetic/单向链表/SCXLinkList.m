//
//  SCXLinkList.m
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/12.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import "SCXLinkList.h"
typedef void* AnyObject;
typedef struct ListNode{
    AnyObject data;
    struct ListNode *next;
} Node;

@implementation SCXLinkList{
    int _size;
    Node *_head;
}
-(instancetype)init{
    if (self = [super init]) {
        _head = (Node *)malloc(sizeof(Node));
        _size = 0;
        _head->data = nil;
        _head->next = nil;
    }
    return self;
}
-(id)addToHead:(id)object{
    return [self addObject:object atIndex:0];
}
-(id)addToTail:(id)object{
    return [self addObject:object atIndex:_size];
}
- (id)addObject:(id)object atIndex:(NSInteger)index;{
    if (![self enable:index] || !object) {
        return nil;
    }
    if (index == 0) {
        Node *preNode = _head;
        Node *newNode = (Node *)malloc(sizeof(Node));
        newNode->data = (__bridge AnyObject)object;
        newNode->next = preNode;
        _head = newNode;
        _size ++;
        return (__bridge id _Nonnull)preNode->data;
    } else {
        Node *preNode = [self nodeAtIndex:index - 1];
        Node *newNode = (Node *)malloc(sizeof(Node));
        newNode->data = (__bridge AnyObject)object;
        newNode->next = preNode->next;
        preNode->next = newNode;
         _size ++;
        return (__bridge id _Nonnull)preNode->data;
    }
}
-(id)setObject:(id)object atIndex:(NSInteger)index{
    if (![self enable:index] || !object) {
        return nil;
    }
    Node *node = [self nodeAtIndex:index];
    id data = (__bridge id)(node->data);
    node->data = (__bridge AnyObject)(object);
    return data;
}
-(id)objectAtIndex:(NSInteger)index{
    Node *node = [self nodeAtIndex:index];
    return (__bridge id _Nonnull)(node->data);
}
-(id)removeLastObject{
    return [self removeObjectAtIndex:_size];
}
-(id)removeFirstObject{
    return [self removeObjectAtIndex:0];
}
-(id)removeObjectAtIndex:(NSInteger)index{
    if (![self enable:index]) {
        return nil;
    }
    if(index == 0){
         Node *preNode = _head;
        _head = _head->next;
        _size --;
        return (__bridge id _Nonnull)preNode->data;
    } else {
        Node *preNode = [self nodeAtIndex:index - 1];
        Node *cur = preNode->next;
        preNode->next = preNode->next->next;
        _size--;
        return (__bridge id _Nonnull)cur->data;
    }
}
-(BOOL)containObject:(id)object{
    BOOL has = NO;
    Node *cur = _head;
    while (cur->next != nil) {
        id data = (__bridge id)(cur->data);
        if ([data isEqual:object]) {
            return YES;
        }
        cur = cur->next;
    }
    return has;
}
- (Node *)nodeAtIndex:(NSInteger)index{
    if (![self enable:index]) {
        return nil;
    }
    Node *node = _head;
    for (NSInteger i = 0 ; i < index; i ++) {
        node = node->next;
    }
    return node;
}
-(NSInteger)indexOfObject:(id)object{
    Node *cur = _head;
    NSInteger index = -1;
    for (NSInteger i = 0 ; i < _size; i ++) {
        Node *node = [self nodeAtIndex:i];
        id data = (__bridge id)(node->data);
        if ([data isEqual:object]) {
            index = i;
        }
    }
    return index;
}
- (BOOL)enable:(NSInteger)index{
    if (index < 0 || index > _size) {
        return NO;
    }
    return YES;
}
- (void)clear{
    _size = 0;
    _head = nil;
}
-(NSString *)description{
    NSMutableString *str = [NSMutableString string];
    Node *cur = _head;
    while (cur->next != nil) {
        [str appendFormat:@"%@,",cur->data];
        cur = cur->next;
    }
    return str;
}
@end
