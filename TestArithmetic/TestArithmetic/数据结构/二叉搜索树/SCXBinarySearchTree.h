//
//  SCXBinarySearchTree.h
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 RongCloud. All rights reserved.
//
//https://www.cs.usfca.edu/~galles/visualization/Algorithms.html
#import <Foundation/Foundation.h>
#import "SCXBinaryTreeProtocol.h"
NS_ASSUME_NONNULL_BEGIN
/// 遍历器，每次回调遍历的值和允许手动停止
typedef void (^Iterator)(id obj , BOOL *stop);
@interface SCXBinarySearchTree : NSObject

/// 二叉树是否为空
- (BOOL)isEmpty;

/// 清空二叉树
- (void)clear;

/// 往二叉树插入元素，需要实现 SCXBinaryTreeProtocol 这个协议，并且实现协议的方法，目的是为了随意传入任何对象，然后自己去根据自己的需求比较两个节点的大小，也可通过传入一个 SEL，一个比较方法，然后去比较
/// @param obj 插入的元素
- (void)addObject:(id <SCXBinaryTreeProtocol>)obj;

/// 移除某个节点
/// @param obj 移除的节点
- (void)removeObject:(id <SCXBinaryTreeProtocol>)obj;

/// 是否包含某个节点
/// @param obj 某个节点
- (BOOL)containsObject:(id <SCXBinaryTreeProtocol>)obj;

/// 二叉树已经存在节点个数
- (int)size;

/// 二叉树高度
- (int)binaryHeight;

/// 是否为完全二叉树,
/// 叶子节点只能出现在最后两层，并且最后一层叶子节点只能靠左对齐，也就是说只能有左节点才能有右节点
/// 度为1的节点只能有左子树
/// 度为1的节点要么是1个要么是0个
- (BOOL)isCompleteBinaryTree;

/// 反转二叉树
- (id <SCXBinaryTreeProtocol>)invertTree;

#pragma mark - 遍历

/// 前序遍历（迭代）
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)preorderTraversal:(Iterator)iterator;

/// 前序遍历（递归）
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)preorderTraversalWithRecursion:(Iterator)iterator;


/// 中序遍历（迭代）
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)inorderTraversal:(Iterator)iterator;

/// 中序遍历（递归）
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)inorderTraversalWithRecursion:(Iterator)iterator;


/// 后续遍历（迭代）
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)postorderTraversal:(Iterator)iterator;

/// 后续遍历（递归）
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)postorderTraversalWithRecursion:(Iterator)iterator;

/// 层序遍历（迭代）
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)levelorderTraversal:(Iterator)iterator;

/// 前驱节点
- (id <SCXBinaryTreeProtocol>)preNode:(id <SCXBinaryTreeProtocol>)node;

/// 后继节点

-(id <SCXBinaryTreeProtocol>)successorNode:(id<SCXBinaryTreeProtocol>)value;

@end

NS_ASSUME_NONNULL_END
