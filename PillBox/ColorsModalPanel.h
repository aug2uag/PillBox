//
//  ColorsModalPanel.h
//  PillBox
//
//  Created by Reza Fatahi on 8/3/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UAModalPanel.h"
#import "UANoisyGradientBackground.h"
#import "AnotherPopupDelegate.h"

@interface ColorsModalPanel : UAModalPanel
<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIView             *viewLoadedFromXib;
	CGFloat						titleBarHeight;
	UANoisyGradientBackground	*titleBar;
	UILabel						*headerLabel;
}

// Height of the title view. Default = 40.0f
@property (nonatomic, assign) CGFloat					titleBarHeight;
// The gradient bacground of the title
@property (nonatomic, retain) UANoisyGradientBackground	*titleBar;
// The title label
@property (nonatomic, retain) UILabel					*headerLabel;
@property (strong, nonatomic) id <AnotherPopupDelegate> popupDelegate;
@property (nonatomic, retain) IBOutlet UIView *viewLoadedFromXib;

- (CGRect)titleBarFrame;

@end
