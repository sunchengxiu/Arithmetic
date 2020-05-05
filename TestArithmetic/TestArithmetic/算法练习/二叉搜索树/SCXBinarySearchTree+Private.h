//
//  SCXBinarySearchTree+Private.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/5/4.
//  Copyright © 2020 孙承秀. All rights reserved.
//


#import "SCXBinaryTreeProtocol.h"
#import "SCXBinarySearchTree.h"
// __contravariant
@interface SCXBinaryNode<__contravariant ObjectType> : NSObject
@property(nonatomic,strong)ObjectType _Nullable value;
@property(nonatomic,strong)SCXBinaryNode * _Nullable leftNode;
@property(nonatomic,strong)SCXBinaryNode * _Nullable rightNode;
@property(nonatomic,strong)SCXBinaryNode * _Nullable parent;
- (instancetype _Nullable )initWithValue:(ObjectType _Nonnull )value parentNode:(SCXBinaryNode *_Nonnull)parent;
- (BOOL)isLeafNode;
- (BOOL)hasTwoChildren;
- (BOOL)isLeftChild;
- (BOOL)isRightChild;
@end
@interface SCXAVLNode<__covariant ObjectType> : SCXBinaryNode
@property(nonatomic,strong)SCXBinaryNode * _Nullable rootNode;
@property(nonatomic,assign)NSInteger height;
// 平衡因子
- (NSInteger)blanceFactor;
@end
NS_ASSUME_NONNULL_BEGIN
@interface SCXBinarySearchTree ()
- (void)addNewNodeAfter:(SCXBinaryNode *)node;
- (void)removeNodeAfter:(SCXBinaryNode *)node;
- (SCXBinaryNode *)createNodeWithValue:(id)value parentNode:(SCXBinaryNode *)parent;
@end

NS_ASSUME_NONNULL_END
