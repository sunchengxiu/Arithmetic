//
//  SCXSteps.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/9/11.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXSteps.h"

@implementation SCXSteps
- (int)steps:(int)n {
    // 一级台阶有一种走法
    if (n == 1) {
        return 1;
    }
    if (n == 2) {
        return 2;
    }
    return [self steps:n - 1] + [self steps: n - 2];
}
@end
