//
//  UIActionSheet+CMDBlocksKitAdditions.h
//  Seesaw
//
//  Created by Caleb Davenport on 3/4/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@interface UIActionSheet (CMDBlocksKit) <UIActionSheetDelegate>

// create an action sheet
- (id)cmd_initWithTitle:(NSString *)title;

// add buttons
- (NSInteger)cmd_addButtonWithTitle:(NSString *)title block:(void (^) (void))block;

// perform common delegate tasks
- (void)cmd_setWillDismissBlock:(void (^) (void))block;
- (void)cmd_setDidDismissBlock:(void (^) (void))block;
- (void)cmd_setWillPresentBlock:(void (^) (void))block;
- (void)cmd_setDidPresentBlock:(void (^) (void))block;

@end

#endif // TARGET_OS_IPHONE
