//
//  SCXBinarySearchTree+Private.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/5/4.
//  Copyright © 2020 孙承秀. All rights reserved.
//


#import "SCXBinaryTreeProtocol.h"
#import "SCXBinarySearchTree.h"
NS_ASSUME_NONNULL_BEGIN
// __contravariant
@interface SCXBinaryNode<__contravariant ObjectType> : NSObject
@property(nonatomic,strong)ObjectType value;
@property(nonatomic,strong)SCXBinaryNode *leftNode;
@property(nonatomic,strong)SCXBinaryNode *rightNode;
@property(nonatomic,strong)SCXBinaryNode *parent;
- (instancetype)initWithValue:(ObjectType)value parentNode:(SCXBinaryNode *)parent;
- (BOOL)isLeafNode;
- (BOOL)hasTwoChildren;
- (BOOL)isLeftChild;
- (BOOL)isRightChild;
@end
@interface SCXAVLNode<__covariant ObjectType> : SCXBinaryNode
@property(nonatomic,strong)SCXBinaryNode *rootNode;
@property(nonatomic,assign)NSInteger height;
// 平衡因子
- (NSInteger)blanceFactor;
@end

@interface SCXBinarySearchTree ()
- (void)addNewNodeAfter:(SCXBinaryNode *)node;
- (SCXBinaryNode *)createNodeWithValue:(id)value parentNode:(SCXBinaryNode *)parent;
@end

NS_ASSUME_NONNULL_END
