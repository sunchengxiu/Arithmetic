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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testBinarySearchTree];
}
// 二叉搜索树
- (void)testBinarySearchTree{
    SCXBinarySearchTree *tree = [[SCXBinarySearchTree alloc] init];
    NSArray *arr = @[@"7",@"4",@"2",@"1",@"3",@"5",@"9",@"8",@"11",@"10",@"12"];
    /*
     
                    7
            4                9
        2       5       8       11
     1      3               10      12
     
     */
    for (NSString *value in arr) {
        SCXBinaryNodeDate *data = [[SCXBinaryNodeDate alloc] init];
        data.value = value;
        [tree addObject:data];
    }
    // 前序遍历7,4,2,1,3,5,9,8,11,10,12
//    [tree preorderTraversal];
    // 中序遍历1,2,3,4,5,7,8,9,10,11,12
//    [tree inorderTraversal];
    // 后续遍历1,3,2,5,4,8,10,12,11,9,7
    [tree postorderTraversal];
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
