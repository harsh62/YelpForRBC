//
//  MapViewController.m
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 30/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import "MapViewController.h"
#import "WebServiceLayer.h"
#import "Business.h"
#import "CustomOverlayView.h"


@interface MapViewController ()

@end

@implementation MapViewController{
    GMSMapView *mapView_;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:43.757454
                                                            longitude:-79.453351
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.delegate = self;
    [self.view addSubview: mapView_];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self createMapMarkersForAllBusinesses];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)listButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) createMapMarkersForAllBusinesses{
    for(Business *businessModel in [WebServiceLayer sharedInstance].arrayOfBusinesses){
        GMSMarker *marker = [[GMSMarker alloc] init];
        NSString * latitude = businessModel.location_coordinate[@"latitude"];
        NSString * longitude = businessModel.location_coordinate[@"longitude"];
        marker.position = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
        marker.title = businessModel.name;

        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.snippet = businessModel.display_phone;
        marker.map = mapView_;
    }
}

- (void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker *)marker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
//    CustomOverlayView *view =  [[[NSBundle mainBundle] loadNibNamed:@"CustomOverlayView" owner:self options:nil] objectAtIndex:0];
//    view.title.text = @"Place Name";
////    view.description.text = @"Place description";
//    view.phone.text = @"123 456 789";
//    view.imageView.image = [UIImage imageNamed:@"call"];
//    view.imageView.transform = CGAffineTransformMakeRotation(-.08);
//    return view;
//}

@end
