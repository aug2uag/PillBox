//
//  PBTextFieldModalPanel.m
//  PillBox
//
//  Created by Reza Fatahi on 8/6/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

//
//  PBTextFieldModalPanel.m
//  PillBox
//
//  Created by Reza Fatahi on 8/6/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "PBTextFieldModalPanel.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_TITLE_BAR_HEIGHT	40.0f

@interface PBTextFieldModalPanel ()

- (BOOL)checkValidityOfSearchTerm:(NSString *)input;
- (IBAction)pbAction:(id)sender;

@end

@implementation PBTextFieldModalPanel

@synthesize titleBarHeight, titleBar, headerLabel, viewLoadedFromXib;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.pbTextField.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 200, 20);
        
		self.titleBarHeight = DEFAULT_TITLE_BAR_HEIGHT;
		
		CGFloat colors[8] = { 1, 1, 1, 1, 0, 0, 0, 1 };
		self.titleBar = [UANoisyGradientBackground gradientWithFrame:CGRectZero
															   style:UAGradientBackgroundStyleLinear
															   color:colors
															lineMode:UAGradientLineModeTopAndBottom
														noiseOpacity:0.2
														   blendMode:kCGBlendModeNormal];
		
		[self.roundedRect addSubview:self.titleBar];
		
		self.headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		self.headerLabel.font = [UIFont systemFontOfSize:24];
		self.headerLabel.backgroundColor = [UIColor clearColor];
		self.headerLabel.textColor = [UIColor whiteColor];
		self.headerLabel.shadowColor = [UIColor blackColor];
		self.headerLabel.shadowOffset = CGSizeMake(0, -1);
		self.headerLabel.textAlignment = NSTextAlignmentCenter	;
		[self.titleBar addSubview:self.headerLabel];
        
		[self.titleBar setColorComponents:colors];
        self.headerLabel.text = @" ";
        
        [[NSBundle mainBundle] loadNibNamed:@"PBTextFieldView" owner:self options:nil];
        
        [self.contentView addSubview:viewLoadedFromXib];
        
    }
    
    return self;
}


- (CGRect)titleBarFrame {
	CGRect frame = [self.roundedRect bounds];
	return CGRectMake(frame.origin.x,
					  frame.origin.y + self.roundedRect.layer.borderWidth,
					  frame.size.width,
					  self.titleBarHeight - self.roundedRect.layer.borderWidth);
    
}


// overriding the subclass to make room for the title bar
- (CGRect)contentViewFrame {
	CGRect titleBarFrame = [self titleBarFrame];
	CGRect roundedRectFrame = [self roundedRectFrame];
	CGFloat y = titleBarFrame.origin.y + titleBarFrame.size.height;
	CGRect rect = CGRectMake(self.margin.left + self.padding.left,
							 self.margin.top + self.padding.top + y,
							 roundedRectFrame.size.width - self.padding.left - self.padding.right,
							 roundedRectFrame.size.height - y - self.padding.bottom - self.padding.bottom);
    
	return rect;
}

// Overrides

- (void)showAnimationStarting {
	self.contentView.alpha = 0.0;
	self.titleBar.alpha = 0.0;
}

- (void)showAnimationFinished {
    
    
	UADebugLog(@"Fading in content for modalPanel: %@", self);
	[UIView animateWithDuration:0.2
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseOut
					 animations:^{
						 self.contentView.alpha = 1.0;
						 self.titleBar.alpha = 1.0;
					 }
					 completion:nil];
}


- (void)layoutSubviews {
	[super layoutSubviews];
    
    self.titleBar.frame = [self titleBarFrame];
	self.headerLabel.frame = self.titleBar.bounds;
	
	[viewLoadedFromXib setFrame:self.contentView.bounds];
}

- (BOOL)checkValidityOfSearchTerm:(NSString *)input
{
    
}

- (IBAction)pbAction:(id)sender {
}


@end

