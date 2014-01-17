//
//  UIAlertView+CMDBlocksKitAdditions.m
//  Seesaw
//
//  Created by Caleb Davenport on 3/4/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import "UIAlertView+CMDBlocksKit.h"

#if TARGET_OS_IPHONE

#import <objc/runtime.h>

static int CMDAlertViewActionsKey = 0;
static NSString * const CMDAlertViewWillPresentKey = @"WillPresentAction";
static NSString * const CMDAlertViewDidPresentKey = @"DidPresentAction";
static NSString * const CMDAlertViewWillDismissKey = @"WillDismissAction";
static NSString * const CMDAlertViewDidDismissKey = @"DidDismissAction";
static NSString * const CMDAlertViewShouldEnableFirstOtherButtonKey = @"ShouldEnableFirstOtherButton";

@implementation UIAlertView (CMDBlocksKit)

#pragma mark - Public

- (id)cmd_initWithTitle:(NSString *)title message:(NSString *)message {
	return [self initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
}

- (NSInteger)cmd_addButtonWithTitle:(NSString *)title block:(void (^) (void))block {
	if ([self cmd_blockForKey:title]) { return NSNotFound; }
	[self cmd_setBlock:block forKey:title];
    return [self addButtonWithTitle:title];
}

- (void)cmd_setWillPresentBlock:(void (^) (void))block {
	[self cmd_setBlock:block forKey:CMDAlertViewWillPresentKey];
}

- (void)cmd_setDidPresentBlock:(void (^) (void))block {
	[self cmd_setBlock:block forKey:CMDAlertViewDidPresentKey];
}

- (void)cmd_setWillDismissBlock:(void (^) (void))block {
	[self cmd_setBlock:block forKey:CMDAlertViewWillDismissKey];
}

- (void)cmd_setDidDismissBlock:(void (^) (void))block {
	[self cmd_setBlock:block forKey:CMDAlertViewDidDismissKey];
}

- (void)cmd_setShouldEnableFirstOtherButtonBlock:(BOOL (^) (void))block {
	[self cmd_setBlock:block forKey:CMDAlertViewShouldEnableFirstOtherButtonKey];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex >= 0 && buttonIndex < alertView.numberOfButtons) {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
		[self cmd_performBlockForKey:title];
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
	[self cmd_performBlockForKey:CMDAlertViewWillPresentKey];
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
	[self cmd_performBlockForKey:CMDAlertViewDidPresentKey];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	[self cmd_performBlockForKey:CMDAlertViewDidDismissKey];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
	[self cmd_performBlockForKey:CMDAlertViewWillDismissKey];
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
	BOOL (^block) (void) = [self cmd_blockForKey:CMDAlertViewShouldEnableFirstOtherButtonKey];
	if (block) {
		return block();
	}
	return YES;
}

#pragma mark - Private

- (void)cmd_setBlock:(id)block forKey:(NSString *)key {
	NSMutableDictionary *actions = [self cmd_actions];
	if (block) { actions[key] = block; }
	else { [actions removeObjectForKey:key]; }
}

- (void)cmd_performBlockForKey:(NSString *)key {
	void (^block) (void) = [self cmd_blockForKey:key];
	if (block) { block(); }
}

- (id)cmd_blockForKey:(NSString *)key {
	return [self cmd_actions][key];
}

- (NSMutableDictionary *)cmd_actions {
	NSMutableDictionary *actions = objc_getAssociatedObject(self, &CMDAlertViewActionsKey);
	if (actions == nil) {
		actions = [NSMutableDictionary dictionary];
		objc_setAssociatedObject(self, &CMDAlertViewActionsKey, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
	return actions;
}

@end

#endif // TARGET_OS_IPHONE
