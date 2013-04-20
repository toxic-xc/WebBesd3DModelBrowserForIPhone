//
//  Face.h
//  TestTest
//
//  Created by Toxic on 13-3-17.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@interface Face : NSObject

// Number of vertex
@property (assign) int nverts;

// Vertexes
@property (strong) NSMutableArray *verts;


// Normal vector
@property (assign) double normalX;
@property (assign) double normalY;
@property (assign) double normalZ;

// Constructor
@end