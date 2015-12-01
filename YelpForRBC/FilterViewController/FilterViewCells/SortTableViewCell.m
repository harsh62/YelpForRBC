//
//  SortTableViewCell.m
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 29/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import "SortTableViewCell.h"

@implementation SortTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)segmentControl:(id)sender {
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:[NSString stringWithFormat:@"%ld",(long)segmentControl.selectedSegmentIndex] forKey:@"sort"];
    [userDefaults synchronize];
}
@end
