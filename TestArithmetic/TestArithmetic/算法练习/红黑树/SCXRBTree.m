//
//  SCXRBTree.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/6/25.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXRBTree.h"
#import "SCXBinarySearchTree+Private.h"
#define _INLINE static inline
/// 将节点染色
/// @param node 需要染色的节点
/// @param color 需要染的颜色
_INLINE SCXRBNode* Color(SCXBinaryNode *node,SCXRBColorType color){
    if (node == nil) {
        NSLog(@"cant color a nil node");
        return nil;
    }
    SCXRBNode *rbnode = (SCXRBNode *)node;
    rbnode.color = color;
    return rbnode;
}

_INLINE SCXRBNode* Red(SCXBinaryNode *node){
    return Color(node, SCXRBColorTypeRed);
}

_INLINE SCXRBNode* Black(SCXBinaryNode *node){
    return Color(node, SCXRBColorTypeBlack);
}

/// 判断当前节点颜色
/// @param node 当前节点
_INLINE SCXRBColorType IsColor(SCXBinaryNode *node){
    if (node == nil) {
        return SCXRBColorTypeBlack;;
    }
    return ((SCXRBNode *)node).color;
}

_INLINE BOOL IsRed(SCXBinaryNode *node){
    return IsColor(node) == SCXRBColorTypeRed;
}

_INLINE BOOL IsBlack(SCXBinaryNode *node){
    return IsColor(node) == SCXRBColorTypeBlack;
}
#pragma mark -
#pragma mark  红黑树节点
#pragma mark -
@interface SCXRBNode()

@end
@implementation SCXRBNode
- (instancetype)initWithValue:(id)value parentNode:(SCXBinaryNode *)parent{
    self.color = SCXRBColorTypeRed;
    return [super initWithValue:value parentNode:parent];
}
@end
@interface SCXBinarySearchTree()
@property(nonatomic,strong)SCXBinaryNode *rootNode;
@end

#pragma mark -
#pragma mark  红黑树
#pragma mark -
/*
1. 节点是 red 或者 black
2. 根节点是 black
3. 叶子节点（外部节点，空节点）都是 black
4. red 节点的子节点是 black
5. red 节点的父节点是 black
6. 从根节点到叶子节点的所有路径上不能有两个连续的 red 节点
7. 从任一节点到叶子节点的所有路径都包含相同数目的 black 节点
*/
/*
 1. 默认添加红色节点
 2. 如果叔父节点（uncle）不是红色，那么可以直接添加
 3. 如果叔父节点（uncle）不是红色，直接添加节点后，LL , RR 情况
    3.1. 如果叔父节点不是红色，那么将父（parent）节点染成黑色，祖父节点（grand）染成红色,然后 grand 进行单旋操作
    3.2. 如果添加完为 LL ，则进行右旋转
    3.3. 如果添加完为 RR ，则进行左旋转
 4. 如果叔父节点（uncle）不是红色，直接添加节点后，LR，RL 情况
    4.1. 如果添加节点后为 LR 或者 RL，则将自己染成黑色，grand 染成红色，然后进行双旋操作
    4.2. 如果为 LR，则 parent 进行左旋转，grand 进行右旋
    4.3. 如果为 RL，则 parent 进行右旋转，grand 进行左旋。
 5.如果叔父节点是红色，那么会出现上溢，那么将 parent 和 uncle 都染成黑色，然后自己染成红色，同时将 parent 染成红色，当做一个新的节点向上添加，如果持续上溢，一直到根节点，那么只需要将根节点 染成黑色
 */
// https://www.jianshu.com/p/b56f4115097c
@implementation SCXRBTree
-(void)addNewNodeAfter:(SCXBinaryNode *)node{
    SCXRBNode *rbnode = (SCXRBNode *)node;
    // parent
    SCXRBNode *parent = (SCXRBNode *)rbnode.parent;
    // 添加的是根节点或者上溢到根节点，直接染黑返回
    if (parent == nil) {
        Black(rbnode);
        return;
    }
    
    // 如果父节点是黑色的，直接添加就可以
    if (IsBlack(parent)) {
        return;
    }
    
    // 叔父节点
    SCXRBNode *uncle = (SCXRBNode *)parent.sibling;
    // 祖父节点
    SCXRBNode *grand = (SCXRBNode *)parent.parent;
    // 如果叔父节点为红色，那么需要将parent和叔父节点都染成黑色，然后将grand向上添加，图参考上面链接
    if (IsRed(uncle)) {
        // parent 染成 黑色
        Black(parent);
        // 叔父节点染成黑色
        Black(uncle);
        // grand 染成红色然后上溢
        Red(grand);
        [self addNewNodeAfter:grand];
        return;
    }
    
    // 如果叔父节点不是红色
    // 需要进行单旋或者双旋
    if ([parent isLeftChild]) {// L
        if ([node isLeftChild]) {
            // LL
            // 将父节点染黑
            Black(parent);
            // grand 染成红色
            Red(grand);
            //右旋
            [self rightRote:grand];
        } else {
            // LR
            // 将当前节点染黑
            Black(node);
            // 将 grand 染成 red
            Red(grand);
            // parent 左旋
            [self leftRote:parent];
            // grand 右旋
            [self rightRote:grand];
        }
    } else { // R
        if ([node isRightChild]) {
            // RR
            // parent 染成黑色
            Black(parent);
            // grand 染成红色
            Red(grand);
            // 左旋
            [self leftRote:grand];
        } else {
            // RL
            // 自己染成黑色
            Black(node);
            // grand 染成红色
            Red(grand);
            // parent 右旋
            [self rightRote:parent];
            // grand 左旋
            [self leftRote:grand];
        }
    }
}

