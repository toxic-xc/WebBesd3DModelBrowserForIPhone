//
//  AppDelegate.m
//  Test
//
//  Created by Toxic on 13-3-15.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import "AppDelegate.h"
#import "MyWebViewController.h"
#import "TestTableViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    _myWebViewController = [[MyWebViewController alloc] initWithNibName:@"MyWebView" bundle:nil];
    self.window.rootViewController = _myWebViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)MyWebViewChangeToTestTableView
{
    if(_testTableViewController == nil) {
        _testTableViewController = [[TestTableViewController alloc] initWithNibName:@"TestTableViewController" bundle:nil];
        _testTableViewController.delegate = _myWebViewController;
    }
    self.window.rootViewController = _testTableViewController;
    [self.window makeKeyAndVisible];
}

- (void)TestTableViewChangeToMyWebView
{
    self.window.rootViewController = _myWebViewController;
    [self.window makeKeyAndVisible];
}

@end
