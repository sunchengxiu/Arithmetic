//
//  SCXBinarySearchTree.m
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import "SCXBinarySearchTree.h"
#import "SCXCircleArrayQueue.h"
#import "SCXStack.h"
#import "SCXBinarySearchTree+Private.h"

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
        [self addNewNodeAfter:_rootNode];
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
    [self addNewNodeAfter:newNode];
}
-(void)addNewNodeAfter:(SCXBinaryNode *)node{
    
}
-(void)removeObject:(id<SCXBinaryTreeProtocol>)obj{
    if (![self isEnable:obj]) {
        return;
    }
    SCXBinaryNode *node = [self node:obj];
    if (node) {
        // 移除度为2的节点
        if ([node hasTwoChildren]) {
            // 找到前驱节点
            SCXBinaryNode *preNode = [self _preNode:obj];
            // 用前驱节点的值，覆盖当前节点
            node.value = preNode.value;
            // 移除前驱结点,相当于移除度为1的节点
            node = preNode;
        }
        
        // 移除度为1的节点
        SCXBinaryNode *child = node.leftNode ? node.leftNode : node.rightNode;
        if (child != nil) { // 说明度为1
            child.parent = node.parent;
            if (node.parent == nil) {
                // 度为1的根节点
                _rootNode = child;
            } else if (node == node.parent.leftNode) {
                // 左节点接上
                node.parent.leftNode = child;
            } else if (node == node.parent.rightNode){
                // 右节点接上
                node.parent.rightNode = child;
            }
            
        } else if (node.parent == nil){
            // 根节点
            _rootNode = nil;
        } else {
            // 叶子节点
            if (node.parent.leftNode == node) {
                node.parent.leftNode = nil;
            } else {
                node.parent.rightNode = nil;
            }
        }
    }
    
    
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
-(BOOL)containsObject:(id<SCXBinaryTreeProtocol>)obj{
    SCXBinaryNode *node = [self node:obj];
    return node != nil;
}
- (SCXBinaryNode *)node:(id <SCXBinaryTreeProtocol>)value{
    if (![self isEnable:value]) {
        return nil;
    }
    SCXBinaryNode *root = _rootNode;
    while (root != nil) {
        int cmp = [value compare:root.value];
        if (cmp == 0) {
            return root;
        }
        if (cmp > 0) {
            root = root.rightNode;
        } else {
            root = root.leftNode;
        }
    }
    return nil;
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
-(void)preorderTraversalWithRecursion:(Iterator)iterator{
    BOOL stop = NO;
    [self _preorderTraversal1:_rootNode iterator:iterator stop:&stop] ;
}
// 递归前序遍历
-(void)_preorderTraversal1:(SCXBinaryNode *)rootNode iterator:(Iterator)iterator stop:(BOOL *)stop{
    if (![self isContinue:iterator rootNode:rootNode stop:stop]) return ;
    [self iterator:iterator rootNode:rootNode stop:stop];
    if (*stop) return;
    [self _preorderTraversal:rootNode.leftNode iterator:iterator stop:stop];
    [self _preorderTraversal:rootNode.rightNode iterator:iterator stop:stop];
}
// 迭代前序遍历
-(void)_preorderTraversal:(SCXBinaryNode *)rootNode iterator:(Iterator)iterator stop:(BOOL *)stop{
    if (![self isContinue:iterator rootNode:rootNode stop:stop]) return ;
    SCXStack *stack = [[SCXStack alloc] init];
    SCXBinaryNode *node = rootNode;
    while (node != nil || ![stack isEmpty]) {
        if (node != nil) {
            [self iterator:iterator rootNode:node stop:stop];
            if (*stop) return;
            [stack push:node];
            node = node.leftNode;
        } else {
            // 访问右节点，相当于向上回退，后进先出
            // 相当于出栈一个父节点
            SCXBinaryNode *parent = [stack pop];
            node = parent.rightNode;
        }
    }
}
-(void)inorderTraversal:(Iterator)iterator{
    BOOL stop = NO;
    [self _inorderTraversal1:_rootNode iterator:iterator stop:&stop];
}
-(void)inorderTraversalWithRecursion:(Iterator)iterator{
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
-(void)_inorderTraversal1:(SCXBinaryNode *)rootNode iterator:(Iterator)iterator stop:(BOOL *)stop{
    if (![self isContinue:iterator rootNode:rootNode stop:stop]) return ;
    SCXStack *stack = [[SCXStack alloc] init];
    SCXBinaryNode *node = rootNode;
    while (node != nil || ![stack isEmpty]) {
        if (node != nil) {
            [stack push:node];
            node = node.leftNode;
        } else {
            SCXBinaryNode *parent = [stack pop];
            // 左节点到头了，开始打印做孩子，然后找到父节点
            [self iterator:iterator rootNode:parent stop:stop];
            if (*stop) return;
            node = parent.rightNode;
        }
    }
}
-(void)postorderTraversal:(Iterator)iterator{
    BOOL stop = NO;
    [self _postorderTraversal1:_rootNode iterator:iterator stop:&stop];
}
-(void)postorderTraversalWithRecursion:(Iterator)iterator{
    BOOL stop = NO;
    [self _postorderTraversal:_rootNode iterator:iterator stop:&stop];
}
-(void)_postorderTraversal1:(SCXBinaryNode *)rootNode iterator:(Iterator)iterator stop:(BOOL *)stop{
    if (![self isContinue:iterator rootNode:rootNode stop:stop]) return ;
    SCXStack *stack = [[SCXStack alloc] init];
    SCXBinaryNode *node = rootNode;
    SCXBinaryNode *preNode = nil;
    /*
     因为后序遍历顺序为左右根，根节点u最后一个访问，所以我们需要先访问所有的左节点，然后打印，然后找到右子树，然后用同样的规则继续查找，所以我们就需要注意根节点的打印，需要在右节点访问完之后才可以。
     */
    while (node != nil || ![stack isEmpty]) {
        // 遍历左右左节点放进去
        while (node != nil) {
            [stack push:node];
            node = node.leftNode;
        }
        if (![stack isEmpty]) {
            node = [stack pop];
            // 左子树访问完了，看是否有右子树，如果没有，打印当前节点,因为没有右节点，那么根节点一定在右节点之后
            // 如果右节点被访问过，那么当前根节点也允许输出,因为右节点访问完了，该访问根节点了
            // 右子树也访问完了，从最后一个右子树往上弹出。
            if (!node.rightNode || node.rightNode == preNode) {
                [self iterator:iterator rootNode:node stop:stop];
                if (*stop) return;
                preNode = node;
                // 防止又进入一次,因为左节点已经访问完了
                node = nil;
            } else {
                // 当前节点入栈
                [stack push:node];
                // 右子树循环
                node = node.rightNode;
            }
        }
    }
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
-(id<SCXBinaryTreeProtocol>)invertTree{
    return [self _invertTree:_rootNode];
}

/// 递归实现反转二叉树
-(id<SCXBinaryTreeProtocol>)_invertTree1:(SCXBinaryNode *)node{
    if (node == nil) {
        return nil;
    }
    if (node.leftNode != nil || node.rightNode != nil) {
        SCXBinaryNode *tmp = node.leftNode;
        node.leftNode = node.rightNode;
        node.rightNode = tmp;
    }
    [self _invertTree:node.leftNode];
    [self _invertTree:node.rightNode];
    return node.value;
}
/// 迭代实现反转二叉树
-(id<SCXBinaryTreeProtocol>)_invertTree:(SCXBinaryNode *)node{
    if (node == nil) {
        return nil;
    }
    SCXCircleArrayQueue *queue = [SCXCircleArrayQueue arrayQueue];
    [queue enqueue:_rootNode];
    while (![queue isEmpty]) {
        SCXBinaryNode *node = [queue dequeue];
        if (node.leftNode || node.rightNode) {
            SCXBinaryNode *tmp = node.leftNode;
            node.leftNode = node.rightNode;
            node.rightNode = tmp;
        }
        if (node.leftNode) {
            [queue enqueue:node.leftNode];
        }
        if (node.rightNode) {
            [queue enqueue:node.rightNode];
        }
    }
    return node.value;
}
/*
 前驱结点：中序遍历时候的前一个节点。
 
 二叉搜索树，前驱结点，是他的左子树的最大的那个节点，也就是一定在最右边，一直往右找，如果不是二叉搜索树，那也使用，因为他的前驱结点，是中序遍历的前一个节点，中序遍历的左根右，也是最后遍历右节点，所以，如果这个节点的左子树存在，那么就找这个左子树沿着右子树找到最后一个就行了。
 
 pre = node.left.right.right.right.right... 一直到 null
 
 如果node的left为空，那么他的额前驱结点为，一直往上找父节点，直到当前节点为父节点的右子树，就停止。那么这个父节点就为前驱结点，循环往上找，知道当前node为node.parent的right就停止,那么这个node就为我们要找的，如果一直晚上找，突然发现父节点为空了，那么这个节点就没有前驱结点。
 
 如果这个节点没有左子树也没有父节点，那么这个节点没有前驱结点
 */
-(id<SCXBinaryTreeProtocol>)preNode:(id<SCXBinaryTreeProtocol>)value{
    if (!value) {
        return nil;
    }
    SCXBinaryNode *node = [self node:value];
    if (!node) {
        return nil;
    }
    // 如果存在左子树
    if (node.leftNode) {
        node =node.leftNode;
        // 找到最后一个右节点
        while (node.rightNode) {
            node = node.rightNode;
        }
        return node.value;
    }
    // 没有左子树，向上找
    while (node.parent && node == node.parent.leftNode) {
        node = node.parent;
    }
    
    // 当前节点为父节点的右节点，也就是第一个比自己小的,也就是找到这样的节点 1 < current < 3,如果当前为2.
    /*
     1
     3
     2
     
     找到2的前驱节点，为1.
     
     */
    return node.parent.value;
}
-(SCXBinaryNode *)_preNode:(id<SCXBinaryTreeProtocol>)value{
    if (!value) {
        return nil;
    }
    SCXBinaryNode *node = [self node:value];
    if (!node) {
        return nil;
    }
    // 如果存在左子树
    if (node.leftNode) {
        node =node.leftNode;
        // 找到最后一个右节点
        while (node.rightNode) {
            node = node.rightNode;
        }
        return node;
    }
    // 没有左子树，向上找
    while (node.parent && node == node.parent.leftNode) {
        node = node.parent;
    }
    
    // 当前节点为父节点的右节点，也就是第一个比自己小的,也就是找到这样的节点 1 < current < 3,如果当前为2.
    /*
     1
     3
     2
     
     找到2的前驱节点，为1.
     
     */
    return node.parent;
}
@end
