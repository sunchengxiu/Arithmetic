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
#import "SCXQuickSoft.h"
#import "SCXShellSoft.h"
#import "SCXUnionFind.h"
@interface TestSoftTests : XCTestCase

@end

@implementation TestSoftTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}
// 并查集
- (void)testUnioFind{
    SCXUnionFind *UF = [[SCXUnionFind alloc] initWithCapicity:12];
    [UF unionValue:0 value2:1];
    [UF unionValue:0 value2:3];
    [UF unionValue:0 value2:4];
    [UF unionValue:2 value2:3];
    [UF unionValue:2 value2:5];
    
    [UF unionValue:6 value2:7];
    
    [UF unionValue:8 value2:10];
    [UF unionValue:9 value2:10];
    [UF unionValue:9 value2:11];
    
    XCTAssertEqual([UF isSame:0 value2:3], YES);
    
    XCTAssertEqual([UF isSame:0 value2:5], YES);
    
    XCTAssertEqual([UF isSame:2 value2:4], YES);
    
    XCTAssertEqual([UF isSame:6 value2:7], YES);
    
    XCTAssertEqual([UF isSame:8 value2:10], YES);
    
    XCTAssertEqual([UF isSame:9 value2:10], YES);
    
    [UF unionValue:6 value2:8];
    XCTAssertEqual([UF isSame:6 value2:10], YES);








}

// 希尔排序
- (void)testShellSoft{
    NSArray *arr = @[@5,@4,@7,@7,@1,@9,@8,@10];
    SCXShellSoft *soft = [[SCXShellSoft alloc] init];
    NSArray *res = [soft soft:arr];
    NSLog(@"%@",res);
}
// 快排测试
- (void)testQuickSoft{
    NSArray *arr = @[@5,@4,@7,@7,@1,@9,@8,@10];
    SCXQuickSoft *soft = [[SCXQuickSoft alloc] init];
    NSArray *res = [soft soft:arr];
    NSLog(@"%@",res);
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
