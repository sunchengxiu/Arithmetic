//
//  SCXShellSoft.m
//  TestArithmetic
//
//  Created by 孙承秀 on 2020/7/16.
//  Copyright © 2020 孙承秀. All rights reserved.
//

#import "SCXShellSoft.h"
@interface SCXShellSoft()
@property (nonatomic , strong) NSMutableArray *softArr;
@end
@implementation SCXShellSoft
-(NSArray *)soft:(NSArray<NSNumber *> *)arr{
    self.softArr = arr.mutableCopy;
    // 获取步长序列
    NSArray *stepSequence = [self shellStepSequence:self.softArr];
    // 根据步长序列，依次将序列分为例如，8列，4列，2列，1列，这样，然后依次对每一列进行排序
    for (NSNumber *step in stepSequence) {
        [self shellSoft:step.integerValue];
    }
    return self.softArr.copy;
}
- (void)shellSoft:(NSInteger)step{
    /*
     比如[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16],先分为8列

    [1, 2, 3, 4, 5, 6, 7, 8]
    [9,10,11,12,13,14,15,16],
     
     那么1的索引为0，9的索引为8，2的索引为1，10的索引为9，所以第row行col列的索引为，col + row * step,
     比如3的索引，row为0，col为2，那么索引为col + row * step = 2 + 0*8 = 2，
     再比如11的索引为，2+1*8=10
     */
    /* 然后对每一列进行插入排序，比如这里传来的 step 为 8
        需要对以下数据进行排序
        [1, 2, 3, 4, 5, 6, 7, 8]
        [9,10,11,12,13,14,15,16],
     需要对每一列进行排序，所以进行8次排序，也就是step次数
     每次排序的数为每一列的元素，他们的索引为col + row * step
     
    */
    
    // 这里选择插入排序
    // 需要排序的次数，8列
    for (NSInteger col = 0 ; col < step; col ++) {
        // 利用插入排序，对 每一列，也就是 索引col + row * step排序
        // 插入排序
        // col + row * step
        // row = 0: col
        // row = 1: col + step
        // row = 2: col + 2 * step
        // 所以每次 += step
        // begin = col + step 因为下面的比较要-step,每次比较的上下查值为step,相当于直接拿第二个元素和第一个元素作比较
        for (NSInteger begin = col + step; begin < self.softArr.count; begin += step) {
            NSInteger index = begin;
            // 比较的两个数是列，col + row * step，所以上下差 step
            // 插入排序，一次拿当前的元素和前面的元素进行比较，知道到最前面的那个元素
            /*
             如
             [1, 2, 3, 4, 5, 6, 7, 8]
            [9,10,11,12,13,14,15,16],
             比如比较第三列，索引为2，也就是比较[3,11];
             begin  = col = 2
             begin + step = col + 1 * 8 = 10;
             所以先比较这两个元素的大小，然后 -= step = 2，也就到了3的索引为2，就不能再减了
             */
            while (index > col && ((NSNumber *)self.softArr[index]).integerValue < ((NSNumber *)self.softArr[index - step]).integerValue) {
                // 交换前后两个元素的值
                NSNumber *tmp = self.softArr[index - step];
                self.softArr[index - step] = self.softArr[index];
                self.softArr[index] = tmp;
                index -= step;
            }
        }
    }
    
}
// 希尔提出来的步长
- (NSArray *)shellStepSequence:(NSArray *)arr{
    // 步长公式 n/2^k
    NSMutableArray *stepSequence = [NSMutableArray array];
    NSInteger count = arr.count;
    NSInteger step = count;
    // 依次除以2
    while ((step >>= 1) > 0) {
        [stepSequence addObject:@(step)];
    }
    return stepSequence.copy;
}

@end
