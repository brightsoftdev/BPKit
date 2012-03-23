//
//  BPTableViewController.h
//  BPKit
//
//  Created by Brian Partridge on 3/19/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BPLifecycleBlock)(UIViewController *viewController, BOOL animated);
typedef void (^BPCellBlock)(UITableViewCell *cell);
typedef UIView *(^BPCustomViewBlock)(UITableView *tableView, NSInteger section);
typedef CGFloat (^BPHeightBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface BPTableViewController : UITableViewController

@property (nonatomic, copy) BPLifecycleBlock didLoad;
@property (nonatomic, copy) BPLifecycleBlock willAppear;
@property (nonatomic, copy) BPLifecycleBlock didAppear;

@property (nonatomic, copy) BPCellBlock styleCell;
@property (nonatomic, copy) BPCustomViewBlock styleHeaderView;
@property (nonatomic, copy) BPCustomViewBlock styleFooterView;
@property (nonatomic, copy) BPHeightBlock footerHeight;

- (void)shareBlocksWithController:(BPTableViewController *)controller;

@end
