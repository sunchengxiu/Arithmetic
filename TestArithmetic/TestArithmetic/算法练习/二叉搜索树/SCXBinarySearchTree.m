//
//  SCXBinarySearchTree.m
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import "SCXBinarySearchTree.h"
#import "SCXCircleArrayQueue.h"
@interface SCXBinaryNode<ObjectType> : NSObject
@property(nonatomic,strong)ObjectType value;
@property(nonatomic,strong)SCXBinaryNode *leftNode;
@property(nonatomic,strong)SCXBinaryNode *rightNode;
@property(nonatomic,strong)SCXBinaryNode *parent;
- (instancetype)initWithValue:(ObjectType)value parentNode:(SCXBinaryNode *)parent;
@end
@implementation SCXBinaryNode

-(instancetype)initWithValue:(id)value parentNode:(SCXBinaryNode *)parent{
    if (self = [super init]) {
        self.value = value;
        self.parent = parent;
    }
    return self;
}

@end
@implementation SCXBinarySearchTree{
    int _size;
    SCXBinaryNode *_rootNode;
    SCXCircleArrayQueue *_queue;
}
-(instancetype)init{
    if (self = [super init]) {
        _queue = [SCXCircleArrayQueue arrayQueue];
    }
    return self;
}
-(void)addObject:(id<SCXBinaryTreeProtocol>)obj{
    if (![self isEnable:obj]) {
        return;
    }
     // 第一个节点
    if (_rootNode == nil) {
        _rootNode = [[SCXBinaryNode alloc] initWithValue:obj parentNode:nil];
        _size++;
        return;
    }
    SCXBinaryNode *currentNode = _rootNode;
    // 父节点
    SCXBinaryNode *parent = nil;
    int cmp = 0;
    // 一直找到最后，一直找到没有子节点
    while (currentNode != nil) {
        cmp = [self compare:currentNode.value node2:obj];
        parent = currentNode;
        // 比当前节点值大，说明在右子树，反之在左子树
        if (cmp > 0) {
            currentNode = currentNode.rightNode;
        } else if (cmp < 0){
            currentNode = currentNode.leftNode;
        } else {
            currentNode.value = obj;
            return;
        }
    }
    SCXBinaryNode *newNode = [[SCXBinaryNode alloc] initWithValue:obj parentNode:parent];
    // 最后一次比较如果大于0，说明插入到右节点，反之左节点
    if (cmp > 0) {
        // 插入到右节点
        parent.rightNode = newNode;
    } else if (cmp < 0) {
        parent.leftNode = newNode;
    }
    _size ++;
}

- (BOOL)isEnable:(id<SCXBinaryTreeProtocol>)obj{
    if (!obj) {
        return NO;
    }
    NSAssert([obj conformsToProtocol:@protocol(SCXBinaryTreeProtocol)], @"please conform SCXBinaryTreeProtocol");
    NSAssert([obj respondsToSelector:@selector(compare:)], @"please respondsToSelector compare:)");
    return YES;
}
- (int)compare:(id <SCXBinaryTreeProtocol>)node1 node2:(id <SCXBinaryTreeProtocol>)node2{
    return [node2 compare:node1];
}
-(int)size{
    return _size;
}
-(BOOL)isEmpty{
    return _size == 0 ? YES : NO;
}
#pragma mark - 遍历
- (BOOL)isContinue:(Iterator)iterator rootNode:(SCXBinaryNode *)rootNode stop:(BOOL *)stop{
    if (rootNode == nil || !iterator || *stop) {
        return NO;
    }
    return YES;
}
- (void)iterator:(Iterator)iterator rootNode:(SCXBinaryNode *)rootNode stop:(BOOL *)stop{
    if (*stop) {
        return;
    } else {
        iterator(rootNode.value,stop);
        if (*stop) {
            return ;
        }
    }
}
-(void)preorderTraversal:(Iterator)iterator{
    BOOL stop = NO;
    [self _preorderTraversal:_rootNode iterator:iterator stop:&stop] ;
}
// 递归前序遍历
-(void)_preorderTraversal:(SCXBinaryNode *)rootNode iterator:(Iterator)iterator stop:(BOOL *)stop{
    if (![self isContinue:iterator rootNode:rootNode stop:stop]) return ;
    [self iterator:iterator rootNode:rootNode stop:stop];
    if (*stop) return;
    [self _preorderTraversal:rootNode.leftNode iterator:iterator stop:stop];
    [self _preorderTraversal:rootNode.rightNode iterator:iterator stop:stop];
}
-(void)inorderTraversal:(Iterator)iterator{
    BOOL stop = NO;
    [self _inorderTraversal:_rootNode iterator:iterator stop:&stop];
}
-(void)_inorderTraversal:(SCXBinaryNode *)rootNode iterator:(Iterator)iterator stop:(BOOL *)stop{
    if (![self isContinue:iterator rootNode:rootNode stop:stop]) return ;
    [self _inorderTraversal:rootNode.leftNode iterator:iterator stop:stop];
    [self iterator:iterator rootNode:rootNode stop:stop];
    if (*stop) return;
    [self _inorderTraversal:rootNode.rightNode iterator:iterator stop:stop];
}
-(void)postorderTraversal:(Iterator)iterator{
    BOOL stop = NO;
    [self _postorderTraversal:_rootNode iterator:iterator stop:&stop];
}
-(void)_postorderTraversal:(SCXBinaryNode *)rootNode iterator:(Iterator)iterator stop:(BOOL *)stop{
    if (![self isContinue:iterator rootNode:rootNode stop:stop]) return ;
    [self _postorderTraversal:rootNode.leftNode iterator:iterator stop:stop];
    [self _postorderTraversal:rootNode.rightNode iterator:iterator stop:stop];
    [self iterator:iterator rootNode:rootNode stop:stop];
    if (*stop) return;
}
/*
 使用队列的来实现层序遍历，因为我们是一层一层遍历的，在树的上面的节点是先放到二叉树上面的，然后访问的时候，也是从上面开始访问，并且是先访问根节点，然后左子节点右子节点
 1. 将根节点入队
 2. 循环执行如下操作
  2.1 首先将对头节点 A 出对，访问出对。
  2.2 然后将 A 的左子节点入队，
  2.4 然后将 A 的右子节点入队
 
 */
-(void)levelorderTraversal:(Iterator)iterator{
    BOOL stop = NO;
    [self _levelorderTraversal:_rootNode iterator:iterator stop:&stop];
}
-(void)_levelorderTraversal:(SCXBinaryNode *)rootNode iterator:(Iterator)iterator stop:(BOOL *)stop{
    if (![self isContinue:iterator rootNode:rootNode stop:stop]) return ;
    SCXBinaryNode *root = _rootNode;
    [_queue enqueue:root];
    while (![_queue isEmpty]) {
        SCXBinaryNode *node = [_queue dequeue];
        iterator(node.value,stop);
        if (*stop) {
            return;
        }
        if (node.leftNode && ![node.leftNode isEqual:[NSNull null]]) {
            [_queue enqueue:node.leftNode];
        }
        if (node.rightNode && ![node.rightNode isEqual:[NSNull null]] ) {
            [_queue enqueue:node.rightNode];
        }
    }
}
@end
