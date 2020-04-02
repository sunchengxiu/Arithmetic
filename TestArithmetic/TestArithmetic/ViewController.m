//
//  ViewController.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "ViewController.h"
#import "SCXLinkList.h"
#import "SCXBinarySearchTree.h"
#import "SCXSingalCircleList.h"
#import "SCXCircleList.h"
#import "SCXBinaryNodeDate.h"
#import "SCXArrayQueue.h"
#import "SCXCircleArrayQueue.h"
#import "SCXCircleDeque.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self testBinarySearchTree];
//    [self testArrayQueueTime];
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
//    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    NSArray *arr = @[@"4",@"2",@"7",@"1",@"3",@"6",@"9"];

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
    [tree levelorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj.value);
        if ([obj.value isEqual:@"8"]) {
            *stop = YES;
        }
    }];
    NSLog(@"----%d",[tree binaryHeight]);
    NSLog(@"~~~~%d",[tree isCompleteBinaryTree]);
    [tree invertTree];
    [tree levelorderTraversal:^(SCXBinaryNodeDate *  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj.value);
       
    }];
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

@end
