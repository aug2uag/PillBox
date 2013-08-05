//
//  PBPopupDelegate.h
//  PillBox
//
//  Created by Reza Fatahi on 8/4/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UAModalPanel.h"

@protocol PBPopupDelegate <NSObject>

- (void)sendStringFromModalView:(NSString *)theString andModalPanel:(UAModalPanel *)theModalPanel;

@end

