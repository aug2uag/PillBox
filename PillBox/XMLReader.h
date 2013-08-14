//
//  XMLReader.h
//  PillBox
//
//  Created by Reza Fatahi on 8/13/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLReader : NSObject
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError *errorPointer;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data;

@end