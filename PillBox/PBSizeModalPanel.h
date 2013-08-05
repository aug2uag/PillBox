//
//  PBSizeModalPanel.h
//  PillBox
//
//  Created by Reza Fatahi on 8/4/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UAModalPanel.h"
#import "UANoisyGradientBackground.h"
#import "PBPopupDelegate.h"

@interface PBSizeModalPanel : UAModalPanel
{
    IBOutlet UIView*            viewLoadedFromXib;
	CGFloat						titleBarHeight;
	UANoisyGradientBackground*  titleBar;
	UILabel*                    headerLabel;
}

@property (strong, nonatomic) NSArray*                  pbSelections;
@property (strong, nonatomic) UIPickerView*             pbPickerView;
@property (assign, nonatomic) BOOL                      cellChecked;
@property (nonatomic, assign) CGFloat					titleBarHeight;
@property (nonatomic, retain) UANoisyGradientBackground*titleBar;
@property (nonatomic, retain) UILabel*                  headerLabel;
@property (strong, nonatomic) id <PBPopupDelegate>      popupDelegate;
@property (nonatomic, retain) IBOutlet UIView*          viewLoadedFromXib;

- (CGRect)titleBarFrame;

@end

