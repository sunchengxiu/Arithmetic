//
//  SCXStack.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/4/2.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface SCXStack<ObjectType> : NSObject
/// 入栈
/// @param obj 入栈元素
- (void)push:(ObjectType)obj;

/// 出栈
- (ObjectType)pop;

/// 栈是否为空
- (BOOL)isEmpty;

/// 栈长度
- (NSInteger)length;

/// 清空栈所有元素
-(void)removeAllObjects;

/// 栈顶
-(id)top;
@end

NS_ASSUME_NONNULL_END
