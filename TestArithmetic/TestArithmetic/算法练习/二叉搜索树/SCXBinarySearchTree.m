//
//  SCXBinarySearchTree.m
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import "SCXBinarySearchTree.h"
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
            // 相等直接返回
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
@end
