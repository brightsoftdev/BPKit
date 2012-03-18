//
//  BPSupportViewController.h
//  BPKit
//
//  Created by Brian Partridge on 3/17/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface BPSupportViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIColor *cellColor;

@end
