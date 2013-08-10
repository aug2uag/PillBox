//
//  ViewController.m
//  PillBox
//
//  Created by Reza Fatahi on 8/3/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "PBViewController.h"
#import "UICustomSwitch.h"
#import "NSString+PBExtension.h"

@interface PBViewController ()
{
    NSArray*                pbArray;
    PBColorsModalPanel*     pbColorPanel;
    PBSizeModalPanel*       pbSizePanel;
    PBShapeModalPanel*      pbShapePanel;
    PBTextFieldModalPanel*  pbTextPanel;
    UICustomSwitch*         pbSwitch;
    
    NSString*               pbAuthorString;
    NSString*               pbActiveString;
    NSString*               pbOtherString;
    NSString*               pbColorString;
    NSString*               pbShapeString;
    NSString*               pbSizeString;
}
- (IBAction)searchWithAction:(id)sender;

@end

@implementation PBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    pbArray = @[@[@"Manufacturer", @"Name/Active ingredient", @"Inactive ingredient"], @[@"Color", @"Shape", @"Size"]];
    
    pbSwitch = [[UICustomSwitch alloc] initWithFrame:CGRectMake(220.0f, 57.0f, 40.0f, 20.0f)];
    [self.view addSubview:pbSwitch];
    pbSwitch.leftLabel.text = @"ON";
    pbSwitch.rightLabel.text = @"OFF";
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
    if (indexPath.section == 0) {
        pbTextPanel = [[PBTextFieldModalPanel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.x, self.view.frame.size.width, self.view.bounds.size.width)];
        
        switch (indexPath.row) {
            case 0:
                pbTextPanel.originString = @"MANUFACTURER";
                break;
                
            case 1:
                pbTextPanel.originString = @"ACTIVE INGREDIENT";
                break;
                
            case 2:
                pbTextPanel.originString = @"OTHER INGREDIENT";
                break;
                
            default:
                break;
        }
        
        pbTextPanel.delegate = (id)self;
        pbTextPanel.popupDelegate = (id)self;
        [self.view addSubview:pbTextPanel];
        [pbTextPanel showFromPoint:self.view.center];
        [self willShowModalPanel:pbTextPanel];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        pbColorPanel = [[PBColorsModalPanel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.x, self.view.frame.size.width, self.view.bounds.size.width)];
        pbColorPanel.delegate = (id)self;
        pbColorPanel.popupDelegate = (id)self;
        [self.view addSubview:pbColorPanel];
        [pbColorPanel showFromPoint:self.view.center];
    }
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        pbShapePanel = [[PBShapeModalPanel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.x, self.view.frame.size.width, self.view.bounds.size.width)];
        pbShapePanel.delegate = (id)self;
        pbShapePanel.popupDelegate = (id)self;
        [self.view addSubview:pbShapePanel];
        [pbShapePanel showFromPoint:self.view.center];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        pbSizePanel = [[PBSizeModalPanel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.x, self.view.frame.size.width, self.view.bounds.size.width)];
        pbSizePanel.delegate = (id)self;
        pbSizePanel.popupDelegate = (id)self;
        [self.view addSubview:pbSizePanel];
        [pbSizePanel showFromPoint:self.view.center];
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
    return 27.0f;
}

- (void)sendStringFromModalView:(NSString *)theString andModalPanel:(UAModalPanel *)theModalPanel
{
    if (theModalPanel == pbTextPanel) {
        if ([theString containsString:@"&!MANUFACTURER"]) {
            NSString* displayString =  [theString componentsSeparatedByString:@" &!MANUFACTURER"][0];
            pbAuthorString = displayString;
            displayString = [NSString stringWithFormat:@"Rx Made By: %@", displayString];
            UITableViewCell* cell = [self.oTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell.textLabel setText:displayString];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
        }
        
        if ([theString containsString:@"&!ACTIVE"]) {
            NSString* displayString = [theString componentsSeparatedByString:@" &!ACTIVE"][0];
            pbActiveString = displayString;
            displayString = [NSString stringWithFormat:@"Active Ingredient: %@", displayString];
            UITableViewCell* cell = [self.oTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell.textLabel setText:displayString];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
        }
        
        if ([theString containsString:@"&!OTHER"]) {
            NSString* displayString = [theString componentsSeparatedByString:@" &!OTHER"][0];
            displayString = [NSString stringWithFormat:@"Inactive Ingredient: %@", displayString];
            pbOtherString = displayString;
            UITableViewCell* cell = [self.oTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            [cell.textLabel setText:displayString];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
        }
        
    }
    
    if (theModalPanel == pbColorPanel) {
        if ([theString containsString:@"is:"]) {
            pbColorString = [theString componentsSeparatedByString:@"is: "][1];
        } else {
            pbColorString = nil;
        }
        
        NSLog(@"sizeString %@", pbColorString);
        UITableViewCell* cell = [self.oTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.textLabel setText:theString];
        return;
    }
    
    if (theModalPanel == pbShapePanel) {
        if ([theString containsString:@"is:"]) {
            pbShapeString = [theString componentsSeparatedByString:@"is: "][1];
        } else {
            pbShapeString = nil;
        }
        
        NSLog(@"sizeString %@", pbShapeString);
        UITableViewCell* cell = [self.oTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.textLabel setText:theString];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        return;
    }
    
    if (theModalPanel == pbSizePanel) {
        if ([theString containsString:@"is:"]) {
            pbSizeString = [theString componentsSeparatedByString:@"is: "][1];
            pbSizeString = [pbSizeString componentsSeparatedByString:@" ±"][0];
        } else {
            pbSizeString = nil;
        }
        
        NSLog(@"sizeString %@", pbSizeString);
        UITableViewCell* cell = [self.oTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.textLabel setText:theString];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        return;
    }
    
}

- (void)willShowModalPanel:(UAModalPanel *)modalPanel
{
    
}

- (IBAction)searchWithAction:(id)sender
{
    NSLog(@"HHEEEYYY");
    NSMutableDictionary* pbTemplate = [[NSMutableDictionary alloc] initWithCapacity:6];
    if (pbSizeString != nil && pbSizeString.length > 0) {
        [pbTemplate setValue:pbSizeString forKey:@"size"];
    }
    if (pbShapeString != nil && pbShapeString.length > 0) {
        [pbTemplate setValue:pbShapeString forKey:@"shape"];
    }
    if (pbColorString != nil && pbColorString.length > 0) {
        [pbTemplate setValue:pbColorString forKey:@"color"];
    }
    if (pbOtherString.length > 0) {
        [pbTemplate setValue:pbOtherString forKey:@"inactive"];
    }
    if (pbActiveString.length > 0) {
        [pbTemplate setValue:pbActiveString forKey:@"ingredient"];
    }
    if (pbAuthorString.length > 0) {
        [pbTemplate setValue:pbAuthorString forKey:@"author"];
    }
    if (pbSwitch.on) {
        [pbTemplate setValue:@1 forKey:@"has_image"];
    }
    
    NSLog(@"pbTemplate => %@", pbTemplate);
}

@end
