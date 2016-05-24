//
//  Sort.m
//  LeetCodeInObjective-C
//
//  Created by Chengzhi Jia on 5/14/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "Sort.h"

@implementation Sort

#pragma mark - exchange sort

/*
 Bubble sort
 Time complexity: O(n) - O(n2)
 Space complexity: O(1)
 stable
 */

- (NSArray *)bubbleSort: (NSArray *)ary {
    NSMutableArray *mutableArray = [ary mutableCopy];
    for (int i = 0; i < mutableArray.count; i++) {
        for (int j = 0; j < mutableArray.count - i - 1; j++) {
            if ([mutableArray[j] integerValue] > [mutableArray[j + 1] integerValue]) {
                [mutableArray exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    return [mutableArray copy];
}

/*
 quick sort
 Time complexity: O(nlogn) - O(n2)
 Space complexity: O(logn) - O(n)
 unstable
 */

/**********Solution 1**********/

- (NSArray *)quickSortOne: (NSArray *)ary {
    if (ary.count <= 1) return ary;
    NSMutableArray *smallArray = [[NSMutableArray alloc]init];
    NSMutableArray *bigArray = [[NSMutableArray alloc]init];
    int pivot = arc4random()%ary.count;
    NSNumber *pivotNum = ary[pivot];
    for (NSNumber *num in ary) {
        if ([pivotNum integerValue] > [num integerValue]) {
            [smallArray addObject:num];
        } else {
            [bigArray addObject:num];
        }
    }
    NSMutableArray *result = [[NSMutableArray alloc]init];
    [result addObjectsFromArray:[self quickSortOne:smallArray]];
    [result addObjectsFromArray:[self quickSortOne:bigArray]];
    return result;
}

/**********Solution 2**********/

- (NSArray *)quickSortTwo:(NSArray *)ary {
    NSMutableArray *mutableArray = [ary mutableCopy];
    [self quickSortProcess:mutableArray startIndex:0 endIndex:mutableArray.count - 1];
    return [mutableArray copy];
}

- (void)quickSortProcess: (NSMutableArray *)input startIndex: (NSInteger)start endIndex: (NSInteger)end {
    if (start < end) {
        NSInteger pivot = [self partition:input startIndex:start endIndex:end];
        [self quickSortProcess:input startIndex:start endIndex:pivot - 1];
        [self quickSortProcess:input startIndex:pivot + 1 endIndex:end];
    }
}

- (NSInteger)partition: (NSMutableArray *)inputArray startIndex: (NSInteger)start endIndex: (NSInteger)end {
    NSNumber *pivot = inputArray[end];
    NSInteger startIndex = start;
    for (NSInteger index = start; index < end; index++) {
        if ([inputArray[index] integerValue] < [pivot integerValue]) {
            [inputArray exchangeObjectAtIndex:index withObjectAtIndex:startIndex];
            startIndex++;
        }
    }
    [inputArray exchangeObjectAtIndex:end withObjectAtIndex:startIndex];
    return startIndex;
}

#pragma mark - selection sort

/*
 Selection sort
 Time complexity: O(n2)
 Space complexity: O(1)
 unstable
 */
- (NSArray *)selectionSort: (NSArray *)ary {
    NSMutableArray *mutableArray = [ary mutableCopy];
    for (int i = 0; i < mutableArray.count - 1; i++) {
        NSInteger minIndex = i;
        for (int j = i + 1; j < mutableArray.count; j++) {
            if ([mutableArray[j] integerValue] < [mutableArray[minIndex]integerValue]) {
                minIndex = j;
            }
        }
        [mutableArray exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    return [mutableArray copy];
}

#pragma mark - insertion sort

/*
 insertion sort
 Time complexity: O(n) - O(n2)
 Space comlexity: O(1)
 stable
 */
- (NSArray *)insertionSort: (NSArray *)ary {
    NSMutableArray *mutableArray = [ary mutableCopy];
    for (int i = 1; i < ary.count; i++) {
        NSNumber *temp = mutableArray[i];
        NSInteger index = i;
        for (int j = i - 1; j >= 0; j--) {
            if (mutableArray[j] > temp) {
                mutableArray[j + 1] = mutableArray[j];
                index = j;
            }
        }
        mutableArray[index] = temp;
    }
    return [mutableArray copy];
}

/*
Shell sort
Time complexity: O(nlogn) - O(ns) (1<s<2)
Space complexity: O(1)
Unstable
*/
- (NSArray *)shellSort: (NSArray *)input {
    NSInteger len = input.count;
    NSMutableArray *mutableArray = [input mutableCopy];
    for (NSInteger gap = len/2; gap > 0; gap /= 2) {
        for (NSInteger i = 0; i < gap; i++) {
            for (NSInteger j = i + gap; j < len; j++) {
                NSNumber *tempNum = mutableArray[j];
                NSInteger k = j - gap;
                while (k >= 0 && [tempNum integerValue] < [mutableArray[k] integerValue]) {
                    mutableArray[k + gap] = mutableArray[k];
                    k -= gap;
                }
                mutableArray[k + gap] = tempNum;
            }
        }
    }
    return [mutableArray copy];
}

#pragma mark - merge sort

/*
 merge sort
 Time complexity: O(nlogn)
 Space complexity: O(n)
 Stable
 */
- (NSArray *)mergeSort:(NSArray *)input {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:input.count];
    NSMutableArray *tempInput = [input mutableCopy];
    [self mergeProcess:tempInput sortedArray:result startIndex:0 endIndex:tempInput.count - 1];
    return [result copy];
}

- (void)mergeProcess: (NSMutableArray *)unsortedArray sortedArray: (NSMutableArray *)sortedArray startIndex: (NSInteger)start endIndex: (NSInteger)end {
    if (start >= end) return;
    NSInteger middle = (start + end)/2;
    NSInteger i = start, j = middle;
    NSInteger m = middle + 1, n = end;
    [self mergeProcess:unsortedArray sortedArray:sortedArray startIndex:i endIndex:j];
    [self mergeProcess:unsortedArray sortedArray:sortedArray startIndex:m endIndex:n];
    NSInteger k = start;
    while (i <= j && m <= n) {
        sortedArray[k++] = [unsortedArray[i] integerValue] < [unsortedArray[m] integerValue] ? unsortedArray[i++] : unsortedArray[m++];
    }
    while (i <= j) {
        sortedArray[k++] = unsortedArray[i++];
    }
    while (m <= n) {
        sortedArray[k++] = unsortedArray[m++];
    }
    //Copy current sorted array to unsorted array to prepare for the next recursive use
    for (NSInteger tempNum = start; tempNum <= end; tempNum++) {
        unsortedArray[tempNum] = sortedArray[tempNum];
    }
}

@end
