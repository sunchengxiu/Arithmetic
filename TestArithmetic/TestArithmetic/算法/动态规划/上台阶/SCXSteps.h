//
//  SCXSteps.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/9/11.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCXSteps : NSObject

/// 上N级台阶有多少种走法
- (int)steps:(int)n;
@end

NS_ASSUME_NONNULL_END
