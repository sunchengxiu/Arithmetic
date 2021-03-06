//
//  TestArithmeticTests.m
//  TestArithmeticTests
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCXLinkList.h"
#import "SCXBinarySearchTree.h"
#import "SCXSingalCircleList.h"
#import "SCXCircleList.h"
#import "SCXBinaryNodeDate.h"
#import "SCXArrayQueue.h"
#import "SCXCircleArrayQueue.h"
#import "SCXCircleDeque.h"
#import "SCXAVLTree.h"
#import "SCXRBTree.h"
#import "SCXPriorityQueue.h"
#import "SCXBinaryHeap.h"
#import "SCXGraph.h"
#import "SCXListGraph.h"
#import "SCXMaxSubSum.h"

#import "SCXLengthOfLIS.h"
#import "SCXPalindrome.h"
#import "SCXShortest.h"
#import "SCXSteps.h"

#import "SCXMinCoins.h"
#import "SCXLCS.h"
@interface TestArithmeticTests : XCTestCase<SCXBinaryHeapDelegate,SCXPriorityQueueDelegate>

@end

@implementation TestArithmeticTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}
- (void)testLCS {
    SCXLCS *lcs = [[SCXLCS alloc] init];
    int cout = [lcs LCS:@"abcde" str2:@"ace"];
    XCTAssertEqual(cout, 3);
    cout = [lcs continuousLCS:@"abcdefg" str2:@"bacdefj"];
    XCTAssertEqual(cout, 4);
}
- (void)testMinCoins {
    NSArray *arr = @[@1,@2,@5];
    SCXMinCoins *minCoins = [[SCXMinCoins alloc] init];
    int count = [minCoins coins:arr amount:11];
    XCTAssertEqual(count, 3);
}
- (void)testSteps {
    SCXSteps *steps = [[SCXSteps alloc] init];
    int all = [steps steps:3];
    XCTAssertEqual(all, 3);
}
- (void)testShortest {
    SCXShortest *shortest = [[SCXShortest alloc] init];
    NSArray *arr = @[@1,@3,@1];
    NSArray *arr1 = @[@1,@5,@1];
    NSArray *arr2 = @[@4,@2,@1];
    NSMutableArray *arr4 = [NSMutableArray array];
    [arr4 addObject:arr];
    [arr4 addObject:arr1];
    [arr4 addObject:arr2];
    int max = [shortest shortest:arr4];
    XCTAssertEqual(max, 7);
}
- (void)testPalindsome {
    SCXPalindrome *palindrome = [[SCXPalindrome alloc] init];
    BOOL is = [palindrome palindrome:@"abcdcba"];
    XCTAssertEqual(is, YES);
}
- (void)testLengthOfLIs {
    NSArray *arr = @[@10,@2,@2,@5,@1,@7,@101,@18];
    SCXLengthOfLIS *LIS = [[SCXLengthOfLIS alloc] init];
    int count = [LIS lengthOfLIS:arr];;
    NSLog(@"-----%d",count);
}
- (void)testMaxSub {
    NSArray *arr = @[@-2,@1,@-3,@4,@-1,@2,@1,@-5,@4];
    SCXMaxSubSum *maxSub = [[SCXMaxSubSum alloc] init];
    int sum = [maxSub maxSubSum:arr];
    NSLog(@"--------%d",sum);
}
- (void)testGraphTopolo1{
    SCXListGraph *graph = [[SCXListGraph alloc] init];
    [graph addEdge:@"0" to:@"2" weigth:[NSNumber numberWithInteger:9]];
    [graph addEdge:@"1" to:@"0" weigth:[NSNumber numberWithInteger:9]];

    [graph addEdge:@"2" to:@"5" weigth:[NSNumber numberWithInteger:3]];
    [graph addEdge:@"2" to:@"6" weigth:[NSNumber numberWithInteger:2]];
    [graph addEdge:@"3" to:@"1" weigth:[NSNumber numberWithInteger:5]];
    [graph addEdge:@"3" to:@"5" weigth:[NSNumber numberWithInteger:1]];
    [graph addEdge:@"3" to:@"7" weigth:[NSNumber numberWithInteger:6]];
    [graph addEdge:@"5" to:@"7" weigth:[NSNumber numberWithInteger:6]];
    [graph addEdge:@"6" to:@"4" weigth:[NSNumber numberWithInteger:6]];
    [graph addEdge:@"7" to:@"6" weigth:[NSNumber numberWithInteger:6]];

    
    NSLog(@"%@",[graph topologicalSort]);

}
- (void)testGraphTopolo{
    // 有环
    SCXListGraph *graph = [[SCXListGraph alloc] init];
    [graph addEdge:@"0" to:@"1"];
    [graph addEdge:@"1" to:@"0"];
    
    [graph addEdge:@"1" to:@"3"];
    [graph addEdge:@"3" to:@"1"];
    
    [graph addEdge:@"1" to:@"5"];
    [graph addEdge:@"5" to:@"1"];
    
    [graph addEdge:@"1" to:@"6"];
    [graph addEdge:@"6" to:@"1"];
    
    [graph addEdge:@"1" to:@"2"];
    [graph addEdge:@"2" to:@"1"];
    
    [graph addEdge:@"2" to:@"4"];
    [graph addEdge:@"4" to:@"2"];
    
    [graph addEdge:@"3" to:@"7"];
    [graph addEdge:@"7" to:@"3"];
    
//    [graph DFS:@"1"];
    NSArray *arr = [graph topologicalSort];
    NSLog(@"%@",arr);
}
- (void)testGraphDFS{
    SCXListGraph *graph = [[SCXListGraph alloc] init];
    [graph addEdge:@"0" to:@"1"];
    [graph addEdge:@"1" to:@"0"];
    
    [graph addEdge:@"1" to:@"3"];
    [graph addEdge:@"3" to:@"1"];
    
    [graph addEdge:@"1" to:@"5"];
    [graph addEdge:@"5" to:@"1"];
    
    [graph addEdge:@"1" to:@"6"];
    [graph addEdge:@"6" to:@"1"];
    
    [graph addEdge:@"1" to:@"2"];
    [graph addEdge:@"2" to:@"1"];
    
    [graph addEdge:@"2" to:@"4"];
    [graph addEdge:@"4" to:@"2"];
    
    [graph addEdge:@"3" to:@"7"];
    [graph addEdge:@"7" to:@"3"];
    
    [graph DFS:@"1"];
}

