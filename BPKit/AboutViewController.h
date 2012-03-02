//
//  BPAboutViewController.h
//  BPKit
//
//  Created by Brian Partridge on 3/2/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

extern NSString * const kBPSupportEmail;
extern NSString * const kBPSupportURL;
extern NSString * const kBPAboutContent;

@interface BPAboutViewController : UITableViewController

+ (MFMailComposeViewController *)supportMailer;

@end