-(void)removeNodeAfter:(SCXBinaryNode *)bnode{
    /*
     https://www.jianshu.com/p/b56f4115097c
     node 传过来，可能是被删除的节点，也可能是替代的节点
     1. 如果删除了一个红色的叶子节点，那么对整棵树没有影响，直接删除就可以了，对删除的这个节点是否染色都可以，因为他要被删除了
     2. 如果替代的节点为红色，就需要将替代的节点染成黑色
     */
    SCXRBNode *rbnode = (SCXRBNode *)bnode;
    if (IsRed(rbnode)) {
        Black(rbnode);
        return;
    }
    
    SCXRBNode *parent = (SCXRBNode *)rbnode.parent;
    // 如果为根节点
    if (parent == nil) {
        return;
    }
    
    // 如果被删除的节点是黑色叶子节点，那么会导致下溢
    // 判断被删除的节点是左还是右
    BOOL isLeft = parent.leftNode == nil || [rbnode isLeftChild];
    // 找到兄弟节点
    SCXRBNode *sibling = isLeft ? (SCXRBNode *)parent.rightNode : (SCXRBNode *)parent.leftNode;
    if (isLeft) {
        // 这里的情况和下面的刚好对称，左改为右，又改为左就可以.
        if (IsRed(sibling)) {
            Black(sibling);
            Red(parent);
            [self leftRote:parent];
            sibling = (SCXRBNode *)parent.rightNode;
        }

        if (IsBlack(sibling.leftNode) && IsBlack(sibling.rightNode)) {
            BOOL isBlack = IsBlack(parent);
            Black(parent);
            Red(sibling);
            if (isBlack) {
                [self removeNodeAfter:parent];
            }
        } else {
            if (IsBlack(sibling.rightNode)) {
                [self rightRote:sibling];
                sibling = (SCXRBNode *)parent.rightNode;
            }
            Color(sibling, IsColor(parent));
            Black(sibling.rightNode);
            Black(parent);
            [self leftRote:parent];
        }
    } else {
        /*
         如果被删除的节点的兄弟节点为红色
         1. 需要将兄弟节点染成黑色，parent 染成红色
         2. 然后进行右旋转，变成了兄弟节点为黑色的情况，可以统一处理，
         */
        if (IsRed(sibling)) {
            Black(sibling);
            Red(parent);
            [self rightRote:parent];
            // 更换兄弟节点，因为右旋了
            sibling = (SCXRBNode *)parent.leftNode;
        }
        
        // 统一处理兄弟节点为黑色的情况
        // 判断兄弟节点是否有红色节点
        if (IsBlack(sibling.leftNode) && IsBlack(sibling.rightNode)) {
            // 到这里说明，兄弟节点没有一个是红色的。
            // 父节点要向下和兄弟节点合并
            // 父节点染黑
            // 兄弟节点染红
            // 如果父节点为黑色，向下合并的时候会出现下溢
            BOOL isBlack = IsBlack(parent);
            Black(parent);
            Red(sibling);
            if (isBlack) {
                [self removeNodeAfter:parent];
            }
        } else {
            // 来到这里，说明兄弟节点至少有一个是红色，可以借一个
            // 兄弟节点至少有一个红色节点，那么分以下几种情况，有一个左红色节点，有一个右红色节点，有两个左右都是红色的节点，那么，有一个左红色节点和有两个红色节点，都需要进行右旋转，而有一个右红色节点，需要先进行左旋转，然后进行右旋转，所以，有一个有色红节点，可以转化为前面两种情况，所以判断条件可以为左边节点是否为黑色，因为空节点就是黑色
            if (IsBlack(sibling.leftNode)) {
                [self leftRote:sibling];
                sibling = (SCXRBNode *)parent.leftNode;
            }
            
            // 然后统一进行右旋转
            // 兄弟节点需要继承父节点的颜色
            // 然后将parent和兄弟节点的子节点都染成黑色
            Color(sibling, IsColor(parent));
            Black(sibling.leftNode);
            Black(parent);
            [self rightRote:parent];
        }
    }
}
// 左旋
- (void)leftRote:(SCXRBNode *)node{
    // 要符合左旋转，肯定是存在 node.right.right 的
    SCXRBNode *parent = (SCXRBNode *)node.rightNode;
    SCXRBNode *parentLeftNode = (SCXRBNode *)parent.leftNode;
    node.rightNode = parentLeftNode;
    parent.leftNode = node;
    [self updateRote:node parentNode:parent child:parentLeftNode];
}
// 右旋
- (void)rightRote:(SCXRBNode *)node{
    SCXRBNode *parent = (SCXRBNode *)node.leftNode;
    SCXRBNode *child = (SCXRBNode *)parent.rightNode;
    node.leftNode = child;
    parent.rightNode = node;
    [self updateRote:node parentNode:parent child:child];
   
}
- (void)updateRote:(SCXRBNode *)node parentNode:(SCXRBNode *)parent child:(SCXRBNode *)child{
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
}
-(SCXBinaryNode *)createNodeWithValue:(id)value parentNode:(SCXBinaryNode *)parent{
    return [[SCXRBNode alloc] initWithValue:value parentNode:parent];
}
@end
