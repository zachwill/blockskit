//
//  NSNumber+CMDBlocksKitAdditions.m
//  Seesaw
//
//  Created by Caleb Davenport on 3/4/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import "NSNumber+CMDBlocksKit.h"

@implementation NSNumber (CMDBlocksKit)

- (void)cmd_times:(void (^) (NSUInteger index))block {
	[self cmd_times:block options:0];
}

- (void)cmd_times:(void (^) (NSUInteger index))block options:(NSEnumerationOptions)options {
	NSParameterAssert(block != nil);
	
	// reverse and not concurrent
	if ((options & NSEnumerationReverse) && !(options & NSEnumerationConcurrent)) {
		for (NSUInteger i = [self unsignedIntegerValue]; ; i--) {
			block(i);
			if (i == 0) { break; }
		}
		return;
	}
	
	// otherwise
	for (NSUInteger i = 0; i < [self unsignedIntegerValue]; i++) {
		if (options & NSEnumerationConcurrent) {
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
				block(i);
			});
		}
		else {
			block(i);
		}
	}
}

@end
