//
//  MyWebViewController.m
//  Test
//
//  Created by Toxic on 13-3-15.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import "MyWebViewController.h"

// Data structure
#import "Mesh.h"
#import "Face.h"
#import "Vertex.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFXMLRequestOperation.h"
#import "XMLParser.h"
#import "RemoteModel.h"
#import "AppDelegate.h"


@interface UIWebView ()
// 匿名覆盖
- (void)_setWebGLEnabled:(BOOL)newValue;

@end

@interface MyWebViewController ()

@end

@implementation MyWebViewController
@synthesize _webView = webView;
@synthesize _button = button;


NSString *path = @"https://raw.github.com/toxic-xc/GraduateDesign/master/m100.off";
NSString *path2 = @"https://raw.github.com/toxic-xc/GraduateDesign/master/models.xml";

bool RemoteListFinishedLoad = NO;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self != nil) {
        isRun = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    id webDocumentView = [self._webView performSelector:@selector(_browserView)];
    id backingWebView = [webDocumentView performSelector:@selector(webView)];
    // 调用系统API强制启动WebGL支持
    [backingWebView _setWebGLEnabled:YES];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index_2" ofType:@"html"];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self._webView loadRequest:req];
	// Do any additional setup after loading the view.
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnClicked:(id)sender
{
    if(RemoteListFinishedLoad == YES) {
    // Dispatch javascript draw function
//    [webView stringByEvaluatingJavaScriptFromString:@"draw();"];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate MyWebViewChangeToTestTableView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}




- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
        
    // Request and parse xml file
    NSURL *url2 = [NSURL URLWithString:path2];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    AFHTTPClient *client2 = [[AFHTTPClient alloc] init];
    AFHTTPRequestOperation *operation2 = [client2 HTTPRequestOperationWithRequest:request2
                                                                          success:^(AFHTTPRequestOperation *operation2, id responseObject) {
                                                                              NSString *content2 = [operation2.responseString copy];
                                                                              
                                                                              
                                                                              
                                                                              XMLParser *parser = [XMLParser GetInstance];
                                                                              NSMutableArray *array = [parser GetArrayByParserXML:content2];
                                                                              
                                                                              AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                                                              appDelegate.remoteModelList = array;
                                                                              RemoteListFinishedLoad = YES;
                                                                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                              NSLog(@"%@",error);
                                                                          }];
    [operation2 start];
}

- (void)passURL:(NSString *)strURL
{
     
     // File load
     //NSError *error;
     //NSString *path1 = [[NSBundle mainBundle] pathForResource:@"m201" ofType:@"off"];
     NSURL *url = [NSURL URLWithString:strURL];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     AFHTTPClient *client = [[AFHTTPClient alloc] init];
     AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
     // some operations should be added in order to avoid http failure.
     NSString *content = [operation.responseString copy];
     [self parseContent:content];
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"%@",error);
     }];
     [operation start];
}

