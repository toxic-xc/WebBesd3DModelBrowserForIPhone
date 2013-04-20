//
//  Mesh.h
//  TestTest
//
//  Created by Toxic on 13-3-17.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mesh : NSObject
@property (assign) int nverts;
@property (strong) NSMutableArray *verts;
@property (assign) int nfaces;
@property (strong) NSMutableArray *faces;

@end
