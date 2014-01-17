//
//  NSArray+CMDBlocksKit.h
//  CMDBlocksKit
//
//  Created by Caleb Davenport on 5/22/12.
//  Copyright (c) 2012 Caleb Davenport.
//

#import <Foundation/Foundation.h>

@interface NSArray (CMDBlocksKit)

- (NSArray *)cmd_collect:(id (^) (id))block;

@end
