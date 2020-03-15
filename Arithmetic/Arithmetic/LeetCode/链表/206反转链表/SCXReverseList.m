//
//  SCXReverseList.m
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/14.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import "SCXReverseList.h"

struct ListNode {
     int val;
     struct ListNode *next;
};


@implementation SCXReverseList


struct ListNode* reverseList(struct ListNode* head){
    struct ListNode *pre = NULL;
    struct ListNode *cur = head;
    while (cur != NULL) {
        struct ListNode *tmp = cur->next;
        cur->next = pre;
        pre = cur;
        cur = tmp;
    }
    return pre;
}
@end
