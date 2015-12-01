//
//  SliderTableViewCell.m
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 29/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import "SliderTableViewCell.h"

@implementation SliderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)valueOfSliderChanged:(id)sender {
    int sliderValue;
    sliderValue = (int)lroundf(self.slider.value);
    [self.slider setValue:sliderValue animated:YES];
    self.labelSliderValue.text = [NSString stringWithFormat:@"%d",sliderValue];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if(self.slider.tag == 0){
        [userDefaults setValue:[NSString stringWithFormat:@"%d",sliderValue] forKey:@"numberOfResults"];
    }
    else if(self.slider.tag == 1){
        [userDefaults setValue:[NSString stringWithFormat:@"%d",sliderValue] forKey:@"distance"];
    }
    [userDefaults synchronize];
}

@end
