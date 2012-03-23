//
//  BPTableViewController.m
//  BPKit
//
//  Created by Brian Partridge on 3/19/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "BPTableViewController.h"

@interface BPTableViewController ()

@end

@implementation BPTableViewController

@synthesize didLoad;
@synthesize willAppear;
@synthesize didAppear;
@synthesize styleCell;
@synthesize styleHeaderView;
@synthesize styleFooterView;
@synthesize footerHeight;

- (void)shareBlocksWithController:(BPTableViewController *)controller {
    controller.didLoad = self.didLoad;
    controller.willAppear = self.willAppear;
    controller.didAppear = self.didAppear;
    controller.styleCell = self.styleCell;
    controller.styleHeaderView = self.styleHeaderView;
    controller.styleFooterView = self.styleFooterView;
    controller.footerHeight = self.footerHeight;
}

- (id)init {
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.didLoad != nil) {
        self.didLoad(self, NO);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.willAppear != nil) {
        self.willAppear(self, animated);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.didAppear != nil) {
        self.didAppear(self, animated);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = nil;
    
    if (self.styleHeaderView != nil) {
        header = self.styleHeaderView(tableView, section);
    }
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = nil;
    
    if (self.styleFooterView != nil) {
        footer = self.styleFooterView(tableView, section);
    }
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0;
    
    if (self.footerHeight != nil) {
        height = self.footerHeight(tableView, [NSIndexPath indexPathForRow:0 inSection:section]);
    }
    
    return height;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.styleCell != nil) {
        self.styleCell(cell);
    }
}

@end
