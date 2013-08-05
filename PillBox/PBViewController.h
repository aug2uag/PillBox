//
//  ViewController.h
//  PillBox
//
//  Created by Reza Fatahi on 8/3/13.
//  Copyright (c) 2013 Rex Fatahi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBPopupDelegate.h"
#import "PBColorsModalPanel.h"

@interface PBViewController : UIViewController <PBPopupDelegate, UAModalPanelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *oTableView;

@end
