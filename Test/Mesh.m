//
//  Mesh.m
//  TestTest
//
//  Created by Toxic on 13-3-17.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import "Mesh.h"

@implementation Mesh
@synthesize nverts;
@synthesize verts;
@synthesize nfaces;
@synthesize faces;

- (id)init
{
    self = [super init];
    if(self != nil) {
        nfaces = 0;
        nverts = 0;
        verts = [[NSMutableArray alloc] init];
        faces = [[NSMutableArray alloc] init];
    }
    
    return self;
}
@end
