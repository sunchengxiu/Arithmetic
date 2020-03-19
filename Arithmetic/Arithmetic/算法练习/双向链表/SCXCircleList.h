//
//  SCXCircleList.h
//  Arithmetic
//
//  Created by 孙承秀 on 2020/3/19.
//  Copyright © 2020 RongCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "publicProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface SCXCircleList : NSObject<publicProtocol>

/**
 size
 */
@property(nonatomic , assign , readonly)int count;

/**
 first
 */
@property(nonatomic , strong , readonly)id firstObject;

/**
 lastNode
 */
@property(nonatomic , strong , readonly)id lastObject;

@end

NS_ASSUME_NONNULL_END
