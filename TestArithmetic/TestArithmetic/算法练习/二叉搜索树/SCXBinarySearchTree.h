//
//  SCXBinarySearchTree.h
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXBinaryTreeProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface SCXBinaryIterator : NSObject

/// 是否停止遍历
@property(nonatomic,assign)BOOL stop;

/// value
@property(nonatomic,strong)id obj;

@end
typedef void (^Iterator)(id obj , BOOL *stop);
@interface SCXBinarySearchTree : NSObject<SCXBinaryTreeProtocol>
- (BOOL)isEmpty;
- (void)clear;
- (void)addObject:(id <SCXBinaryTreeProtocol>)obj;
- (void)removeObject:(id <SCXBinaryTreeProtocol>)obj;
- (void)containsObject:(id <SCXBinaryTreeProtocol>)obj;
- (int)size;
- (int)binaryHeight;

#pragma mark - 遍历


/// 前序遍历
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)preorderTraversal:(Iterator)iterator;


/// 中序遍历
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)inorderTraversal:(Iterator)iterator;


/// 后续遍历
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)postorderTraversal:(Iterator)iterator;

/// 层序遍历
/// @param iterator 通过遍历器返回对应的值，如果stop设置为YES，则停止遍历
- (void)levelorderTraversal:(Iterator)iterator;

@end

NS_ASSUME_NONNULL_END
