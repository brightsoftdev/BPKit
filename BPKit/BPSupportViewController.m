//
//  BPSupportViewController.m
//  BPKit
//
//  Created by Brian Partridge on 3/17/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "BPSupportViewController.h"
#import "BPAboutViewController.h"

typedef enum {
    SectionSupport,
    SectionRate,
    SectionUpgrade,
    SectionAbout,
    SectionCount,
} Sections;

@interface BPSupportViewController ()

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSMutableArray *sections;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation BPSupportViewController

@synthesize cellColor;

@synthesize data;
@synthesize sections;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Support";
    
    self.data = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"BPSupportContent"];
    
    BOOL showUpgradePath = (![NSString bp_isNilOrEmpty:[self.data objectForKey:@"BPUpgradeURL"]]);
    
    self.sections = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:SectionSupport], 
                     [NSNumber numberWithInt:SectionRate], nil];
    if (showUpgradePath) {
        [self.sections addObject:[NSNumber numberWithInt:SectionUpgrade]];
    }
    [self.sections addObject:[NSNumber numberWithInt:SectionAbout]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = self.cellColor;
    
    switch (indexPath.section) {
        case SectionRate:
            cell.textLabel.text = [NSString stringWithFormat:@"I love it!", [NSBundle mainBundle].bp_name];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"rate"];
            break;
        case SectionSupport:
            cell.textLabel.text = @"Contact Support";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"support"];
            break;
        case SectionUpgrade:
            cell.textLabel.text = @"Upgrade To Pro";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"upgrade"];
            break;
        case SectionAbout:
            cell.textLabel.text = @"About";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    
    switch (section) {
        case SectionSupport:
            title = @"Found a problem?";
            break;
        case SectionRate:
            title = [NSString stringWithFormat:@"Like %@?", [NSBundle mainBundle].bp_name];
            break;
        default:
            break;
    }
    
    return title;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = nil;
    
    switch (section) {
        case SectionUpgrade:
            // TODO: generate view
            break;
        default:
            break;
    }
    
    return footer;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case SectionRate: {
            NSURL *url = [NSURL URLWithString:[self.data objectForKey:@"BPRateURL"]];
            [[UIApplication sharedApplication] openURL:url];
        }   break;
        case SectionSupport: {
            MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
            mailer.mailComposeDelegate = self;
            [mailer setSubject:[NSString stringWithFormat:@"[%@ Support] ", [[NSBundle mainBundle] bp_name]]];
            [mailer setToRecipients:[NSArray arrayWithObject:[self.data objectForKey:@"BPSupportEmail"]]];
            NSString *body = [NSString stringWithFormat:@"\n\nThis message was generated by %@ v%@.", 
                              [[NSBundle mainBundle] bp_name], 
                              [[NSBundle mainBundle] bp_version]];
            [mailer setMessageBody:body isHTML:NO];
            [self presentModalViewController:mailer animated:YES];
        }   break;
        case SectionUpgrade: {
            NSURL *url = [NSURL URLWithString:[self.data objectForKey:@"BPUpgradeURL"]];
            [[UIApplication sharedApplication] openURL:url];
        }   break;
        case SectionAbout: {
            BPAboutViewController *about = [[BPAboutViewController alloc] initWithStyle:self.tableView.style];
            about.tableView.backgroundColor = self.tableView.backgroundColor;
            about.tableView.backgroundView = [self.tableView.backgroundView copy];
            about.cellColor = self.cellColor;
            [self.navigationController pushViewController:about animated:YES];
        }   break;
        default:
            break;
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissModalViewControllerAnimated:YES];
}

@end
