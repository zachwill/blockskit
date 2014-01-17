//
//  UIBarButtonItem+CMDBlocksKit.m
//  Seesaw
//
//  Created by Caleb Davenport on 4/9/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import "UIBarButtonItem+CMDBlocksKit.h"

#if TARGET_OS_IPHONE

#import <objc/runtime.h>

static int CMDBlocksKitAssociatedObjectKey = 0;

@implementation UIBarButtonItem (CMDBlocksKit)

- (void)cmd_setBlock:(void (^) (UIBarButtonItem *sender))block {
	self.target = self;
	self.action = @selector(cmd_action:);
	objc_setAssociatedObject(self, &CMDBlocksKitAssociatedObjectKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (id)cmd_block {
	return objc_getAssociatedObject(self, &CMDBlocksKitAssociatedObjectKey);
}


- (void)cmd_action:(UIBarButtonItem *)sender {
	void (^block) (id) = [self cmd_block];
	if (block) {
		block(sender);
	}
}


@end

#endif