- (void)testGraphBFS{
    SCXListGraph *graph = [[SCXListGraph alloc] init];
    [graph addEdge:@"v1" to:@"v0" weigth:[NSNumber numberWithInteger:9]];
    [graph addEdge:@"v1" to:@"v2" weigth:[NSNumber numberWithInteger:3]];
    [graph addEdge:@"v2" to:@"v0" weigth:[NSNumber numberWithInteger:2]];
    [graph addEdge:@"v2" to:@"v3" weigth:[NSNumber numberWithInteger:5]];
    [graph addEdge:@"v3" to:@"v4" weigth:[NSNumber numberWithInteger:1]];
    [graph addEdge:@"v0" to:@"v4" weigth:[NSNumber numberWithInteger:6]];
    [graph BFS:@"v1"];
    
}
- (void)testGraph{
    SCXListGraph *graph = [[SCXListGraph alloc] init];
    [graph addEdge:@"v1" to:@"v0" weigth:[NSNumber numberWithInteger:9]];
    [graph addEdge:@"v1" to:@"v0" weigth:[NSNumber numberWithInteger:9]];

    [graph addEdge:@"v1" to:@"v2" weigth:[NSNumber numberWithInteger:3]];
    [graph addEdge:@"v2" to:@"v0" weigth:[NSNumber numberWithInteger:2]];
    [graph addEdge:@"v2" to:@"v3" weigth:[NSNumber numberWithInteger:5]];
    [graph addEdge:@"v3" to:@"v4" weigth:[NSNumber numberWithInteger:1]];
    [graph addEdge:@"v0" to:@"v4" weigth:[NSNumber numberWithInteger:6]];
    
    [graph removeVertex:@"v0"];
    [graph printGraph];
    NSLog(@"顶点个数：%@",@([graph verticesSize]));
    NSLog(@"边个数：%@",@([graph edgesSize]));

}
// 优先级队列
- (void)testPriorityQueue{
    SCXPriorityQueue *queue = [[SCXPriorityQueue alloc] initWithDelegate:self];
    [queue enQueue:@1];
    [queue enQueue:@3];
    [queue enQueue:@2];
    [queue enQueue:@0];
    [queue enQueue:@4];
    NSLog(@"%@",[queue front]);
    NSLog(@"%@",[queue deQueue]);
    NSLog(@"%@",[queue deQueue]);
    NSLog(@"%@",[queue deQueue]);
    NSLog(@"%@",[queue deQueue]);
    NSLog(@"%@",[queue deQueue]);
}
//top k 问题
// 找到一组数中，最大的前几个
- (void)testFindMax{
    NSArray *arr = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    int k =5;
    SCXBinaryHeap *heap = [[SCXBinaryHeap alloc] initWithDelegate:self];;

    // 找到最大的前五个，现将前五个额元素，放入小顶堆中，然后之后的每一个元素，如果比堆顶大，那么就执行replace，这样做的目的其实就是，默认先将前五个作为最大，然后如果发现有大的，就一次替换，因为堆顶是最小的，所以到最后，小顶堆的元素一定是最后要找的,时间复杂度为nlogk，k为要寻找的个数
    // 这里是找到最小的前五个数
    for (int i = 0; i < arr.count; i ++) {
        if (heap.size < k) {
            [heap add:arr[i]];
        } else if ([self compareA:heap.getTopObject valueB:arr[i]]){
            [heap replaceTopObject:arr[i]];
        }
    }
    NSLog(@"%@",heap);
}
// 二叉堆测试
- (void)testBinaryHeapWithArray{
    NSArray *arr = @[@88,@44,@53,@41,@16,@6,@70,@18,@85,@98,@81,@23,@36,@43,@37];
    SCXBinaryHeap *heap = [[SCXBinaryHeap alloc] initWithArray:arr delegate:self];
    NSLog(@"%@",heap);

}
- (void)testBinaryHeapAdd{
    SCXBinaryHeap *heap = [[SCXBinaryHeap alloc] initWithDelegate:self];
    [heap add:@68];
    [heap add:@72];
    [heap add:@43];
    [heap add:@50];
    [heap add:@38];
    [heap add:@10];
    [heap add:@90];
    [heap add:@65];
    NSNumber *obj = [heap removeTopObject];
    NSInteger size = [heap size];
    XCTAssertEqual(obj, @90);
    NSLog(@"%@",heap);
}
- (void)testBinaryHeapReplace{
    SCXBinaryHeap *heap = [[SCXBinaryHeap alloc] initWithDelegate:self];
    [heap add:@68];
    [heap add:@72];
    [heap add:@43];
    [heap add:@50];
    [heap add:@38];
    [heap add:@10];
    [heap add:@90];
    [heap add:@65];
    [heap replaceTopObject:@70];
    NSLog(@"%@",heap);
}
-(BOOL)compareA:(id)valueA valueB:(id)valueB{
    if ([valueA intValue] < [valueB intValue]) {
        return NO;
    }
    return YES;
}
// 红黑树测试
- (void)testRBTreeAdd{
    SCXRBTree *tree = [[SCXRBTree alloc] init];
    NSArray *arr = @[@"55", @"87", @"56", @"74", @"96", @"22", @"62", @"20", @"70", @"68", @"90", @"50"];
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    [tree levelorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}
- (void)testRBTreeRemove{
    SCXRBTree *tree = [[SCXRBTree alloc] init];
    NSArray *arr = @[@"55", @"87", @"56", @"74", @"96", @"22", @"62", @"20", @"70", @"68", @"90", @"50"];
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    
    SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
    data.value = @"55";
    [tree removeObject:data];
    data.value = @"87";
    [tree removeObject:data];
    data.value = @"56";
    [tree removeObject:data];
    [tree levelorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}
- (void)testAVLTreeRemoveNode{
    SCXAVLTree *tree = [[SCXAVLTree alloc] init];
    NSArray *arr = @[@"8",@"7",@"9",@"3",@"2",@"6",@"10"];
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
    data.value = @"8";
    [tree removeObject:data];
    data.value = @"9";
    [tree removeObject:data];
    data.value = @"10";
    [tree removeObject:data];
    [tree levelorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}

- (void)testAVLTree{
    SCXAVLTree *tree = [[SCXAVLTree alloc] init];
    NSArray *arr = @[@"8",@"7",@"9",@"3",@"2",@"6",@"10",@"11",@"100",@"150",@"99",@"200",@"300",@"140"];
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    [tree levelorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}
- (void)testRemoveObj{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    SCXBinaryData *data = [[SCXBinaryData alloc] init];
    data.value = @"5";
    [tree inorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    NSLog(@"----------");
    [tree removeObject:data];
    //    [tree inorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
    //        NSLog(@"%@",obj);
    //    }];
    data.value = @"2";
    [tree removeObject:data];
    //       [tree inorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
    //           NSLog(@"%@",obj);
    //       }];
    data.value = @"1";
    [tree removeObject:data];
    // 3，4，7，8，9，10，11，12
    [tree inorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    data.value = @"7";
    [tree removeObject:data];
    // 3，4，8，9，10，11，12
    [tree inorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    data.value = @"4";
    [tree removeObject:data];
    // 3，8，9，10，11，12
    [tree inorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    data.value = @"3";
    [tree removeObject:data];
    // 8，9，10，11，12
    [tree inorderTraversal:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}
- (void)testPreNode{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
        if ([value isEqualToString:@"3"]) {
            NSLog(@"%@",[tree preNode:data]);
        }
        
    }
    
}
// 层序遍历递归
- (void)testLevel{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    // 层序遍历 7,4,9,2,5,8,11,1,3,10,12
    [tree levelorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj.value);
        if ([obj.value isEqual:@"8"]) {
            *stop = YES;
        }
    }];
}

/// 后序遍历递归
- (void)testPoster{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    // 后续遍历1,3,2,5,4,8,10,12,11,9,7
    [tree postorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj.value);
        if ([obj.value isEqualToString:@"11"]) {
            *stop = YES;
        }
    }];
}
/// 后序遍历递归
- (void)testPosterRecursion{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    // 后续遍历1,3,2,5,4,8,10,12,11,9,7
    [tree postorderTraversalWithRecursion:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj.value);
        if ([obj.value isEqualToString:@"11"]) {
            *stop = YES;
        }
    }];
}
// 中序遍历迭代
- (void)testInorder{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    // 中序遍历1,2,3,4,5,7,8,9,10,11,12
    [tree inorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj.value);
        if ([obj.value isEqualToString:@"10"]) {
            *stop = YES;
        }
    }];
}
// 中序遍历递归
- (void)testInorderRecursion{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    // 中序遍历1,2,3,4,5,7,8,9,10,11,12
    [tree inorderTraversalWithRecursion:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj.value);
        if ([obj.value isEqualToString:@"10"]) {
            *stop = YES;
        }
    }];
}
// 前序遍历递归
- (void)testPreRecursion{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    // 前序遍历7,4,2,1,3,5,9,8,11,10,12
    [tree preorderTraversalWithRecursion:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj.value);
        if ([obj.value isEqualToString:@"5"]) {
            *stop = YES;
        }
    }];
}
// 前序遍历迭代
- (void)testPre{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    // 前序遍历7,4,2,1,3,5,9,8,11,10,12
    [tree preorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj.value);
        if ([obj.value isEqualToString:@"5"]) {
            *stop = YES;
        }
    }];
}
/// 测试双端队列
- (void)testCircleDeque{
    SCXCircleDeque *queue = [SCXCircleDeque arrayQueue];
    for (int i = 0; i < 9; i ++) {
        NSNumber *num = [NSNumber numberWithInt:i];
        [queue enqueue:num];
    }
    int size = queue.size / 2;
    for (int i = 0; i < size; i ++) {
        NSNumber *num = [queue dequeue];
        //        NSLog(@"%@",num);
    }
    for (int i = 100; i < 103; i ++) {
        NSNumber *num = [NSNumber numberWithInt:i];
        [queue enqueue:num];
    }
    
    NSLog(@"%@",queue);
    for (int i = 210; i < 213; i ++) {
        [queue enqueueFromFront:[NSNumber numberWithInt:i]];
    }
    NSLog(@"%@",queue);
    size = queue.size;
    for (int i = 0; i < size; i ++) {
        NSLog(@"%@",[queue dequeueFromTail]);
    }
    NSLog(@"%@",queue);
}
/// 测试环形数组队列
- (void)testCircleArrayQueue{
    SCXCircleArrayQueue *queue = [SCXCircleArrayQueue arrayQueue];
    for (int i = 0; i < 9; i ++) {
        NSNumber *num = [NSNumber numberWithInt:i];
        [queue enqueue:num];
    }
    int size = queue.size / 2;
    for (int i = 0; i < size; i ++) {
        NSNumber *num = [queue dequeue];
        //        NSLog(@"%@",num);
    }
    for (int i = 100; i < 103; i ++) {
        NSNumber *num = [NSNumber numberWithInt:i];
        [queue enqueue:num];
    }
    NSLog(@"%@",queue);
}

