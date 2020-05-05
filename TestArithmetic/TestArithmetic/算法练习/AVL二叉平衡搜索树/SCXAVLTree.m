//
//  SCXAVLTree.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/5/4.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXAVLTree.h"
#import "SCXBinarySearchTree+Private.h"
@interface SCXBinarySearchTree()
@property(nonatomic,strong)SCXBinaryNode *rootNode;
@end
@implementation SCXAVLNode
-(instancetype)initWithValue:(id)value parentNode:(SCXBinaryNode *)parent{
    // avl 树，如果创建一个新节点，那么当前叶子节点的高度一定为1.
    self.height = 1;
    return [super initWithValue:value parentNode:parent];
}
// 平衡因子
-(NSInteger)blanceFactor{
    SCXAVLNode *leftNode = (SCXAVLNode *)self.leftNode;
    SCXAVLNode *rightNode = (SCXAVLNode *)self.rightNode;
    NSInteger leftHeight = leftNode ? leftNode.height : 0;
    NSInteger rightHeight = rightNode ? rightNode.height : 0;
    return leftHeight - rightHeight;
}
// 更新高度
- (void)updateHeght{
    SCXAVLNode *leftNode = (SCXAVLNode *)self.leftNode;
    SCXAVLNode *rightNode = (SCXAVLNode *)self.rightNode;
    NSInteger leftHeight = leftNode ? leftNode.height : 0;
    NSInteger rightHeight = rightNode ? rightNode.height : 0;
    // 更新自己的高度，左右子树最大的高度 + 1.
    self.height = 1 + MAX(leftHeight, rightHeight);
}
// 当前节点左右子树最高的那个节点
- (SCXAVLNode *)tallNode{
    SCXAVLNode *leftNode = (SCXAVLNode *)self.leftNode;
    SCXAVLNode *rightNode = (SCXAVLNode *)self.rightNode;
    NSInteger leftHeight = leftNode ? leftNode.height : 0;
    NSInteger rightHeight = rightNode ? rightNode.height : 0;
    if (leftHeight > rightHeight) {
        return leftNode;
    }
    if (leftHeight < rightHeight) {
        return rightNode;
    }
    if ([self isLeftChild]) {
        return leftNode;
    } else {
        return rightNode;
    }
}
@end
@implementation SCXAVLTree
-(SCXBinaryNode *)createNodeWithValue:(id)value parentNode:(SCXBinaryNode *)parent{
    return [[SCXAVLNode alloc] initWithValue:value parentNode:parent];
}
-(void)addNewNodeAfter:(SCXBinaryNode *)node{
    SCXAVLNode *avlNode = (SCXAVLNode *)node;
    while ((avlNode = (SCXAVLNode *)avlNode.parent) != nil) {
        if ([self isBlanced:avlNode]) {
            // 平衡,需要更新高度
            [self updateNodeHeight:avlNode];
        } else{
            // 恢复平衡
            // 第一个不平衡节点，此节点高度最低，因为是第一个被发现。
            [self reBlance:avlNode];
            break;
        }
    }
}
- (void)reBlance:(SCXAVLNode *)node{
    // 判断是 LL，RR，LR，RL
    // 找到当前节点左右子树最高的那个
    SCXAVLNode *parent = [node tallNode];
    // 找到基于当前节点再次最高的那个，就可以知道是那种情况
    SCXAVLNode *sub = [parent tallNode];
    if ([ parent isLeftChild]) {
        if ([sub isLeftChild]) {
            // LL,右旋
            [self rightRote:node];
        } else {
            // LR，先左后右
            [self leftRote:parent];
            [self rightRote:node];
        }
    } else {
        if ([sub isLeftChild]) {
            // RL，先右后左
            [self rightRote:parent];
            [self leftRote:node];
        } else {
            // RR，左旋
            [self leftRote:node];
        }
    }
}
// 左旋
- (void)leftRote:(SCXAVLNode *)node{
    // 要符合左旋转，肯定是存在 node.right.right 的
    SCXAVLNode *parent = (SCXAVLNode *)node.rightNode;
    SCXAVLNode *parentLeftNode = (SCXAVLNode *)parent.leftNode;
    node.rightNode = parentLeftNode;
    parent.leftNode = node;
    [self updateRote:node parentNode:parent child:parentLeftNode];
}
// 右旋
- (void)rightRote:(SCXAVLNode *)node{
    SCXAVLNode *parent = (SCXAVLNode *)node.leftNode;
    SCXAVLNode *child = (SCXAVLNode *)parent.rightNode;
    node.leftNode = child;
    parent.rightNode = node;
    [self updateRote:node parentNode:parent child:child];
   
}
- (void)updateRote:(SCXAVLNode *)node parentNode:(SCXAVLNode *)parent child:(SCXAVLNode *)child{
    // 1. 更新parent的parent
    parent.parent = node.parent;
    
    // 2. 更新parent的左或者右节点，根据当前节点为左或者右
    if ([node isLeftChild]) {
        parent.parent.leftNode = parent;
    } else if([node isRightChild]){
        parent.parent.rightNode = parent;
    } else {
        self.rootNode = parent;
    }
    
    // 3. 更新 child 父节点
    if (child) {
        child.parent = node;
    }
    
    // 4. 更新 node parent
    // 4 不能放在 1 之前。
    node.parent = parent;
    
    // 5. 更新高度
    [self updateNodeHeight:node];
    [self updateNodeHeight:parent];
}
- (void)updateNodeHeight:(SCXAVLNode *)node{
    // 更新当前 avlNode 节点的高度。
    [node updateHeght];
}
- (BOOL)isBlanced:(SCXAVLNode *)node{
    NSInteger factor = node.blanceFactor;
    return labs(factor) <= 1;
}

@end
