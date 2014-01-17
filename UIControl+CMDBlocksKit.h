//
//  UIControl+CMDBlocksKit.h
//  Seesaw
//
//  Created by Caleb Davenport on 4/9/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

typedef void (^CMDUIControlEventBlock) (UIControl *control, UIEvent *event);

@interface UIControl (CMDBlocksKit)

- (void)cmd_addBlock:(CMDUIControlEventBlock)block forControlEvents:(UIControlEvents)events;
- (void)cmd_removeBlocksForControlEvents:(UIControlEvents)events;

@end

#endif