/// 测试数组队列
- (void)testArrayQueue{
    
    SCXArrayQueue <NSNumber *> *arrayQueue = [[SCXArrayQueue alloc] initWithArrayCapacity:2];
    for (int i = 0; i<10; i++) {
        NSNumber *num = [NSNumber numberWithInt:i];
        [arrayQueue enqueue:num];
    }
    int size = arrayQueue.size;
    for (int i = 0 ; i < size; i ++) {
        NSNumber *num = [arrayQueue dequeue];
        NSLog(@"%@,",num);
    }
}
/// 数组队列时间测试
- (void)testArrayQueueTime{
    int number = 100000;
    NSMutableArray *timeArray = [NSMutableArray array];
    SCXBinaryNodeDate *node = [SCXBinaryNodeDate new];
    for (int i = 0; i<10; i++) {
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        SCXArrayQueue <SCXBinaryNodeDate *> *arrayQueue = [SCXArrayQueue arrayQueue];
        for (int i = 0; i<number; i++) {
            [arrayQueue enqueue:node];
        }
        for (int i = 0; i<number; i++) {
            [arrayQueue dequeue];
        }
        
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        CFTimeInterval duration = linkTime * 1000.0f;
        [timeArray addObject:@(duration)];
        [NSThread sleepForTimeInterval:0.1f];
    }
    
    /*
     NSArray(array: numberArray).value(forKeyPath: "@min.self") // 最小值
     NSArray(array: numberArray).value(forKeyPath: "@max.self") // 最大值
     NSArray(array: numberArray).value(forKeyPath: "@avg.self") // 平均值
     NSArray(array: numberArray).value(forKeyPath: "@sum.self") // 累加的总量
     NSArray(array: numberArray).value(forKeyPath: "@count.self") // 等同于Array.count
     */
    NSLog(@"avg time is %@",[timeArray valueForKeyPath:@"@avg.self"]);
    
    NSLog(@"----------------");
    
    
    [timeArray removeAllObjects];
    for (int i = 0; i<10; i++) {
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        SCXCircleArrayQueue <SCXBinaryNodeDate *> *arrayQueue = [SCXCircleArrayQueue arrayQueue];
        for (int i = 0; i<number; i++) {
            [arrayQueue enqueue:node];
        }
        for (int i = 0; i<number; i++) {
            [arrayQueue dequeue];
        }
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        CFTimeInterval duration = linkTime * 1000.0f;
        [timeArray addObject:@(duration)];
        [NSThread sleepForTimeInterval:0.1f];
    }
    
    /*
     NSArray(array: numberArray).value(forKeyPath: "@min.self") // 最小值
     NSArray(array: numberArray).value(forKeyPath: "@max.self") // 最大值
     NSArray(array: numberArray).value(forKeyPath: "@avg.self") // 平均值
     NSArray(array: numberArray).value(forKeyPath: "@sum.self") // 累加的总量
     NSArray(array: numberArray).value(forKeyPath: "@count.self") // 等同于Array.count
     */
    NSLog(@"avg time is %@",[timeArray valueForKeyPath:@"@avg.self"]);
    
}
// 二叉搜索树
- (void)testBinarySearchTree{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    //    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];
    
    /*
     
     7
     4                9
     2       5       8       11
     1      3               10      12
     
     
     5
     2       6
     1
     0
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    // 前序遍历7,4,2,1,3,5,9,8,11,10,12
    //    [tree preorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
    //                NSLog(@"%@",obj.value);
    //                if ([obj.value isEqualToString:@"5"]) {
    //                    *stop = YES;
    //                }
    //    }];
    // 中序遍历1,2,3,4,5,7,8,9,10,11,12
    //    [tree inorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
    //        NSLog(@"%@",obj.value);
    //        if ([obj.value isEqualToString:@"2"]) {
    //            *stop = YES;
    //        }
    //    }];
    // 后续遍历1,3,2,5,4,8,10,12,11,9,7
    //        [tree postorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
    //            NSLog(@"%@",obj.value);
    //            if ([obj.value isEqualToString:@"4"]) {
    //                *stop = YES;
    //            }
    //        }];
    // 层序遍历 7,4,9,2,5,8,11,1,3,10,12
    //    [tree levelorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
    //        NSLog(@"%@",obj.value);
    //        if ([obj.value isEqual:@"8"]) {
    //            *stop = YES;
    //        }
    //    }];
    //    NSLog(@"----%d",[tree binaryHeight]);
    //    NSLog(@"~~~~%d",[tree isCompleteBinaryTree]);
    //    [tree invertTree];
    //    [tree levelorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
    //        NSLog(@"%@",obj.value);
    //
    //    }];
}
// 环形链表
- (void)testCircleList{
    SCXCircleList *list = [[SCXCircleList alloc] init];
    NSLog(@"%@",[list objectAtIndex:0]);
    NSLog(@"%@",[list addToHead:@"1"]);
    NSLog(@"%@",[list addToTail:@"3"]);
    NSLog(@"%@",[list addToHead:@"5"]);
    NSLog(@"%@",[list addToTail:@"7"]);
    NSLog(@"~~~~~");
    NSLog(@"%@",list);
    NSLog(@"%@",[list removeObjectAtIndex:0]);
    
    NSLog(@"%@",[list removeObjectAtIndex:10]);
    [list deleteObject:@"5"];
    [list deleteObject:@"30"];
    NSLog(@"%@",list);
}
//单链表
- (void)testSignalList{
    SCXLinkList *list = [[SCXLinkList alloc] init];
    [list removeLastObject];
    [list addToHead:@"2"];
    [list addObject:@"4" atIndex:0];
    [list addObject:@"5" atIndex:3];
    [list addObject:@"6" atIndex:5];
    [list removeFirstObject];
    NSLog(@"----%@",list);
    [list removeLastObject];
    NSLog(@"----%@",list);
    [list deleteObject:@"5"];
    NSLog(@"%@",[list removeObjectAtIndex:0]);
    NSLog(@"%d",[list containObject:@"2"]);
    NSLog(@"%d",[list containObject:@"6"]);
    NSLog(@"%ld",[list indexOfObject:@"6"]);
    NSLog(@"----%@",list);
    //    [list clear];
    [list reverseList];
    NSLog(@"%@",list);
    NSLog(@"has circle : %d",[list hasCircle]);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
