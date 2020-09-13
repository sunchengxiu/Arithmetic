//
//  SCXLCS.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/9/13.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCXLCS : NSObject

/// 最大公共子串
/// @param str1 str1
/// @param str2 str2
- (int)continuousLCS:(NSString *)str1 str2:(NSString *)str2;

/// 最长公共子序列
/// @param str1 str1
/// @param str2 str2
- (int)LCS:(NSString *)str1 str2:(NSString *)str2;
@end

NS_ASSUME_NONNULL_END
