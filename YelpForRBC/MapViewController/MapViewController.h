//
//  MapViewController.h
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 30/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;


@interface MapViewController : UIViewController <GMSMapViewDelegate>

@property (strong, nonatomic) NSString *currentLat;
@property (strong, nonatomic) NSString *currentLong;
@property (strong, nonatomic) NSArray *arrayOfBusinesses;

@end
