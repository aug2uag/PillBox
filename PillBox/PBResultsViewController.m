//
//  PBResultsViewController.m
//  PillBox
//
//  Created by Reza Fatahi on 8/12/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "PBResultsViewController.h"

@interface PBResultsViewController ()
{
    __weak IBOutlet UITableView *oTableView;
}

@end

@implementation PBResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"results array is %@", self.pbResultsArray);
	// Do any additional setup after loading the view.
}


#pragma mark-table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pbResultsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    
    
    //declare string, assign to value at indexPath from array
    //array may be made from [dictionary allKeys];
    NSString* string = [_pbResultsArray objectAtIndex:indexPath.row];
    
    
    //set string to textLabel of cell
    [cell.textLabel setText:string];
    
    return cell;
}

@end
