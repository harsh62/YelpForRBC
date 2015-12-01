//
//  HomeTableViewCell.m
//  YelpChallenge
//
//  Created by Harshdeep  Singh on 28/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>


@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageToBusinessWithURLString:(NSString*)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    self.imageViewBusiness.layer.cornerRadius = 5.0;
    
    __weak HomeTableViewCell *weakCell = self;
    
    [self.imageViewBusiness setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.imageViewBusiness.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
}

- (void)setImageToRatingWithURLString:(NSString*)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@""];
    
    self.imageViewRating.layer.cornerRadius = 3.0;
    
    __weak HomeTableViewCell *weakCell = self;
    
    [self.imageViewRating setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       weakCell.imageViewRating.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];
}


- (void)setImageOfReviewerWithURLString:(NSString*)urlString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@""];
    
    self.imageViewReviewer.layer.cornerRadius = 3.0;
    
    __weak HomeTableViewCell *weakCell = self;
    
    [self.imageViewReviewer setImageWithURLRequest:request
                                placeholderImage:placeholderImage
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                             weakCell.imageViewReviewer.image = image;
                                             [weakCell setNeedsLayout];
                                             
                                         } failure:nil];
}

@end
