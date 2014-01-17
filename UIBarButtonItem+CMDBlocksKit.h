//
//  UIBarButtonItem+CMDBlocksKit.h
//  Seesaw
//
//  Created by Caleb Davenport on 4/9/13.
//  Copyright (c) 2013 Seesaw. All rights reserved.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CMDBlocksKit)

- (void)cmd_setBlock:(void (^) (UIBarButtonItem *sender))block;

@end

#endif
