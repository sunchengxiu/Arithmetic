//
//  SCXListGraph.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/8/2.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXListGraph.h"

#pragma mark - vertex
@class SCXGraphEdge;
/// 图的顶点：V->SCXGraphVertex
@interface SCXGraphVertex<V,E> : NSObject

/// 顶点的值
@property (nonatomic,strong) V vertex;

/// 所有以该顶点为终点的边
@property (nonatomic , strong)NSHashTable<SCXGraphEdge *> *inEdges;

/// 所有以该顶点为起点的边
@property (nonatomic , strong)NSHashTable<SCXGraphEdge *> *outEdges;

- (instancetype)initWithVertex:(V)vertex;

@end

@implementation SCXGraphVertex

- (instancetype)initWithVertex:(id)vertex{
    if (self = [super init]) {
        self.vertex = vertex;
        self.inEdges = [NSHashTable hashTableWithOptions:(NSPointerFunctionsStrongMemory)];
        self.outEdges = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
    }
    return self;
}
/// 顶点的值相等就认为是一个顶点
- (BOOL)isEqual:(id)object{
    SCXGraphVertex *vertex = (SCXGraphVertex *)object;
    return [vertex.vertex isEqual:self.vertex];
}
- (NSUInteger)hash{
    return ((NSString *)self.vertex).hash;
}
- (NSString *)description{
    return self.vertex;
}
@end



#pragma mark - edge

/// 图的边：E->SCXGraphEdge
@interface SCXGraphEdge<V,E> : NSObject
// 边的权重
@property (nonatomic , strong) E weigth;
// 边的起点
@property (nonatomic , strong) SCXGraphVertex<V , E> *from;

/// 边的终点
@property (nonatomic , strong) SCXGraphVertex<V , E> *to;

@end

@implementation SCXGraphEdge

- (instancetype)initWithFrom:(id)from to:(id)to{
    if (self = [super init]) {
        self.from = from;
        self.to = to;
    }
    return self;
}

/// 边的起点和终点相等，就认为是同一条边
- (BOOL)isEqual:(id)object{
    SCXGraphEdge *edge = (SCXGraphEdge *)object;
    return [self.from isEqual:edge.from] && [self.to isEqual:edge.to];
}
- (NSUInteger)hash{
    return self.from.hash ^ self.to.hash;
}
- (NSString *)description{
    return [NSString stringWithFormat:@"from:%@,to:%@,weigth:%@",self.from,self.to,self.weigth];
}
@end

#pragma mark - graph
@interface SCXListGraph ()

/// 所有顶点的集合,v->SCXGraphVertex，一个顶点对应一个对象
@property (nonatomic , strong) NSMapTable<id , SCXGraphVertex *> *vertices;

/// 存放所有的边
@property (nonatomic , strong) NSHashTable<SCXGraphEdge *> *edges;
@end
@implementation SCXListGraph
- (instancetype)init{
    if (self = [super init]) {
        self.vertices = [NSMapTable mapTableWithKeyOptions:(NSPointerFunctionsStrongMemory) valueOptions:(NSPointerFunctionsStrongMemory)];
        self.edges = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
    }
    return self;;
}
- (NSUInteger)verticesSize{
    return self.vertices.count;
}
- (NSUInteger)edgesSize{
    return self.edges.count;
}
- (void)addVertex:(id)v{
    if (!v) {
        return;
    }
    if ([self.vertices objectForKey:v]) {
        return;
    }
    [self.vertices setObject:[[SCXGraphVertex alloc] initWithVertex:v] forKey:v];
}
- (void)addEdge:(id)from to:(id)to{
    [self addEdge:from to:to weigth:[NSNumber numberWithInteger:NSIntegerMax]];
}
- (void)addEdge:(id)from to:(id)to weigth:(id)weight{
    if (!from || !to) {
        return;
    }
    // 找到之前存在的起点和终点
    SCXGraphVertex *fromVeretex = [self.vertices objectForKey:from];
    SCXGraphVertex *toVeretex = [self.vertices objectForKey:to];
    if (!fromVeretex) {
        fromVeretex = [[SCXGraphVertex alloc] initWithVertex:from];
        [self.vertices setObject:fromVeretex forKey:from];
    }
    if (!toVeretex) {
        toVeretex = [[SCXGraphVertex alloc] initWithVertex:to];
        [self.vertices setObject:toVeretex forKey:to];
    }
    
    // 先找边，将之前删除，有可能有边，但是权值不同
    SCXGraphEdge *edge = [[SCXGraphEdge alloc] initWithFrom:fromVeretex to:toVeretex];
    edge.weigth = weight;
    // 调用 isEqual 判断边是否相等。
    // 将原来的边删除，将新的边加进去
    // 出
    if ([fromVeretex.outEdges containsObject:edge]) {
        [fromVeretex.outEdges removeObject:edge];
    }
    [fromVeretex.outEdges addObject:edge];
    
    // 入
    if ([toVeretex.inEdges containsObject:edge]) {
        [toVeretex.inEdges removeObject:edge];
    }
    [toVeretex.inEdges addObject:edge];
    
    // 总
    if ([self.edges containsObject:edge]) {
        [self.edges removeObject:edge];
    }
    [self.edges addObject:edge];
}
- (void)printGraph{
    NSEnumerator *enumerator = self.vertices.keyEnumerator ;
    id obj;
    while ((obj = enumerator.nextObject) != nil) {
        SCXGraphVertex *v = [self.vertices objectForKey:obj];
        NSLog(@"key:%@",obj);
        NSLog(@"outEdges:%@",v.outEdges);
        NSLog(@"inEdgesL%@",v.inEdges);
    }
}
@end
