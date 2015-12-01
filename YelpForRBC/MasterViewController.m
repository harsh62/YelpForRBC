//
//  MasterViewController.m
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 28/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "NSURLRequest+OAuth.h"
#import "Business.h"
#import "HomeTableViewCell.h"
#import "WebServiceLayer.h"
#import <QuartzCore/QuartzCore.h>

@interface MasterViewController ()

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    //setup Location services
    [self setupLocationServices];
    
    //Setup UI Elements
    [self setupUIElements];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
//    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;

}

-(void)viewDidAppear:(BOOL)animated{

    [self callTheGetBusinessesWebService];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setup/Initialize All UI Elements

-(void) setupUIElements{
    self.searchBar.text = @"ethiopean";
    self.locationToSearchFor = @"Toronto";
    
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.layer.borderColor = [[UIColor colorWithRed:100.0f/255.0f green:194.0f/255 blue:135.0f/255.0f alpha:1.0f] CGColor];
    
    self.arrayOfBusinesses = [[NSMutableArray alloc] init];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//          NSIndexPath *indexPath = [self.masterTableView indexPathForSelectedRow];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        
//        Business *businessModel = [self.arrayOfBusinesses objectAtIndex:indexPath.row];
//        [controller setLatitude:businessModel.location_coordinate[@"latitude"] andLongitude:businessModel.location_coordinate[@"longitude"]];
    }
}

#pragma mark - Table View


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
};              // Default is 1 if not implemented



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayOfBusinesses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = nil;
    static NSString *cellIdentifier = @"HomeTableViewCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Business *businessModel = [self.arrayOfBusinesses objectAtIndex:indexPath.row];
    cell.labelBusinessName.text = businessModel.name;
    cell.labelReviewCount.text = [NSString stringWithFormat:@"%@ %@",businessModel.review_count.integerValue>0?businessModel.review_count.stringValue : @"No", businessModel.review_count.integerValue<=1?@"Review":@"Reviews"];
    
    cell.labelDisplayAddress.text = @"";
    for(NSString *addressString in businessModel.location_display_address){
        cell.labelDisplayAddress.text = [[cell.labelDisplayAddress.text stringByAppendingString:addressString] stringByAppendingString:@" "];
    }
    cell.labelReview.text = businessModel.snippet_text;
    [cell setImageToBusinessWithURLString:businessModel.image_url];
    [cell setImageToRatingWithURLString:businessModel.rating_img_url_large];
    [cell setImageOfReviewerWithURLString:businessModel.snippet_image_url];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115.0;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
}


#pragma mark Search Bar Delegates

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
};   // called when text changes (including clear)

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self callTheGetBusinessesWebService];
    [searchBar resignFirstResponder];

};                     // called when keyboard search button pressed

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
};                     // called when cancel button pressed

-(void)showLoader{
    if(!self.loader){
        self.loader = [PQFBouncingBalls createLoaderOnView:self.view];        
        [self.loader showLoader];
        [self.masterTableView setHidden:YES];
    }
}

-(void)hideLoader{
    [self.loader removeLoader];
    [self.masterTableView setHidden:NO];
    self.loader = nil;
}


-(void) callTheGetBusinessesWebService{
    [self showLoader];
    [[WebServiceLayer sharedInstance] queryTopBusinessInfoForTerm:self.searchBar.text location:@"" completionHandler:^(NSMutableArray *arrayOfBusinesses, NSError *error) {
        
        if (error) {
            [self showAlertWithTitle:@"An error happened during the request!" andMessage:@""];
        } else if (arrayOfBusinesses) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.arrayOfBusinesses = [[NSMutableArray alloc] init];
                self.arrayOfBusinesses = arrayOfBusinesses;
                [self hideLoader];
                [self.masterTableView reloadData];
            });
        } else {
            [self showAlertWithTitle:@"No businesses found!" andMessage:@""];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideLoader];
        });
        
    }];
}

#pragma mark Location Services

-(void) setupLocationServices {
    geocoder = [[CLGeocoder alloc] init];
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.delegate = self;
    }
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    
    [self requestAlwaysAuthorization];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil&& [placemarks count] >0) {
            placemark = [placemarks lastObject];
            
            NSString *latitude, *longitude;
            
            latitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            
            NSLog(@"%@ %@",latitude,longitude);
            currentLatitude = latitude;
            currentLongitude = longitude;
            
            self.locationToSearchFor = [NSString stringWithFormat:@"%@, %@, %@, %@",placemark.subLocality,placemark.locality, placemark.administrativeArea, placemark.country];
            
            NSLog(@"%@",self.locationToSearchFor);
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:self.locationToSearchFor forKey:@"near"];
            [userDefaults synchronize];
            
            
            [self callTheGetBusinessesWebService];
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    }];
    
    // Turn off the location manager to save power.
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}

- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [locationManager requestAlwaysAuthorization];
    }
}

#pragma mark Alert View Delegates

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

#pragma mark Alert Controller

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Handel your yes please button action here
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
