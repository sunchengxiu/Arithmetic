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
@end
