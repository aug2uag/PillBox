//
//  PBDetailViewController.m
//  PillBox
//
//  Created by Reza Fatahi on 8/16/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "PBDetailViewController.h"

@interface PBDetailViewController ()
{
    __weak IBOutlet UITextView *manufacturerTextView;
    __weak IBOutlet UITextView *prescriptionNameTextView;
    __weak IBOutlet UITextView *inactiveIngredientsTextView;

}

@end

@implementation PBDetailViewController

@synthesize currentObject;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[manufacturerTextView setText:currentObject.author];
    [inactiveIngredientsTextView setText:currentObject.inactiveIngredients];
    [prescriptionNameTextView setText:currentObject.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
