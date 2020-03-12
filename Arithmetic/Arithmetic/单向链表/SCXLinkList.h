//
//  SCXLinkList.h
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/12.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCXLinkList<ObjectType> : NSObject
- (void)addToHead:(ObjectType)object;
- (void)addToTail:(ObjectType)object;
- (ObjectType)removeObjectAtIndex:(NSInteger)index;
- (ObjectType)objectAtIndex:(NSInteger)index;
- (ObjectType)removeFirstObject;
- (ObjectType)removeLastObject;
- (void)addObject:(ObjectType)object atIndex:(NSInteger)index;
- (void)updateObject:(ObjectType)object atIndex:(NSInteger)index;
- (BOOL)containObject:(ObjectType)object;
@property (nonatomic,strong,readonly)ObjectType firstObject;
@property (nonatomic,strong,readonly)ObjectType lastObject;

@end

NS_ASSUME_NONNULL_END
