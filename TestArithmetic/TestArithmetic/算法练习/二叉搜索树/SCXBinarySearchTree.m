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
- (BOOL)isLeafNode;
- (BOOL)hasTwoChildren;
@end
@implementation SCXBinaryNode

-(instancetype)initWithValue:(id)value parentNode:(SCXBinaryNode *)parent{
    if (self = [super init]) {
        self.value = value;
        self.parent = parent;
    }
    return self;
}
- (BOOL)hasTwoChildren{
    return (self.leftNode != nil && self.rightNode != nil);
}
-(BOOL)isLeafNode{
    return (self.leftNode == nil && self.rightNode == nil);
}
@end
@implementation SCXBinarySearchTree{
    int _size;
    SCXBinaryNode *_rootNode;
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
-(void)clear{
    _rootNode = nil;
    _size = 0;
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
    SCXCircleArrayQueue *queue = [SCXCircleArrayQueue arrayQueue];
    [queue enqueue:root];
    while (![queue isEmpty]) {
        SCXBinaryNode *node = [queue dequeue];
        iterator(node.value,stop);
        if (*stop) {
            return;
        }
        if (node.leftNode && ![node.leftNode isEqual:[NSNull null]]) {
            [queue enqueue:node.leftNode];
        }
        if (node.rightNode && ![node.rightNode isEqual:[NSNull null]] ) {
            [queue enqueue:node.rightNode];
        }
    }
}
/*
 二叉树的高度，就是根节点离最远叶子节点的高度，可以利用层序遍历来求得二叉树的高度，一层一层遍历，层序遍历一定会遍历到最后一个叶子节点，所以层级也就是高度，原理就是，每一层的节点遍历完了，那么就高度加1，那么怎么判断每一层的高度遍历完了呢？因为我们层序遍历是用队列的方式来实现的，每次都将当前节点的左节点和右节点入队，比如，根节点有两个子节点，当根节点入队的时候，队列里面数量为1，然后我们出对，然后将左右节点加入到队列里面，这是队列里面的节点个数为2，而上次我们出队之后，1-1=0，所以我们的判断安条件就是我们的我们记住上次队列里面节点的个数，当我们这个数值减为0的时候，就代表上一层遍历完了，我们的height就加一。
 */
-(int)binaryHeight1{
    int height = 0;
    int queueCount = 1;
    SCXBinaryNode *root = _rootNode;
    SCXCircleArrayQueue *queue = [SCXCircleArrayQueue arrayQueue];
    [queue enqueue:root];
    while (![queue isEmpty]) {
        SCXBinaryNode *node = [queue dequeue];
        queueCount -- ;
        if (node.leftNode && ![node.leftNode isEqual:[NSNull null]]) {
            [queue enqueue:node.leftNode];
        }
        if (node.rightNode && ![node.rightNode isEqual:[NSNull null]] ) {
            [queue enqueue:node.rightNode];
        }
        if (queueCount == 0) {
            height ++;
            queueCount = [queue size];
        }
    }
    return height;
}
/*
 递归实现：
 因为我们的高度是求最大的高度，也就是根节点到我们最深的叶子节点的高度，所以其实就是每次找左右节点高度最大的那个节点，一次向下递归，知道到头的那个节点，就是高度，那么从根节点开始找，找他的最远左右节点，就是根节点+最深的那个节点=1+Max(left,right),每次把当前节点当做根节点，知道左右没有左右节点为0；
 */
-(int)binaryHeight{
    return [self height:_rootNode];
}
- (int)height:(SCXBinaryNode *)node{
    if (node == nil) {
        return 0;
    }
    return 1+ MAX([self height:node.leftNode],[self height:node.rightNode]);
}
-(BOOL)isCompleteBinaryTree{
    BOOL isComplete = YES;
    
    SCXBinaryNode *root = _rootNode;
    SCXCircleArrayQueue *queue = [SCXCircleArrayQueue arrayQueue];
    [queue enqueue:root];
    BOOL isLeaf = NO;
    while (![queue isEmpty]) {
        SCXBinaryNode *node = [queue dequeue];
        if (isLeaf && ![node isLeafNode]) return NO;
        if (node.leftNode && ![node.leftNode isEqual:[NSNull null]]) {
            [queue enqueue:node.leftNode];
        } else {
            // 如果没有左子树，那么就一定不能有右子树
            if (node.rightNode && ![node.rightNode isEqual:[NSNull null]]) {
                return false;
            }
        }
        if (node.rightNode && ![node.rightNode isEqual:[NSNull null]] ) {
            [queue enqueue:node.rightNode];
        } else {
            // 有左子树，但是没有右子树，那么这个节点就一定是叶子节点
            isLeaf = YES;
        }
    }
    
    return isComplete;
}
@end
