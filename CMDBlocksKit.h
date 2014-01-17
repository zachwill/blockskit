//
//  CMDBlocksKit.h
//  CMDBlocksKit
//
//  Created by Caleb Davenport on 5/22/12.
//  Copyright (c) 2012 Caleb Davenport.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE && !defined(__IPHONE_4_0)
    #error This project uses features only available in iOS SDK 4.0 and later.
#endif

#if !__has_feature(objc_arc)
    #error This project requires ARC.
#endif

#import "NSArray+CMDBlocksKit.h"
#import "UIAlertView+CMDBlocksKit.h"
#import "UIActionSheet+CMDBlocksKit.h"
#import "NSNumber+CMDBlocksKit.h"
#import "NSSet+CMDBlocksKit.h"
#import "UIControl+CMDBlocksKit.h"
#import "UIBarButtonItem+CMDBlocksKit.h"
