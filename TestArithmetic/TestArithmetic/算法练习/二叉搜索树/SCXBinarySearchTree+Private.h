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
@property(nonatomic,strong)ObjectType _Nullable value;
@property(nonatomic,strong)SCXBinaryNode * _Nullable leftNode;
@property(nonatomic,strong)SCXBinaryNode * _Nullable rightNode;
@property(nonatomic,strong)SCXBinaryNode * _Nullable parent;
- (instancetype)initWithValue:(ObjectType _Nonnull )value parentNode:(SCXBinaryNode *_Nonnull)parent;
- (BOOL)isLeafNode;
- (BOOL)hasTwoChildren;
- (BOOL)isLeftChild;
- (BOOL)isRightChild;

/// 兄弟节点
- (SCXBinaryNode *)sibling;
@end



/// AVL node
@interface SCXAVLNode<__covariant ObjectType> : SCXBinaryNode
@property(nonatomic,strong)SCXBinaryNode * _Nullable rootNode;
@property(nonatomic,assign)NSInteger height;
// 平衡因子
- (NSInteger)blanceFactor;
@end

typedef NS_ENUM(NSUInteger, SCXRBColorType) {
    SCXRBColorTypeRed,// 红
    SCXRBColorTypeBlack, // 黑
};
/// 红黑树节点
@interface SCXRBNode<__covariant ObjectType> : SCXBinaryNode

/// 当前节点颜色
@property(nonatomic,assign)SCXRBColorType color;
@end


@interface SCXBinarySearchTree ()
- (void)addNewNodeAfter:(SCXBinaryNode *)node;
- (void)removeNodeAfter:(SCXBinaryNode *)node;
- (SCXBinaryNode *)createNodeWithValue:(id)value parentNode:(SCXBinaryNode *)parent;
@end

NS_ASSUME_NONNULL_END
