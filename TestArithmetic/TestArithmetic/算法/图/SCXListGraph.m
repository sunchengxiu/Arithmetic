//
//  SCXListGraph.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/8/2.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXListGraph.h"
#import "SCXCircleArrayQueue.h"
#import "SCXStack.h"
#import "SCXCircleArrayQueue.h"
#pragma mark - vertex
@class SCXGraphEdge;
/// 图的顶点：V->SCXGraphVertex
@interface SCXGraphVertex<V,E> : NSObject<NSCopying>

/// 顶点的值
@property (nonatomic,strong) V vertex;

/// 所有以该顶点为终点的边,入度的边
@property (nonatomic , strong)NSHashTable<SCXGraphEdge *> *inEdges;

/// 所有以该顶点为起点的边，出度的边
@property (nonatomic , strong)NSHashTable<SCXGraphEdge *> *outEdges;

- (instancetype)initWithVertex:(V)vertex;

@end

@implementation SCXGraphVertex
// 这样就可以这个对象当做key放到字典中了。
- (id)copyWithZone:(NSZone *)zone {
    SCXGraphVertex *ver = [[SCXGraphVertex alloc] init];
//    ver.inEdges = self.inEdges;
//    ver.outEdges = self.outEdges;
    ver.vertex = self.vertex;
    return ver;
}
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
// 深度优先搜索，利用递归
- (void)DFS:(id)begin{
    SCXGraphVertex *beginVertex = [self.vertices objectForKey:begin];
    // 防止重复访问
    NSMutableArray *visitedVertices = [NSMutableArray array];
    if (!beginVertex) {
        return;
    }
    //    [self DFSrecursion:beginVertex visitedVertices:visitedVertices];
    [self DFSStack:beginVertex visitedVertices:visitedVertices];
}
/// 利用递归来实现
- (void)DFSrecursion:(SCXGraphVertex *)vertex visitedVertices:(NSMutableArray *)visited{
    // 沿着根节点，一直向下找，直到，到底，到底了之后，一次向上回退，然后再找另一个条路径，也就相当于左右节点路径，这里是相当于每一条边,利用递归可以做到，一直向下找，然后回退
    NSLog(@"%@",vertex.vertex);
    [visited addObject:vertex];
    for (SCXGraphEdge *edge in vertex.outEdges) {
        if ([visited containsObject:edge.to]) {
            continue;
        }
        [self DFSrecursion:edge.to visitedVertices:visited];
    }
}
/// 利用栈来实现
- (void)DFSStack:(SCXGraphVertex *)veretex visitedVertices:(NSMutableArray *)visited{
    // 然后将当前节点添加到已经访问的集合中去
    [visited addObject:veretex];
    // 创建栈
    SCXStack *stack = [[SCXStack alloc] init];
    // 入栈
    [stack push:veretex];
    // 将第一个节点打印
    NSLog(@"%@",veretex.vertex);
    
    while (!stack.isEmpty) {
        // 出栈
        SCXGraphVertex *cur = [stack pop];
        // 将出栈的这个顶点的from 和 to 入栈，from 入栈的原因是
        // 访问到头了的时候，回退，当回退到这个顶点的时候，访问这个顶点的其余路径
        // 判断是否访问过to，如果访问过，那么这条路径就访问过，如果没有访问过就访问to
        // 从当前节点依次找每一条路径，找到一条路径就break，沿着to继续向下找
        for (SCXGraphEdge *edge in cur.outEdges) {
            if ([visited containsObject:edge.to]) {
                continue;
            }
            // from 入栈
            [stack push:edge.from];
            // to 入栈
            [stack push:edge.to];
            // 将to添加到访问过得节点中
            [visited addObject:edge.to];
            // 打印to
            NSLog(@"%@",edge.to.vertex);
            // 退出这条路径，继续沿着to访问
            break;
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

/// 拓扑排序
/*
 1. 每个顶点只出现依次
 2. 没有一个节点指向他节点的前面
 
 
 1. 先遍历所有的节点，将入度为0的节点，放在q1队列里面，度不为0的节点，我们放到一个map里面，key为这个节点，value为这个节点的入度
 2. 从队列q1中取出一个节点，如果队列不为空，一直循环取
 3. 从上面队列中取出一个度为0的节点后，放到我们最终要的结果数组里面arr1
 4. 拿到所有跟这个顶点有关的边，将这些变得终点的入度，减去1，这些顶点其实是都放在上面的map中
 5. 重复2，3，4
 */
- (NSArray *)topologicalSort{
    // 存放所有度为0的节点
    SCXCircleArrayQueue *queue = [SCXCircleArrayQueue arrayQueue];
    // 存放除了度为0的节点之外，其余的所有节点，key为这个节点，value为这个节点的入度
    //    NSMapTable *map = [NSMapTable mapTableWithKeyOptions:(NSPointerFunctionsStrongMemory) valueOptions:NSPointerFunctionsStrongMemory];
    NSMutableDictionary *map = [NSMutableDictionary dictionary];
    // 存放最终的结果
    NSMutableArray *result = [NSMutableArray array];
    
    // 先找出所有的入度为0的节点
    NSEnumerator *enumerator = self.vertices.keyEnumerator;
    id key ;
    while ((key = enumerator.nextObject) != nil) {
        SCXGraphVertex *vertex = [self.vertices objectForKey:key];
        NSInteger size = vertex.inEdges.count;
        if (size == 0) {
            [queue enqueue:vertex];
        } else {
            NSNumber *num = [NSNumber numberWithInteger:size];
            [map setValue:num forKey:vertex.vertex];
        }
        
    }
    // 挨个从队列里面取出入度为0的节点，将它放到最终的结果数组里面去
    while (!queue.isEmpty) {
        SCXGraphVertex *zeroVertex = [queue dequeue];
        // 放到结果数组中去
        [result addObject:zeroVertex.vertex];
        
        // 将跟这个顶点有关的顶点的入度都减去1
        for (SCXGraphEdge *outEdge in zeroVertex.outEdges) {
            SCXGraphVertex *outVertext = outEdge.to;
            NSNumber *priSizeNum = [map objectForKey:outVertext.vertex];
            NSInteger outSize = priSizeNum.integerValue - 1;
            if (outSize == 0) {
                [queue enqueue:outVertext];
            } else {
                [map setValue:[NSNumber numberWithInteger:outSize] forKey:outVertext.vertex];
            }
        }
    }
    
    
    return result.copy;
}
@end
