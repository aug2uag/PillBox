//
//  CustomCollectionViewCell.m
//  PillBox
//
//  Created by Reza Fatahi on 8/3/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()
{
    NSArray* array;
}

@end

@implementation CustomCollectionViewCell

- (void)layoutSubviews
{
    array = @[@"color", @"dea schedule", @"has image?", @"active ingredient", @"shape of pill", @"size of pill"];
}

#pragma mark-table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id"];
    }
    
    
    //declare string, assign to value at indexPath from array
    //array may be made from [dictionary allKeys];
    NSString* string = [array objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //set string to textLabel of cell
    [cell.textLabel setText:string];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicked");
}


@end
