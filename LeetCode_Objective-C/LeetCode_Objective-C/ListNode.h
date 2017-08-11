//
//  ListNode.h
//  LeetCode_Objective-C
//
//  Created by Chengzhi Jia on 8/10/17.
//  Copyright © 2017 Chengzhi Jia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

@property (nonatomic, assign) NSInteger val;
@property (nonatomic) ListNode *next;

- (instancetype)init: (NSInteger)x;

@end
