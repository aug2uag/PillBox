//
//  NSString+PBExtension.m
//  PillBox
//
//  Created by Reza Fatahi on 8/6/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "NSString+PBExtension.h"

@implementation NSString (PBExtension)

- (BOOL)containsString:(NSString*)substring
{
    NSRange range = [self rangeOfString:substring];
    BOOL found = (range.location != NSNotFound);
    return found;
}

@end
