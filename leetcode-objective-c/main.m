//
//  main.m
//  leetcode-objective-c
//
//  Created by Chengzhi Jia on 2/18/19.
//  Copyright © 2019 com.cj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Q139WordBreak.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Q139WordBreak *obj = [[Q139WordBreak alloc]init];
        printf("%hhi", [obj wordBreak:@"leetcode" wordDict:@[@"leet", @"code"]]);
    }
    return 0;
}
