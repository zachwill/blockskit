//
//  UIControl+CMDBlocksKit.m
//  Seesaw
//
//  Created by Caleb Davenport on 4/9/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import "UIControl+CMDBlocksKit.h"

#if TARGET_OS_IPHONE

#import <objc/runtime.h>

static int CMDBlocksKitAssociatedObjectKey = 0;

@interface CMDUIControlEventWrapper : NSObject
@property (nonatomic, assign) UIControlEvents events;
@property (nonatomic, copy) CMDUIControlEventBlock block;
@end

@implementation CMDUIControlEventWrapper

- (void)controlAction:(UIControl *)control :(UIEvent *)event {
	if (self.block) {
		self.block(control, event);
	}
}

@end

@implementation UIControl (CMDBlocksKit)

#pragma mark - Public

- (void)cmd_addBlock:(CMDUIControlEventBlock)block forControlEvents:(UIControlEvents)events {
	NSParameterAssert(block != nil);
	CMDUIControlEventWrapper *wrapper = [[CMDUIControlEventWrapper alloc] init];
	wrapper.block = block;
	wrapper.events = events;
	[self addTarget:wrapper action:@selector(controlAction::) forControlEvents:events];
	[[self cmd_wrappers] addObject:wrapper];
}


- (void)cmd_removeBlocksForControlEvents:(UIControlEvents)events {
	NSMutableArray *array = [self cmd_wrappers];
	NSIndexSet *set = [array indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
		return (events == [obj events]);
	}];
	[array enumerateObjectsAtIndexes:set options:0 usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		[self removeTarget:obj action:@selector(controlAction::) forControlEvents:events];
	}];
	[array removeObjectsAtIndexes:set];
}


#pragma mark - Private

- (NSMutableArray *)cmd_wrappers {
	NSMutableArray *array = objc_getAssociatedObject(self, &CMDBlocksKitAssociatedObjectKey);
	if (array == nil) {
		array = [NSMutableArray array];
		objc_setAssociatedObject(self, &CMDBlocksKitAssociatedObjectKey, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return array;
}


@end

#endif
