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
- (ObjectType)addToHead:(ObjectType)object;
- (ObjectType)addToTail:(ObjectType)object;
- (ObjectType)removeObjectAtIndex:(NSInteger)index;
- (ObjectType)objectAtIndex:(NSInteger)index;
- (ObjectType)removeFirstObject;
- (ObjectType)removeLastObject;
- (ObjectType)addObject:(ObjectType)object atIndex:(NSInteger)index;
- (ObjectType)setObject:(ObjectType)object atIndex:(NSInteger)index;
- (void)deleteObject:(ObjectType)object;
- (BOOL)containObject:(ObjectType)object;
- (NSInteger)indexOfObject:(ObjectType)object;
- (void)clear;
@property (nonatomic,strong,readonly)ObjectType firstObject;
@property (nonatomic,strong,readonly)ObjectType lastObject;

@end

NS_ASSUME_NONNULL_END
