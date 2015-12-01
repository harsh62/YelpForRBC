//
//  HomeTableViewCell.h
//  YelpChallenge
//
//  Created by Harshdeep  Singh on 28/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelBusinessName;
@property (weak, nonatomic) IBOutlet UILabel *labelDisplayAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelReviewCount;
@property (weak, nonatomic) IBOutlet UILabel *labelReview;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBusiness;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewRating;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewReviewer;

- (void)setImageToBusinessWithURLString:(NSString*)urlString;
- (void)setImageToRatingWithURLString:(NSString*)urlString;
- (void)setImageOfReviewerWithURLString:(NSString*)urlString;



@end
