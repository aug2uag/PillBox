//
//  ViewController.m
//  PillBox
//
//  Created by Reza Fatahi on 8/3/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell00.h"

@interface ViewController ()
{
    NSArray* array;
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
    
    if (indexPath.row == 2) {
        CustomTableViewCell00* cell = [tableView dequeueReusableCellWithIdentifier:@"customTableCell"];
        
        if (cell == nil) {
            cell = [[CustomTableViewCell00 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customTableCell"];
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
                ColorsModalPanel *colorsPanel = [[ColorsModalPanel alloc] initWithFrame:self.view.bounds];
                colorsPanel.delegate = (id)self;
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
    if (indexPath.row != 2) {
        return 54.0f;
    }
    return 44.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Label";
    } else {
        return @"Physical attributes";
    }
}

- (void)anotherDelegateMethod
{
    NSLog(@"smurphing");
}

- (void)willCloseModalPanel:(UAModalPanel *)modalPanel {
	NSLog(@"CLOSED IN VC");
}

@end
