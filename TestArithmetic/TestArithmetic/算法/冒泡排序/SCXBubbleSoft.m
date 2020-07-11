//
//  SCXBubbleSoft.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/11.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXBubbleSoft.h"

@implementation SCXBubbleSoft
-(NSArray *)soft:(NSArray *)arr{
    // 改进，因为冒泡排序每次是找到最大值，比如遍历之后，后面四个已经是有序的，那么每次就不需要遍历后面几个了，记住最开始的那个有序的位置就可以了
    NSMutableArray *soft = arr.mutableCopy;
    for (int i = soft.count - 1 ; i > 0; i --) {
        int end = 1;
        for ( int j = 1; j <= i; j ++) {
            NSNumber *pre = soft[j - 1];
            NSNumber *current = soft[j];
            if (pre.intValue > current.intValue) {
                NSNumber *tmp = pre;
                soft[j - 1] = current;
                soft[j] = tmp;
                // 当前排序的索引
                end = j;
            }
        }
        // 如果上面的for循环里面的 end 没有赋值，说明就没有交换，说明就是有序的，就不需要排序了
        i = end;
    }
    return soft.copy;;
}
-(NSArray *)soft1:(NSArray *)arr{
    NSMutableArray *soft = arr.mutableCopy;
    for (int i = 0 ; i < soft.count - 1; i ++) {
        for ( int j = 1; j < soft.count - 1 - i; j ++) {
            NSNumber *pre = soft[j - 1];
            NSNumber *current = soft[j];
            if (pre.intValue > current.intValue) {
                NSNumber *tmp = pre;
                soft[j - 1] = current;
                soft[j] = tmp;
            }
        }
        
    }
    return soft.copy;;
}
@end
