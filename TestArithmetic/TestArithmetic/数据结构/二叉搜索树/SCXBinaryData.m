//
//  SCXBinaryData.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/3/28.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXBinaryData.h"

@implementation SCXBinaryData
-(int)compare:(id<SCXBinaryTreeProtocol>)preNode{
    SCXBinaryData *data = (SCXBinaryData *)preNode;
    return [self.value intValue] - [data.value intValue];
}
@end
