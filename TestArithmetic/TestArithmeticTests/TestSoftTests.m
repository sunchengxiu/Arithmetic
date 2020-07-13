//
//  TestSoftTests.m
//  TestArithmeticTests
//
//  Created by 孙承秀 on 2020/7/11.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SCXBubbleSoft.h"
#import "SCXSelectionSoft.h"
#import "SCXHeapSoft.h"
#import "SCXInsertionSoft.h"
#import "SCXMergeSoft.h"
@interface TestSoftTests : XCTestCase

@end

@implementation TestSoftTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
// 归并排序测试
- (void)testMergeSoft{
    NSArray *arr = @[@5,@4,@7,@7,@1,@9,@8,@10];
    SCXMergeSoft *soft = [[SCXMergeSoft alloc] init];
    NSArray *res = [soft soft:arr];
//    NSLog(@"%@",res);

}
// 基于二分查找的插入排序
- (void)testBinarySearchInsertionSoft{
    NSArray *arr = @[@5,@4,@7,@7,@1,@9,@8,@10];
    SCXInsertionSoft *soft = [[SCXInsertionSoft alloc] init];
    NSArray *res = [soft soft:arr];
    NSLog(@"%@",res);
}
// 优化后的插入排序测试
- (void)testGoodInsertionSoft{
    NSArray *arr = @[@5,@4,@7,@7,@1,@9,@8,@10];
    SCXInsertionSoft *soft = [[SCXInsertionSoft alloc] init];
    NSArray *res = [soft soft:arr];
    NSLog(@"%@",res);
}
// 插入排序测试
- (void)testInsertionSoft{
    NSArray *arr = @[@5,@4,@7,@7,@1,@9,@8,@10];
    SCXInsertionSoft *soft = [[SCXInsertionSoft alloc] init];
    NSArray *res = [soft soft:arr];
    NSLog(@"%@",res);
}
// 堆排序测试
-(void)testHeapSoft{
    NSArray *arr = @[@5,@4,@7,@7,@1,@9,@8,@10];
    SCXHeapSoft *soft = [[SCXHeapSoft alloc] init];
    NSArray *res = [soft soft:arr];
    NSLog(@"%@",res);
}
// 选择排序测试
- (void)testSelectionSoft{
    NSArray *arr = @[@5,@4,@7,@7,@1,@9,@8,@10];
    SCXSelectionSoft *soft = [[SCXSelectionSoft alloc] init];
    NSArray *res = [soft soft:arr];
    NSLog(@"%@",res);
}
// 冒泡排序测试
- (void)testBubbleSoft{
    NSArray *arr = @[@5,@4,@7,@7,@1,@9,@8,@10];
    SCXBubbleSoft *soft = [[SCXBubbleSoft alloc] init];
    NSArray *res = [soft soft:arr];
    NSLog(@"%@",res);
}
- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
