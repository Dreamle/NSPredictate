//
//  Test.m
//  Predictate
//
//  Created by 李梦 on 16/12/11.
//  Copyright © 2016年 RedStar. All rights reserved.
//

#import "Test.h"

@implementation Test


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@", keyPath);
    NSLog(@"%@", object);
    NSLog(@"%@", change);
}


@end
