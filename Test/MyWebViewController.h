//
//  MyWebViewController.h
//  Test
//
//  Created by Toxic on 13-3-15.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassURLDelegate.h"
@interface MyWebViewController : UIViewController<UIWebViewDelegate, PassURLDelegate>

{
    BOOL isRun;
}

@property (assign) IBOutlet UIWebView *_webView;
@property (assign) IBOutlet UIButton *_button;

- (IBAction)btnClicked:(id)sender;

@end
