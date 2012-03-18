//
//  BPLicenseViewController.m
//  BPKit
//
//  Created by Brian Partridge on 3/18/12.
//  Copyright (c) 2012 Brian Partridge. All rights reserved.
//

#import "BPLicenseViewController.h"

@interface BPLicenseViewController ()

@property (nonatomic, strong) UIWebView *web;

@end

@implementation BPLicenseViewController

@synthesize licenseURL;
@synthesize web;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"License";
    
    self.web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    web.dataDetectorTypes = UIDataDetectorTypeNone;
    web.scalesPageToFit = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.licenseURL];
    [self.web loadRequest:request];
}

@end
