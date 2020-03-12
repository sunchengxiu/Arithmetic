//
//  SCXDeleNode.m
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/12.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import "SCXDeleNode.h"
struct ListNode {
    int val;
    struct ListNode *next;
};
@implementation SCXDeleNode
void deleteNode(struct ListNode* node) {
    node->val = node->next->val;
    node->next = node->next->next;
//    *node = *(node->next);
}
@end

