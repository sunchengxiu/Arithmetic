//
//  SCXListGraph.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/8/2.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXListGraph.h"
#import "SCXCircleArrayQueue.h"
#pragma mark - vertex
@class SCXGraphEdge;
/// 图的顶点：V->SCXGraphVertex
@interface SCXGraphVertex<V,E> : NSObject

/// 顶点的值
@property (nonatomic,strong) V vertex;

/// 所有以该顶点为终点的边,入度的边
@property (nonatomic , strong)NSHashTable<SCXGraphEdge *> *inEdges;

/// 所有以该顶点为起点的边，出度的边
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
    return [super hash];
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

/// 添加顶点，将顶点全局保存一份，顶点的值为key，value为SCXGraphVertex对象
/// @param v 顶点的值
- (void)addVertex:(id)v{
    if (!v) {
        return;
    }
    if ([self.vertices objectForKey:v]) {
        return;
    }
    [self.vertices setObject:[[SCXGraphVertex alloc] initWithVertex:v] forKey:v];
}

/// 添加边
/// @param from 边的起点
/// @param to 边的终点
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
- (void)removeVertex:(id)v{
    // 先从所有顶点缓存中删除这个顶点
    SCXGraphVertex *vertex = [self.vertices objectForKey:v];
    if (!vertex) {
        return;
    }
    
    // 删除和这个顶点有关的边
    // 先删除以这个顶点为起点的边
    NSEnumerator *outObjEnumerator = vertex.outEdges.objectEnumerator;
    SCXGraphEdge *outEdge;
    while ((outEdge = outObjEnumerator.nextObject) != nil) {
        // 取出每一条边
        // 取出这条边之后，将这条边的终点的顶点，到这个终点的顶点的边删除
        [outEdge.to.inEdges removeObject:outEdge];
        [self.edges removeObject:outEdge];
    }
    [vertex.outEdges removeAllObjects];
    // 先删除以这个顶点为终点的边
    NSEnumerator *inObjEnumerator = vertex.inEdges.objectEnumerator;
    SCXGraphEdge *inEdge;
    while ((inEdge = inObjEnumerator.nextObject) != nil) {
        // 取出每一条边
        // 取出这条边之后，将这条边的终点的顶点，到这个终点的顶点的边删除
        [inEdge.from.outEdges removeObject:inEdge];
        [self.edges removeObject:inEdge];
    }
    [vertex.inEdges removeAllObjects];
    [self.vertices removeObjectForKey:v];
}

/// 移除一条边
/// @param from 边的起点
/// @param to 边的终点
- (void)removeEdge:(id)from to:(id)to{
    // 找到起点和终点对应的顶点值
    SCXGraphVertex *fromVertex = [self.vertices objectForKey:from];
    SCXGraphVertex *toVertex = [self.vertices objectForKey:to];
    if (!fromVertex || !toVertex) {
        return;
    }
    
    // 根据这两个顶点构建一条边
    // 边的起点和终点相等，就认为是同一条边
    SCXGraphEdge *edge = [[SCXGraphEdge alloc] initWithFrom:from to:to];
    if ([fromVertex.outEdges containsObject:edge]) {
        [fromVertex.outEdges removeObject:edge];
    }
    if ([toVertex.inEdges containsObject:edge]) {
        [toVertex.inEdges removeObject:edge];
    }
    if ([self.edges containsObject:edge]) {
        [self.edges removeObject:edge];
    }
}
- (void)BFS:(id)begin{
    // 广度优先搜索，就和之前的二叉树遍历一样，利用队列，先将一个顶点入队，然后将这个顶点出对，然后将这个顶点相关联的子节点，这里是以这个顶点为起点的边，也就是outEdges里面的边，依次再入队，然后这样循环下去
    SCXGraphVertex *beginVertex = [self.vertices objectForKey:begin];
    if (!beginVertex) {
        return;
    }
    // 创建队列
    SCXCircleArrayQueue *queue = [SCXCircleArrayQueue arrayQueue];
    // 入队
    [queue enqueue:beginVertex];
    // 保存已经访问过的顶点
    NSMutableArray *visitedVertex = [NSMutableArray array];
    [visitedVertex addObject:beginVertex];
    
    while (!queue.isEmpty) {
        // 出对一个
        SCXGraphVertex *v = queue.dequeue;
        NSLog(@"%@",v.vertex);
        
        // 将跟这个顶点有关的边入队
        for (SCXGraphEdge *edge in v.outEdges) {
            if ([visitedVertex containsObject:edge.to]) {
                continue;
            }
            [queue enqueue:edge.to];
            [visitedVertex addObject:edge.to];
        }
    }
}
- (void)printGraph{
    NSEnumerator *enumerator = self.vertices.keyEnumerator ;
    id obj;
    NSLog(@"【顶点-------】");
    while ((obj = enumerator.nextObject) != nil) {
        SCXGraphVertex *v = [self.vertices objectForKey:obj];
        NSLog(@"key:%@",obj);
        NSLog(@"outEdges:%@",v.outEdges);
        NSLog(@"inEdgesL%@",v.inEdges);
    }
    NSLog(@"【边-------】");
    NSEnumerator *edgeEnumerator = self.edges.objectEnumerator;
    SCXGraphEdge *edge ;
    while ((edge = edgeEnumerator.nextObject) != nil) {
        NSLog(@"%@",edge);
    }
}
@end
