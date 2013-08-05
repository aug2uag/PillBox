//
//  ViewController.m
//  PillBox
//
//  Created by Reza Fatahi on 8/3/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell00.h"
#import "CustomTableViewCell01.h"

@interface ViewController ()
{
    NSArray* array;
    ColorsModalPanel *colorsPanel;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    array = @[@[@"Manufacturer", @"Name/Active ingredient", @"Inactive ingredient"], @[@"Color", @"Shape", @"Size"]];
}


#pragma mark-table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return array.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        CustomTableViewCell00* cell = [tableView dequeueReusableCellWithIdentifier:@"customTableCell"];
        
        if (cell == nil) {
            cell = [[CustomTableViewCell00 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customTableCell"];
        }
        
        if (indexPath.section == 1) {
            CustomTableViewCell01* cell = [tableView dequeueReusableCellWithIdentifier:@"customTableCell01"];
            
            if (cell == nil) {
                cell = [[CustomTableViewCell01 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customTableCell01"];
            }
            
            //cell.oLabel01.hidden = YES;
        }
        
        NSString* string = array[indexPath.section][indexPath.row];
        
        //set string to textLabel of cell
        [cell.oLabel setText:string];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    
    //declare string, assign to value at indexPath from array
    //array may be made from [dictionary allKeys];
    NSString* string = array[indexPath.section][indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //set string to textLabel of cell
    [cell.textLabel setText:string];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 2) {
        
        
        switch (indexPath.row)
        {
            case 0:
                NSLog(@"zero");
            {
                colorsPanel = [[ColorsModalPanel alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.x, self.view.frame.size.width, self.view.bounds.size.width)];
                colorsPanel.delegate = (id)self;
                colorsPanel.popupDelegate = (id)self;
                [self.view addSubview:colorsPanel];
                [colorsPanel showFromPoint:self.view.center];
            }
                break;
            case 1:
                NSLog(@"one");
                break;
            case 3:
                NSLog(@"three");
                break;
            case 4:
                NSLog(@"four");
                break;
            case 5:
                NSLog(@"five");
                break;
        }
        
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

    
    if (theModalPanel == colorsPanel) {
        
        NSString* displayString = [NSString stringWithFormat:@"Color is: %@", theString];
        
        [[self.oTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].textLabel setText:displayString];
        
    }
}

- (void)willCloseModalPanel:(UAModalPanel *)modalPanel {
	NSLog(@"CLOSED IN VC");
    if (modalPanel == colorsPanel) {
        //code
    }
}

@end
