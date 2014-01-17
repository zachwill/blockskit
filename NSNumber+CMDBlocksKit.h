//
//  NSNumber+CMDBlocksKitAdditions.h
//  Seesaw
//
//  Created by Caleb Davenport on 3/4/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (CMDBlocksKit)

/**
 Perform a task a given number of times. Interprets the value of the receiver
 as an NSUInteger.
 */
- (void)cmd_times:(void (^) (NSUInteger index))block;
- (void)cmd_times:(void (^) (NSUInteger index))block options:(NSEnumerationOptions)options;

@end
