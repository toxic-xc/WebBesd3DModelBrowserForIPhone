//
//  XMLParser.m
//  Test
//
//  Created by Toxic on 13-3-27.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import "XMLParser.h"
#import "RemoteModel.h"

@implementation XMLParser


static XMLParser *instance;
NSString * strCurrentElement;
RemoteModel *model;

+ (XMLParser *)GetInstance
{
    @synchronized(self) {
        if(instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

- (NSMutableArray*) GetArrayByParserXML: (NSString*) strXML
{
    NSData *dataXML = [strXML dataUsingEncoding:NSUTF8StringEncoding];
    
    myParser = [[NSXMLParser alloc] initWithData: dataXML];
    
    [myParser setDelegate:self];
    
    bool flag = [myParser parse];
    if(flag) {
        NSLog(@"succeed");
    } else {
        NSLog(@"failed");
    }
    
    return modelList;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    strCurrentElement = elementName;
    
    if([elementName isEqualToString:@"catalog"]) {
        modelList = [[NSMutableArray alloc] init];
    } else if([elementName isEqualToString:@"model"]) {
        model = [[RemoteModel alloc] init];
    } 
    

}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if([strCurrentElement isEqualToString:@"name"]) {
        model.name = string;
    } else if ([strCurrentElement isEqualToString:@"url"]) {
        model.strURL = string;
    }
    strCurrentElement = nil;
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"model"]) {
        [modelList addObject: model];
    }
}
@end
