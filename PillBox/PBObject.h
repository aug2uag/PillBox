//
//  PBObject.h
//  PillBox
//
//  Created by Reza Fatahi on 8/16/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PBObject : NSObject

@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) NSString* ingredient;
@property (strong, nonatomic) NSString* inactiveIngredients;
@property (strong, nonatomic) NSString* name;

- (id)initWithAuthor:(NSString *)anAuthor theInactives:(NSString *)anInactiveIngredients theName:(NSString *)aName;

@end
