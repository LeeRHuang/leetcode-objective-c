//
//  Tree.h
//  LeetCodeInObjective-C
//
//  Created by Chengzhi Jia on 5/26/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TreeNode;
@interface Tree : NSObject

- (TreeNode *)searchBinarySearchTree: (TreeNode *)node target: (NSInteger)target;
- (TreeNode *)minimumNode: (TreeNode *)node;
- (TreeNode *)maximumNode: (TreeNode *)node;

@end
