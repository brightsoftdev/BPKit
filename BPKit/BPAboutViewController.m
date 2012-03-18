//
//  BPAboutViewController.m
//  BPKit
//
//  Created by Brian Partridge on 3/17/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "BPAboutViewController.h"
#import "BPLicenseViewController.h"

typedef enum {
    SectionCreator,
    SectionOtherApps,
    SectionThanks,
    SectionOpenSource,
    SectionCount,
}Sections;

typedef enum {
    SectionCreatorRowName,
    SectionCreatorRowTwitter,
    SectionCreatorRowCount,
} SectionCreatorRows;

@interface BPAboutViewController ()

@property (nonatomic, strong) NSDictionary *data;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation BPAboutViewController

@synthesize cellColor;

@synthesize data;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"About";
    
    self.data = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"BPAboutContent"];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = self.cellColor;
    
    switch (indexPath.section) {
        case SectionCreator:
            switch (indexPath.row) {
                case SectionCreatorRowName:
                    cell.textLabel.text = [self.data objectForKey:@"BPCreatorName"];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case SectionCreatorRowTwitter:
                    cell.textLabel.text = [NSString stringWithFormat:@"@%@", [self.data objectForKey:@"BPCreatorTwitter"]];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                default:
                    break;
            }
            break;
        case SectionOtherApps: {
            NSArray *apps = [self.data objectForKey:@"BPOtherApps"];
            NSDictionary *app = [apps objectAtIndex:indexPath.row];
            cell.textLabel.text = [app objectForKey:@"AppName"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            // TODO: display icon
        }   break;
        case SectionThanks: {
            NSArray *thanks = [self.data objectForKey:@"BPThanks"];
            NSString *thank = [thanks objectAtIndex:indexPath.row];
            cell.textLabel.text = thank;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }   break;
        case SectionOpenSource: {
            NSArray *projects = [self.data objectForKey:@"BPOSS"];
            NSDictionary *project = [projects objectAtIndex:indexPath.row];
            cell.textLabel.text = [project objectForKey:@"ProjectName"];
            cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }   break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger count = 0;
    
    switch (section) {
        case SectionCreator:
            count = SectionCreatorRowCount;
            break;
        case SectionOtherApps:
            count = ((NSArray *)[self.data objectForKey:@"BPOtherApps"]).count;
            break;
        case SectionThanks:
            count = ((NSArray *)[self.data objectForKey:@"BPThanks"]).count;
            break;
        case SectionOpenSource:
            count = ((NSArray *)[self.data objectForKey:@"BPOSS"]).count;
            break;
        default:
            break;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
        case SectionCreator:
            title = @"Creator";
            break;
        case SectionOtherApps:
            title = @"My Other Apps";
            break;
        case SectionThanks:
            title = @"Thanks";
            break;
        case SectionOpenSource:
            title = @"Open Source";
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
        case SectionCreator:
            switch (indexPath.row) {
                case SectionCreatorRowName: {
                    NSURL *url = [NSURL URLWithString:[self.data objectForKey:@"BPCreatorURL"]];
                    [[UIApplication sharedApplication] openURL:url];
                }   break;
                case SectionCreatorRowTwitter: {
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@", [self.data objectForKey:@"BPCreatorTwitter"]]];
                    [[UIApplication sharedApplication] openURL:url];
                }   break;
                default:
                    break;
            }
            break;
        case SectionOtherApps: {
            NSArray *apps = [self.data objectForKey:@"BPOtherApps"];
            NSDictionary *app = [apps objectAtIndex:indexPath.row];
            NSURL *url = [NSURL URLWithString:[app objectForKey:@"AppURL"]];
            [[UIApplication sharedApplication] openURL:url];
        }   break;
        case SectionOpenSource: {
            NSArray *projects = [self.data objectForKey:@"BPOSS"];
            NSDictionary *project = [projects objectAtIndex:indexPath.row];
            NSURL *url = [NSURL URLWithString:[project objectForKey:@"ProjectURL"]];
            [[UIApplication sharedApplication] openURL:url];
        }   break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case SectionOpenSource: {
            NSArray *projects = [self.data objectForKey:@"BPOSS"];
            NSDictionary *project = [projects objectAtIndex:indexPath.row];
            NSString *file = [project objectForKey:@"ProjectLicense"];
            NSURL *url = [[NSBundle mainBundle] URLForResource:[file stringByDeletingPathExtension] withExtension:[file pathExtension]];
            BPLicenseViewController *viewer = [[BPLicenseViewController alloc] init];
            viewer.licenseURL = url;
            [self.navigationController pushViewController:viewer animated:YES];
        }   break;
        default:
            break;
    }
}

@end
