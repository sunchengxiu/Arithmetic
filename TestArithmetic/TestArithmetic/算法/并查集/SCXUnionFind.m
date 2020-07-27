//
//  SCXUnionFind.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/27.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXUnionFind.h"
@interface SCXUnionFind()
@property (nonatomic , strong) NSMutableArray *parents;
@end
@implementation SCXUnionFind
-(instancetype)initWithCapicity:(NSUInteger)capicity{
   if (capicity <= 0) {
       return nil;
   }
   if (self = [self init]) {
       _parents = [NSMutableArray arrayWithCapacity:capicity];
       for (int i = 0 ; i < capicity; i ++) {
           _parents[i] = @(i);
       }
   }
   return self;
}
-(NSUInteger)find:(NSUInteger)v{
    if (v >= self.parents.count) {
        return -1;
    }
    NSNumber *cur = _parents[v];
    return cur.integerValue;
}
- (void)unionValue:(NSUInteger)value1 value2:(NSUInteger)value2{
    if (value1 >= self.parents.count || value2 >= self.parents.count) {
        return;
    }
    // 查找v1和 v2 的根节点
    NSUInteger v1 = [self find:value1];
    NSUInteger v2 = [self find:value2];
    // 如果根节点相同，证明在一个集合里
    if (v1 == v2) {
        return;
    }
    // 否则就把根节点是v1的变为v2，称为一个集合
    // 合并其实就是将一个集合合并到另一个集合里面，原理就是，第一个集合有一个共同的根节点，当两个集合合并的时候，就将两个集合的根节点，变为一个根节点就可以了，下面的的做法就是将第一个集合的根节点都指向第二个集合的根节点
    for (int i = 0 ; i < self.parents.count; i ++) {
        NSNumber *cur = self.parents[i];
        if (cur.integerValue == v1) {
            NSNumber *replace = [NSNumber numberWithInteger:v2];
            self.parents[i] = replace;
        }
    }
}
- (BOOL)isSame:(NSUInteger)v1 value2:(NSUInteger)v2{
    return [self find:v2] == [self find:v1];
}
@end
