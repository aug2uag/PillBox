//
//  NSString+PBExtension.h
//  PillBox
//
//  Created by Reza Fatahi on 8/6/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PBExtension)

- (BOOL)containsString:(NSString*)substring;
+ (NSString *)scanString:(NSString *)string startTag:(NSString *)startTag endTag:(NSString *)endTag;

@end
