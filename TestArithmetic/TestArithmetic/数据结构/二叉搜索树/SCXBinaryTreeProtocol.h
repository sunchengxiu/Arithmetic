//
//  SCXBinaryTreeProtocol.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SCXBinaryTreeProtocol <NSObject>

@required

/// 必须实现这个方法，用于比较大小，插入到左子树或者右子树，如果返回0，表示当前节点和父节点相等，如果小于0，表示比父节点小，插入到左子树，反之插入到右子树
/// @param preNode 父节点
-(int)compare:(id <SCXBinaryTreeProtocol>)preNode;

@end

NS_ASSUME_NONNULL_END
