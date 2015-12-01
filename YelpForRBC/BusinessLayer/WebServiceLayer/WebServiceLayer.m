//
//  WebServiceLayer.m
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 30/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import "WebServiceLayer.h"
#import "NSURLRequest+OAuth.h"
#import "Business.h"


@implementation WebServiceLayer

/**
 Default paths and search terms used in this example
 */
static NSString * const kAPIHost           = @"api.yelp.com";
static NSString * const kSearchPath        = @"/v2/search/";
static NSString * const kBusinessPath      = @"/v2/business/";
static NSString * const kSearchLimit       = @"10";

+ (WebServiceLayer*)sharedInstance {
    
    static WebServiceLayer *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[self alloc]init];
        [sharedInstance initializeInterfaceServices];
        
    });
    
    return sharedInstance;
}

- (void)initializeInterfaceServices {
    self.arrayOfBusinesses = [[NSMutableArray alloc] init];
}

- (void)queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location completionHandler:(void (^)(NSMutableArray *topBusinessJSON, NSError *error))completionHandler {
    
    NSLog(@"Querying the Search API with term \'%@\' and location \'%@'", term, location);
    
    //Make a first request to get the search results with the passed term and location
    NSURLRequest *searchRequest = [self _searchRequestWithTerm:term location:location];
    //    NSLog(@"%@",[searchRequest.URL valueForKey:@"urlString"]);
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (!error && httpResponse.statusCode == 200) {
            
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSArray *businessArray = searchResponseJSON[@"businesses"];
            
            if ([businessArray count] > 0) {
                [self.arrayOfBusinesses removeAllObjects];
                for(NSDictionary *dictionary in businessArray){
                    Business *businessModel = [[Business alloc] init];
                    businessModel.id = dictionary[@"id"];
                    businessModel.name = dictionary[@"name"];
                    businessModel.image_url = dictionary[@"image_url"];
                    businessModel.url = dictionary[@"url"];
                    businessModel.mobile_url = dictionary[@"mobile_url"];
                    businessModel.phone = dictionary[@"phone"];
                    businessModel.display_phone = dictionary[@"display_phone"];
                    businessModel.review_count = dictionary[@"review_count"];
                    businessModel.distance = dictionary[@"distance"];
                    businessModel.rating = dictionary[@"rating"];
                    businessModel.rating_img_url = dictionary[@"rating_img_url"];
                    businessModel.rating_img_url_large = dictionary[@"rating_img_url_large"];
                    businessModel.rating_img_url_small = dictionary[@"rating_img_url_small"];
                    businessModel.snippet_text = dictionary[@"snippet_text"];
                    businessModel.snippet_image_url = dictionary[@"snippet_image_url"];
                    businessModel.is_claimed = dictionary[@"is_claimed"];
                    businessModel.is_closed = dictionary[@"is_closed"];
                    businessModel.categories = dictionary[@"categories"];
                    businessModel.location_address = dictionary[@"location"][@"address"];
                    businessModel.location_display_address = dictionary[@"location"][@"display_address"];
                    businessModel.location_city = dictionary[@"location"][@"city"];
                    businessModel.location_state_code = dictionary[@"location"][@"state_code"];
                    businessModel.location_postal_code = dictionary[@"location"][@"postal_code"];
                    businessModel.location_country_code = dictionary[@"location"][@"country_code"];
                    businessModel.location_cross_streets = dictionary[@"location"][@"cross_streets"];
                    businessModel.location_neighborhoods = dictionary[@"location"][@"neighborhoods"];
                    businessModel.location_coordinate = dictionary[@"location"][@"coordinate"];
                    [self.arrayOfBusinesses addObject:businessModel];
                }
                
                completionHandler(self.arrayOfBusinesses,error);
            } else {
                completionHandler(nil, error); // No business was found
            }
        } else {
            completionHandler(nil, error); // An error happened or the HTTP response is not a 200 OK
        }
    }] resume];
}

- (void)queryBusinessInfoForBusinessId:(NSString *)businessID completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:businessID];
    [[session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            completionHandler(businessResponseJSON, error);
        } else {
            completionHandler(nil, error);
        }
    }] resume];
    
}

#pragma mark - API Request Builders

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param location The location request, e.g: San Francisco, CA
 
 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term location:(NSString *)location {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *radius = [userDefaults valueForKey:@"distance"];
    
    NSDictionary *params = @{
                             @"term": term,
                             @"location": [userDefaults valueForKey:@"near"],
                             @"limit": [userDefaults valueForKey:@"numberOfResults"],
                             @"sort" : [userDefaults valueForKey:@"sort"],
                             //                             @"radius_filter" : [NSString stringWithFormat:@"%ld",radius.integerValue * 1000],
                             @"cc" : @"CA"
                             };
    
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}

/**
 Builds a request to hit the business endpoint with the given business ID.
 
 @param businessID The id of the business for which we request informations
 
 @return The NSURLRequest needed to query the business info
 */
- (NSURLRequest *)_businessInfoRequestForID:(NSString *)businessID {
    
    NSString *businessPath = [NSString stringWithFormat:@"%@%@", kBusinessPath, businessID];
    return [NSURLRequest requestWithHost:kAPIHost path:businessPath];
}


@end
