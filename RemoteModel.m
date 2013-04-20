//
//  RemoteModel.m
//  Test
//
//  Created by Toxic on 13-3-27.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import "RemoteModel.h"

@implementation RemoteModel
@synthesize name;
@synthesize strURL;

- (id) init
{
    self = [super init];
    if (self != nil) {
        name = nil;
        strURL = nil;
        
    }
    
    return self;
}

@end
