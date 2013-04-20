//
//  Vertex.m
//  TestTest
//
//  Created by Toxic on 13-3-17.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import "Vertex.h"

@implementation Vertex
@synthesize x;
@synthesize y;
@synthesize z;


- (id)init
{
    self = [super init];
    if(self != nil) {
        x = 0;
        y = 0;
        z = 0;
    }
    
    return self;
}

@end
