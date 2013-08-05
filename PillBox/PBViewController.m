//
//  ViewController.m
//  PillBox
//
//  Created by Reza Fatahi on 8/3/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "PBViewController.h"

@interface PBViewController ()
{
    NSArray* pbArray;
    PBColorsModalPanel *pbColorPanel;
}

@end

@implementation PBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    pbArray = @[@[@"Manufacturer", @"Name/Active ingredient", @"Inactive ingredient"], @[@"Color", @"Shape", @"Size"]];
}


#pragma mark-table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return pbArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pbArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    
    //declare string, assign to value at indexPath from array
    //array may be made from [dictionary allKeys];
    NSString* string = pbArray[indexPath.section][indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //set string to textLabel of cell
    [cell.textLabel setText:string];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        pbColorPanel = [[PBColorsModalPanel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.x, self.view.frame.size.width, self.view.bounds.size.width)];
        pbColorPanel.delegate = (id)self;
        pbColorPanel.popupDelegate = (id)self;
        [self.view addSubview:pbColorPanel];
        [pbColorPanel showFromPoint:self.view.center];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Label";
    } else {
        return @"Physical attributes";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (void)sendStringFromModalView:(NSString *)theString andModalPanel:(UAModalPanel *)theModalPanel
{

    
    if (theModalPanel == pbColorPanel) {
        
        NSString* displayString = [NSString stringWithFormat:@"Color is: %@", theString];
        
        [[self.oTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].textLabel setText:displayString];
        
    }
}

- (void)willCloseModalPanel:(UAModalPanel *)modalPanel {
	NSLog(@"CLOSED IN VC");
    if (modalPanel == pbColorPanel) {
        //code
    }
}

@end