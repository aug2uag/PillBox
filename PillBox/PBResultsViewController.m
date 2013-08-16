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

@synthesize pbResultsArray;

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
    return pbResultsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
    
    //declare string, assign to value at indexPath from array
    //array may be made from [dictionary allKeys];
    NSString* pbRxName = [(NSString *)[[pbResultsArray objectAtIndex:indexPath.row] objectForKey:@"RXSTRING"] valueForKey:@"text"];
    NSRange foundRange = [pbRxName rangeOfString:@"\n\t"];
    if (foundRange.location != NSNotFound)
        [pbRxName stringByReplacingOccurrencesOfString:@"\n\t"
                                            withString:@""
                                               options:0
                                                 range:foundRange];
    
    NSString* pbIngredient = [(NSString *)[[pbResultsArray objectAtIndex:indexPath.row] objectForKey:@"INGREDIENTS"] valueForKey:@"text"];
    foundRange = [pbIngredient rangeOfString:@"\n\t"];
    if (foundRange.location != NSNotFound)
        [pbIngredient stringByReplacingOccurrencesOfString:@"\n\t"
                                            withString:@""
                                               options:0
                                                 range:foundRange];
    
    //set string to textLabel of cell
    [cell.textLabel setText:pbRxName];
    [cell.detailTextLabel setText:pbIngredient];
    
    return cell;
}

@end
