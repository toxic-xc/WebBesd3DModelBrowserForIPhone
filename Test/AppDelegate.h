//
//  AppDelegate.h
//  Test
//
//  Created by Toxic on 13-3-15.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyWebViewController;
@class TestTableViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MyWebViewController *_myWebViewController;
    TestTableViewController *_testTableViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (copy) NSMutableArray *remoteModelList;


- (void) MyWebViewChangeToTestTableView;
- (void) TestTableViewChangeToMyWebView;

@end
