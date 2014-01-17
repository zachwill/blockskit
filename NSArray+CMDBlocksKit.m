//
//  NSArray+CMDBlocksKit.m
//  CMDBlocksKit
//
//  Created by Caleb Davenport on 5/22/12.
//  Copyright (c) 2012 Caleb Davenport.
//

#import "NSArray+CMDBlocksKit.h"

@implementation NSArray (CMDBlocksKit)

- (NSArray *)cmd_collect:(id (^) (id))block {
    NSAssert(block, @"The block used to collect objects must not be nil.");
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = block(obj);
        [array addObject:(value ?: [NSNull null])];
    }];
    return [array copy];
}

@end
