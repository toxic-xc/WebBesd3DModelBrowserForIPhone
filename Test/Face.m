//
//  Face.m
//  TestTest
//
//  Created by Toxic on 13-3-17.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import "Face.h"


@implementation Face
@synthesize nverts;
@synthesize verts;
@synthesize normalX;
@synthesize normalY;
@synthesize normalZ;

- (id)init
{
    self = [super init];
    if(self != nil) {
        nverts = 0;
        verts = [[NSMutableArray alloc] init];
        normalX = 0;
        normalY = 0;
        normalZ = 0;
    }
    
    return self;
}
@end