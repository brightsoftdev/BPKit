//
//  BPSupportViewController.m
//  BPKit
//
//  Created by Brian Partridge on 3/17/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "BPSupportViewController.h"
#import "BPCreditsViewController.h"

typedef enum {
    SectionSupport,
    SectionLike,
    SectionAbout,
    SectionCount,
} Sections;

typedef enum {
    SectionLikeRowRate,
    SectionLikeRowUpgrade,
    SectionLikeRowCount,
    SectionLikeRowCountNoUpgrade = SectionLikeRowUpgrade,
} SectionLikeRows;

typedef enum {
    SectionAboutRowApp,
    SectionAboutRowCredits,
    SectionAboutRowCount,
} SectionAboutRows;

@interface BPSupportViewController ()

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSMutableArray *sections;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation BPSupportViewController

@synthesize data;
@synthesize sections;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Support";
    
    self.data = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"BPSupportContent"];
    
    self.sections = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:SectionSupport], 
                     [NSNumber numberWithInt:SectionLike], 
                     [NSNumber numberWithInt:SectionAbout], 
                     nil];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case SectionSupport:
            cell.textLabel.text = @"Contact Support";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.imageView.image = [UIImage imageNamed:@"support"];
            break;
        case SectionLike:
            switch (indexPath.row) {
                case SectionLikeRowRate:
                    cell.textLabel.text = [NSString stringWithFormat:@"I love it!", [NSBundle mainBundle].bp_name];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.imageView.image = [UIImage imageNamed:@"rate"];
                    break;
                case SectionLikeRowUpgrade:
                    cell.textLabel.text = @"Upgrade To Pro";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.imageView.image = [UIImage imageNamed:@"upgrade"];
                    break;
                default:
                    break;
            }
            break;
        case SectionAbout:
            switch (indexPath.row) {
                case SectionAboutRowApp:
                    cell.textLabel.text = [NSBundle mainBundle].bp_name;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"v%@", [NSBundle mainBundle].bp_version];
                    break;
                case SectionAboutRowCredits:
                    cell.textLabel.text = @"Credits";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    break;
            }
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
    NSInteger count = 0;
    
    switch (section) {
        case SectionSupport:
            count = 1;
            break;
        case SectionLike:
            count = ([NSString bp_isNilOrEmpty:[self.data objectForKey:@"BPUpgradeURL"]]) ?
                      SectionLikeRowCountNoUpgrade : SectionLikeRowCount;
            break;
        case SectionAbout:
            count = SectionAboutRowCount;
            break;
        default:
            break;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
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
        case SectionLike:
            title = [NSString stringWithFormat:@"Like %@?", [NSBundle mainBundle].bp_name];
            break;
        default:
            break;
    }
    
    return title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *title = nil;
    
    switch (section) {
        case SectionLike:
            title = [self.data objectForKey:@"BPUpgradeCopy"];
            break;
        case SectionAbout:
            title = [NSString stringWithFormat:@"‌© %@ %@", [self.data objectForKey:@"BPCopyrightYear"], [self.data objectForKey:@"BPCopyrightHolder"]];
            break;
        default:
            break;
    }
    
    return title;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
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
        case SectionLike:
            switch (indexPath.row) {
                case SectionLikeRowRate: {
                    NSURL *url = [NSURL URLWithString:[self.data objectForKey:@"BPRateURL"]];
                    [[UIApplication sharedApplication] openURL:url];
                }   break;
                case SectionLikeRowUpgrade: {
                    NSURL *url = [NSURL URLWithString:[self.data objectForKey:@"BPUpgradeURL"]];
                    [[UIApplication sharedApplication] openURL:url];
                }   break;
                default:
                    break;
            }
            break;
        case SectionAbout: {
            BPCreditsViewController *credits = [[BPCreditsViewController alloc] initWithStyle:self.tableView.style];
            credits.tableView.backgroundColor = self.tableView.backgroundColor;
            credits.tableView.backgroundView = [self.tableView.backgroundView copy];
            [self shareBlocksWithController:credits];
            [self.navigationController pushViewController:credits animated:YES];
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
