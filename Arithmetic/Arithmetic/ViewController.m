//
//  ViewController.m
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/12.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import "ViewController.h"
#import "SCXLinkList.h"
#import "SCXCircleList.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testCircleList];
}
- (void)testCircleList{
    SCXCircleList *list = [[SCXCircleList alloc] init];
    NSLog(@"%@",[list objectAtIndex:0]);
    NSLog(@"%@",[list addToHead:@"1"]);
    NSLog(@"%@",[list addToTail:@"3"]);
    NSLog(@"%@",[list addToHead:@"5"]);
    NSLog(@"%@",[list addToTail:@"7"]);
    NSLog(@"~~~~~");
    NSLog(@"%@",list);
}
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
