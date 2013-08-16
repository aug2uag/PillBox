//
//  PBObject.m
//  PillBox
//
//  Created by Reza Fatahi on 8/16/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "PBObject.h"

@implementation PBObject

@synthesize author, ingredient, inactiveIngredients, name;

- (id)initWithAuthor:(NSString *)anAuthor theInactives:(NSString *)anInactiveIngredients theName:(NSString *)aName
{
    if (self = [super init]) {
        author = anAuthor;
        inactiveIngredients = anInactiveIngredients;
        name = aName;
    }
    
    return self;
}

@end
