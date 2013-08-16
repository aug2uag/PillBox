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
#import "PBResultsViewController.h"
#import "XMLReader.h"

@interface PBViewController ()
{
    NSArray*                pbArray;
    NSMutableArray*         trackArrayForReset;
    NSMutableArray*         pbResultsArray;
    PBColorsModalPanel*     pbColorPanel;
    PBSizeModalPanel*       pbSizePanel;
    PBShapeModalPanel*      pbShapePanel;
    PBTextFieldModalPanel*  pbTextPanel;
    UICustomSwitch*         pbSwitch;
    NSMutableDictionary*    pbTemplate;
    
    NSXMLParser*            rssParser;
    NSMutableDictionary*    item;
    NSString*               currentElement;
    NSMutableString*        elementValue;
    BOOL                    errorParsing;
    
    NSString*               pbAuthorString;
    NSString*               pbActiveString;
    NSString*               pbOtherString;
    NSString*               pbColorString;
    NSString*               pbShapeString;
    NSString*               pbSizeString;
    NSString*               pbQueryString;
    NSString*               pbAddressUrl;
}
- (IBAction)searchWithAction:(id)sender;
- (IBAction)resetWithAction:(id)sender;

@end

@implementation PBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"HELLO HELLO");
    
    trackArrayForReset = [[NSMutableArray alloc] init];
    
    pbArray = @[@[@"Manufacturer", @"Name/Active ingredient", @"Inactive ingredient"], @[@"Color", @"Shape", @"Size"]];
    
    pbSwitch = [[UICustomSwitch alloc] initWithFrame:CGRectMake(220.0f, 57.0f, 40.0f, 20.0f)];
    [self.view addSubview:pbSwitch];
    pbSwitch.leftLabel.text = @"ON";
    pbSwitch.rightLabel.text = @"OFF";
    
    pbAddressUrl = @"http://pillbox.nlm.nih.gov/PHP/pillboxAPIService.php?key=12345";
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

#pragma mark -delegate method
- (void)sendStringToAddToArray:(NSString *)theString
{
    
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
    NSLog(@"button clicked");
    
    pbTemplate = [[NSMutableDictionary alloc] initWithCapacity:6];
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
    } else {
        [pbTemplate setValue:@0 forKey:@"has_image"];
    }
    
    //http://pillbox.nlm.nih.gov/PHP/pillboxAPIService.php?prodcode=0078-0176&key=12345
    
    int i =0;
    int count = (int)pbTemplate.count;
    NSMutableString* queryString = [[NSMutableString alloc] initWithString:pbAddressUrl];
    for (NSString* key in pbTemplate) {
        if (i>1 && i<count+1) {
            [queryString appendString:@"&"];
        }
        if ([key isEqualToString:@"has_image"]) {
            if ([[pbTemplate valueForKey:key] intValue] == 1) {
                [queryString appendString:@"has_image = 1"];
            }
        }
        if ([key isEqualToString:@"author"]) {
            [queryString appendString:[NSString stringWithFormat:@"&author=%@", pbAuthorString]];
        }
        if ([key isEqualToString:@"ingredient"]) {
            [queryString appendString:[NSString stringWithFormat:@"&ingredient=%@", pbActiveString]];
        }
        if ([key isEqualToString:@"inactive"]) {
            [queryString appendString:[NSString stringWithFormat:@"&inactive=%@", pbOtherString]];
        }
        if ([key isEqualToString:@"color"]) {
            [queryString appendString:[NSString stringWithFormat:@"&color=%@", pbColorString]];
        }
        if ([key isEqualToString:@"shape"]) {
            [queryString appendString:[NSString stringWithFormat:@"&shape=%@", pbShapeString]];
        }
        if ([key isEqualToString:@"size"]) {
            [queryString appendString:[NSString stringWithFormat:@"&size=%@", pbSizeString]];
        }
        i++;
        
        pbQueryString = queryString;
        NSLog(@"pbQuerytString => %@", pbQueryString);
        [self parseXMLFileAtURL:pbQueryString];
        
        return;
        
    }
}

- (IBAction)resetWithAction:(id)sender
{
    pbAuthorString = nil;
    pbActiveString = nil;
    pbOtherString = nil;
    pbColorString = nil;
    pbShapeString = nil;
    pbSizeString = nil;
    pbQueryString = nil;
    pbAddressUrl = nil;
    pbTemplate = nil;
    
    [self.oTableView reloadData];
    
    [self viewDidLoad];
    
}


- (void)parseXMLFileAtURL:(NSString *)URL
{
    NSLog(@"parse xml");
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(self.view.center.x - indicator.bounds.size.width, self.view.center.y - indicator.bounds.size.height, indicator.bounds.size.width, indicator.bounds.size.height);
    [self.view addSubview:indicator];
    [indicator startAnimating];
    NSData* results = [NSURLConnection sendSynchronousRequest:request returningResponse:0 error:nil];
    [indicator stopAnimating];
    
    //    NSString* resultString = [[NSString alloc] initWithData:results encoding:NSUTF8StringEncoding];
    //    NSLog(@"stringResult => %@", resultString);
    
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLData:results];
    //NSLog(@" %@", xmlDictionary);
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:xmlDictionary
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"jsonString\n\n%@",jsonString);
    }
    
    //[self performSegueWithIdentifier:@"toResults" sender:self];
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
    
    
    errorParsing=YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //    if ([segue.identifier isEqualToString:@"toResults"]) {
    //        PBResultsViewController* resultsVC = [segue destinationViewController];
    //        resultsVC.pbResultsArray =
    //    }
}

@end
