//
//  ColorsModalPanel.m
//  PillBox
//
//  Created by Reza Fatahi on 8/3/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "ColorsModalPanel.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_TITLE_BAR_HEIGHT	40.0f

@interface ColorsModalPanel ()
{
    NSArray* selections;
    UITableView *myTableView;
}

@end

@implementation ColorsModalPanel

@synthesize titleBarHeight, titleBar, headerLabel, viewLoadedFromXib;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        selections = [[NSArray alloc] initWithObjects:@"BLACK", @"BLUE", @"BROWN", @"GRAY", @"GREEN", @"ORANGE", @"PINK",@"PURPLE", @"RED", @"TURQUOISE", @"WHITE", @"YELLOW", nil];
        
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
        self.headerLabel.text = @"CHOOSE PILL COLOR";
        
        myTableView = [[UITableView alloc] initWithFrame:CGRectZero];
        myTableView.dataSource = self;
        myTableView.delegate = self;
        
        [[NSBundle mainBundle] loadNibNamed:@"ColorsView" owner:self options:nil];
        
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
    
    [myTableView flashScrollIndicators];
}


#pragma mark-table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return selections.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    
    
    //declare string, assign to value at indexPath from array
    //array may be made from [dictionary allKeys];
    NSString* string = [selections objectAtIndex:indexPath.row];
    
    
    //set string to textLabel of cell
    [cell.textLabel setText:string];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.popupDelegate anotherDelegateMethod];
}

@end
