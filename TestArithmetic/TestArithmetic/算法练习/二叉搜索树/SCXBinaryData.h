//
//  SCXBinaryData.h
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCXBinaryTreeProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface SCXBinaryData : NSObject<SCXBinaryTreeProtocol>
@property(nonatomic,assign)int value;
@end

NS_ASSUME_NONNULL_END
