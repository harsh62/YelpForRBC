//
//  SortTableViewCell.h
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 29/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortTableViewCell : UITableViewCell
- (IBAction)segmentControl:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end