- (void)parseContent:(NSString *)content
{
    // Split file lines into NSString array
    if(content == nil) {
        NSLog(@"Can not get file content!");
        return;
    }
    
    NSArray *contentArray  = [content componentsSeparatedByString:@"\n"];
    NSScanner *theScanner;
    
    // Init number of vertices, faces and edges
    int nverts = 0;
    int nfaces = 0;
    int nedges = 0;
    
    // Init mesh
    Mesh *mesh = [[Mesh alloc] init];
    
    // Init line count
    NSUInteger lineCount;
    
    NSMutableString *vtx = [[NSMutableString alloc] init];
    NSMutableString *idx = [[NSMutableString alloc] init];
    NSMutableString *ndx = [[NSMutableString alloc] init];
    
    [vtx appendString:@"setVtx(["];
    [idx appendString:@"setIdx(["];
    [ndx appendString:@"setNdx(["];
    
    
    for(lineCount = 0; lineCount < [contentArray count]; lineCount++) {
        NSString *lineStr = [contentArray objectAtIndex:lineCount];
        
        // Skip denote and blank line
        if ([lineStr length] == 0) continue;
        if ([lineStr characterAtIndex:0] == '#') continue;
        if ([lineStr characterAtIndex:0] == '\0') continue;
        
        theScanner = [NSScanner scannerWithString:lineStr];
        if(nverts == 0) {
            if (![lineStr isEqual: @"OFF"]) {
                if(!([theScanner scanInt:&nverts] &&
                     [theScanner scanInt:&nfaces] &&
                     [theScanner scanInt:&nedges])) {
                    
                    // Error on file header
                    NSLog(@"Syntax error reading header on line %d\n", (unsigned int)lineCount);
                    return;
                }
            }
            
        } else if (mesh.nverts < nverts){
            
            Vertex *vert = [[Vertex alloc] init];
            float _x, _y, _z;
            if (!([theScanner scanFloat:&_x] &&
                  [theScanner scanFloat:&_y] &&
                  [theScanner scanFloat:&_z])) {
                
                // Error on vertices reading
                NSLog(@"Syntax error with vertex coordinates on line %d\n", (unsigned int)lineCount);
                return;
            }
            
            vert.x = _x;
            vert.y = _y;
            vert.z = _z;
            [mesh.verts addObject:vert];
            
            mesh.nverts++;
            
            [vtx appendString:[NSString stringWithFormat:@"%f,%f,%f",vert.x , vert.y , vert.z ]];
            [vtx appendString:@","];
            
            
        } else if (mesh.nfaces < nfaces) {
            Face *face = [[Face alloc] init];
            int loop;
            if(![theScanner scanInt:&loop]) {
                
                // Error on faces reading
                NSLog(@"Syntax error with face on line %d\n", (unsigned int) lineCount);
                return;
            }
            face.nverts = loop;
            int index[3];
            
            for (loop = 0; loop <  face.nverts; loop++) {
                int _vertNo;
                if (![theScanner scanInt:&_vertNo]) {
                    
                    // Error on face reading
                    NSLog(@"Syntax error with face on line %d\n", (unsigned int) lineCount);
                    return;
                } else {
                    index[loop] = _vertNo;
                    [face.verts addObject:[mesh.verts objectAtIndex:_vertNo] ];
                }
            }
            

            [idx appendString:[NSString stringWithFormat:@"%d,%d,%d",index[0], index[1], index[2]]];
            [idx appendString:@","];
                    
            
            // Calculate normal vertor
            
            Vertex *v1 = [face.verts objectAtIndex:(face.nverts -1)];
            for (int i = 0; i < face.nverts; i++) {
                Vertex *v2 = [face.verts objectAtIndex:i];
                face.normalX += (v1.y - v2.y) * (v1.z + v2.z);
                face.normalY += (v1.z - v2.z) * (v1.x + v2.x);
                face.normalZ += (v1.x - v2.x) * (v1.y + v2.y);
                v1 = v2;
            }
            
            // Normolize normal vector
            double squared_normal_length = 0.0;
            squared_normal_length += face.normalX * face.normalX;
            squared_normal_length += face.normalY * face.normalY;
            squared_normal_length += face.normalZ * face.normalZ;
            double normal_length = sqrt(squared_normal_length);
            if (normal_length > 1.0E-6) {
                face.normalX /= normal_length;
                face.normalY /= normal_length;
                face.normalZ /= normal_length;
            }
            
            NSLog(@"%f,%f,%f\n",face.normalX,face.normalY,face.normalZ);
            [ndx appendString:[NSString stringWithFormat:@"%f,%f,%f",face.normalX,face.normalY,face.normalZ]];
            [ndx appendString:@","];
            [mesh.faces addObject:face];            
            mesh.nfaces++;
        } else {
            
            // Unexcpeted line
            NSLog(@"Found extra text starting at line %d\n", (unsigned int) lineCount);
            return;
        }
    }
    
    // Expected number of faces is not equal to actual one
    if(nfaces != mesh.nfaces) {
        NSLog(@"Expected number of faces: %d is not equal to actual number of faces: %d\n", nfaces, mesh.nfaces);
        return;
    }
    
    // Concat javascript
    if ([vtx characterAtIndex:([vtx length ]- 1)] == ',') {
        [vtx deleteCharactersInRange:NSMakeRange([vtx length]- 1, 1)];
    }
    if ([idx characterAtIndex:([idx length ]- 1)] == ',') {
        [idx deleteCharactersInRange:NSMakeRange([idx length]- 1, 1)];
    }
    if ([ndx characterAtIndex:([ndx length ]- 1)] == ',') {
        [ndx deleteCharactersInRange:NSMakeRange([ndx length]- 1, 1)];
    }
    [vtx appendString:@"]);"];
    [idx appendString:@"]);"];
    [ndx appendString:[NSString stringWithFormat:@"]); nfaces = %d;initBuffers();",mesh.nfaces]];
    
    
    // Dispatch javascript function
    [self._webView stringByEvaluatingJavaScriptFromString:vtx];
    [self._webView stringByEvaluatingJavaScriptFromString:idx];
    [self._webView stringByEvaluatingJavaScriptFromString:ndx];
    [self._webView stringByEvaluatingJavaScriptFromString:@"tick();"];
}
@end

