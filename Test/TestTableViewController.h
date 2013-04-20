//
//  TestTableViewController.h
//  Test
//
//  Created by Toxic on 13-3-28.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassURLDelegate.h"
@interface TestTableViewController : UITableViewController
@property (assign) NSObject<PassURLDelegate> *delegate;

- (IBAction)backButtonClicked:(id)sender;

@end

