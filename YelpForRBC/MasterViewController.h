//
//  MasterViewController.h
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 28/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<CoreLocation/CoreLocation.h>
#import <PQFCustomLoaders/PQFCustomLoaders.h>



@class DetailViewController;

@interface MasterViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *currentLatitude;
    NSString *currentLongitude;

}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *masterTableView;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSMutableArray *arrayOfBusinesses;
@property (strong, nonatomic) NSString *locationToSearchFor;
@property (nonatomic, strong) PQFBouncingBalls *loader;


@end

