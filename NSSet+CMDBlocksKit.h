//
//  NSSet+CMDBlocksKit.h
//  CMDBlocksKit
//
//  Created by Caleb Davenport on 3/26/13.
//  Copyright (c) 2012 Caleb Davenport.
//

#import <Foundation/Foundation.h>

@interface NSSet (CMDBlocksKit)

- (NSSet *)cmd_collect:(id (^) (id))block;

@end
