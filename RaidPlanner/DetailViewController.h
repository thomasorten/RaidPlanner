//
//  DetailViewController.h
//  RaidPlanner
//
//  Created by Thomas Orten on 6/4/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
