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

-(void)removeNodeAfter:(SCXBinaryNode *)node{
    
    
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
