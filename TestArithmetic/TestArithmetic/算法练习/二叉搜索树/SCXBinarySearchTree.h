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


@interface SCXBinarySearchTree : NSObject<SCXBinaryTreeProtocol>
- (BOOL)isEmpty;
- (void)clear;
- (void)addObject:(id <SCXBinaryTreeProtocol>)obj;
- (void)removeObject:(id <SCXBinaryTreeProtocol>)obj;
- (void)containsObject:(id <SCXBinaryTreeProtocol>)obj;
- (int)size;
@end

NS_ASSUME_NONNULL_END
