//
//  XMLParser.h
//  Test
//
//  Created by Toxic on 13-3-27.
//  Copyright (c) 2013年 Toxic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteModel.h"

@interface XMLParser : NSObject <NSXMLParserDelegate>
{
    NSXMLParser * myParser;
    NSMutableArray * modelList;
}

+ (XMLParser *) GetInstance;
- (NSMutableArray*) GetArrayByParserXML: (NSString*) strXML;

@end
