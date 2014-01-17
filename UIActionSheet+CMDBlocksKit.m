//
//  UIActionSheet+CMDBlocksKitAdditions.m
//  Seesaw
//
//  Created by Caleb Davenport on 3/4/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import "UIActionSheet+CMDBlocksKit.h"

#if TARGET_OS_IPHONE

#import <objc/runtime.h>

static int CMDActionSheetActionsKey = 0;
static NSString * const CMDActionSheetWillPresentKey = @"WillPresentAction";
static NSString * const CMDActionSheetDidPresentKey = @"DidPresentAction";
static NSString * const CMDActionSheetWillDismissKey = @"WillDismissAction";
static NSString * const CMDActionSheetDidDismissKey = @"DidDismissAction";

@implementation UIActionSheet (CMDBlocksKit)

#pragma mark - Public

- (id)cmd_initWithTitle:(NSString *)title {
    return [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
}

- (NSInteger)cmd_addButtonWithTitle:(NSString *)title block:(void (^) (void))block {
	if ([self cmd_blockForKey:title]) { return NSNotFound; }
	[self cmd_setBlock:block forKey:title];
    return [self addButtonWithTitle:title];
}

- (void)cmd_setWillPresentBlock:(void (^) (void))block {
	[self cmd_setBlock:block forKey:CMDActionSheetWillPresentKey];
}

- (void)cmd_setDidPresentBlock:(void (^) (void))block {
	[self cmd_setBlock:block forKey:CMDActionSheetDidPresentKey];
}

- (void)cmd_setWillDismissBlock:(void (^) (void))block {
	[self cmd_setBlock:block forKey:CMDActionSheetWillDismissKey];
}

- (void)cmd_setDidDismissBlock:(void (^) (void))block {
	[self cmd_setBlock:block forKey:CMDActionSheetDidDismissKey];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex >= 0 && buttonIndex < actionSheet.numberOfButtons) {
		NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
		[self cmd_performBlockForKey:title];
    }
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet {
	[self cmd_performBlockForKey:CMDActionSheetWillPresentKey];
}

- (void)didPresentActionSheet:(UIActionSheet *)actionSheet {
	[self cmd_performBlockForKey:CMDActionSheetDidPresentKey];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
	[self cmd_performBlockForKey:CMDActionSheetWillDismissKey];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	[self cmd_performBlockForKey:CMDActionSheetDidDismissKey];
}

#pragma mark - Private

- (void)cmd_setBlock:(void (^) (void))block forKey:(NSString *)key {
	NSMutableDictionary *actions = [self cmd_actions];
	if (block) { actions[key] = block; }
	else { [actions removeObjectForKey:key]; }
}

- (void)cmd_performBlockForKey:(NSString *)key {
	NSMutableDictionary *actions = [self cmd_actions];
	void (^block) () = actions[key];
	if (block) { block(); }
}

- (void (^) (void))cmd_blockForKey:(NSString *)key {
	return [self cmd_actions][key];
}

- (NSMutableDictionary *)cmd_actions {
	NSMutableDictionary *actions = objc_getAssociatedObject(self, &CMDActionSheetActionsKey);
	if (actions == nil) {
		actions = [NSMutableDictionary dictionary];
		objc_setAssociatedObject(self, &CMDActionSheetActionsKey, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return actions;
}

@end

#endif // TARGET_OS_IPHONE
