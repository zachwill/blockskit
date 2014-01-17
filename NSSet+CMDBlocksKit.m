//
//  NSSet+CMDBlocksKit.m
//  CMDBlocksKit
//
//  Created by Caleb Davenport on 3/26/13.
//  Copyright (c) 2012 Caleb Davenport.
//

#import "NSSet+CMDBlocksKit.h"

@implementation NSSet (CMDBlocksKit)

- (NSSet *)cmd_collect:(id (^) (id))block {
    NSAssert(block, @"The block used to collect objects must not be nil.");
    NSMutableSet *set = [NSMutableSet setWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        id value = block(obj);
        [set addObject:(value ?: [NSNull null])];
    }];
    return [set copy];
}

@end
