//
//  Business.h
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 28/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * image_url;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * mobile_url;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * display_phone;
@property (nonatomic, retain) NSNumber * review_count;
@property (nonatomic, retain) NSNumber * distance;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * rating_img_url;
@property (nonatomic, retain) NSString * rating_img_url_small;
@property (nonatomic, retain) NSString * rating_img_url_large;
@property (nonatomic, retain) NSString * snippet_text;
@property (nonatomic, retain) NSString * snippet_image_url;
@property (nonatomic) BOOL is_claimed;
@property (nonatomic) BOOL is_closed;
@property (nonatomic, retain) NSArray * categories;
@property (nonatomic, retain) NSArray * location_address;
@property (nonatomic, retain) NSArray * location_display_address;
@property (nonatomic, retain) NSString * location_city;
@property (nonatomic, retain) NSString * location_state_code;
@property (nonatomic, retain) NSString * location_postal_code;
@property (nonatomic, retain) NSString * location_country_code;
@property (nonatomic, retain) NSString * location_cross_streets;
@property (nonatomic, retain) NSArray * location_neighborhoods;
@property (nonatomic, retain) NSDictionary * location_coordinate;


@end
