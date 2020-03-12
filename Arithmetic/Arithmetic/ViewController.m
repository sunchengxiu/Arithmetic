//
//  ViewController.m
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/12.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import "ViewController.h"
#import "SCXLinkList.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SCXLinkList *list = [[SCXLinkList alloc] init];
    [list addToHead:@"1"];
    [list addToHead:@"2"];
    [list addToTail:@"3"];
    [list addObject:@"4" atIndex:0];
    [list addObject:@"5" atIndex:3];
    [list addObject:@"6" atIndex:5];
    [list removeFirstObject];
    [list removeLastObject];
    [list deleteObject:@"5"];
    NSLog(@"%d",[list containObject:@"2"]);
    NSLog(@"%d",[list containObject:@"6"]);
    NSLog(@"%ld",[list indexOfObject:@"6"]);
    NSLog(@"%@",list);
}

@end
