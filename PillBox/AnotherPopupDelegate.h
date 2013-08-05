//
//  AnotherPopupDelegate.h
//  OMApp
//
//  Created by Reza Fatahi on 7/9/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UAModalPanel.h"

@protocol AnotherPopupDelegate <NSObject>

- (void)sendStringFromModalView:(NSString *)theString andModalPanel:(UAModalPanel *)theModalPanel;

@end
