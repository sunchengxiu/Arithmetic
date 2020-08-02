//
//  SCXQuickUnion_Size.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/28.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXQuickUnion_Size.h"
@interface SCXUnionFind()
@property (nonatomic , strong) NSMutableArray *parents;
@property (nonatomic , strong) NSMutableArray *sizes;

@end
@implementation SCXQuickUnion_Size
-(instancetype)initWithCapicity:(NSUInteger)capicity{
    if (self = [super initWithCapicity:capicity]) {
        self.sizes = [NSMutableArray arrayWithCapacity:capicity];
        for (int i = 0 ; i < capicity; i ++) {
            self.sizes[i] = @1;
         }
    }
    return self;
}
- (NSUInteger)find:(NSUInteger)v{
    if (v >= self.parents.count) {
        return -1;
    }
    // 找到根节点
    while (v != ((NSNumber *)(self.parents[v])).integerValue) {
        // 继续向上找，找这个节点的根节点
        // 直到自己是根节点就到头了
        v = ((NSNumber *)(self.parents[v])).integerValue;
    }
    return v;
}
- (void)unionValue:(NSUInteger)value1 value2:(NSUInteger)value2{
    NSInteger v1 = [self find:value1];
    NSInteger v2 = [self find:value2];
    if (v1 == v2) {
        return;
    }
    // 将v1的根节点变为v2
    self.parents[v1] = [NSNumber numberWithInteger:value2];
}
@end
