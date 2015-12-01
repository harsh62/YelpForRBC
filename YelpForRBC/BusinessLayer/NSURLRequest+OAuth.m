//
//  NSURLRequest+OAuth.m
//  YelpAPISample
//
//  Created by Thibaud Robelain on 7/2/14.
//  Copyright (c) 2014 Yelp Inc. All rights reserved.
//

#import "NSURLRequest+OAuth.h"

#import <TDOAuth/TDOAuth.h>

/**
 OAuth credential placeholders that must be filled by each user in regards to
 http://www.yelp.com/developers/getting_started/api_access
 */
//#warning Fill in the API keys below with your developer v2 keys.
static NSString * const kConsumerKey       = @"awf5SBALrm-5zqViWu8Ajg";
static NSString * const kConsumerSecret    = @"uzQmbfV94C8yocEb13GfyVKqac8";
static NSString * const kToken             = @"AGy6LyKuNAK0rFlqI8BC63foMj7JX4Q2";
static NSString * const kTokenSecret       = @"pFCCLVoaNo1VxJy4tTtqfC1U7Iw";

@implementation NSURLRequest (OAuth)

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path {
  return [self requestWithHost:host path:path params:nil];
}

+ (NSURLRequest *)requestWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)params {
  if ([kConsumerKey length] == 0 || [kConsumerSecret length] == 0 || [kToken length] == 0 || [kTokenSecret length] == 0) {
    NSLog(@"WARNING: Please enter your api v2 credentials before attempting any API request. You can do so in NSURLRequest+OAuth.m");
  }

  return [TDOAuth URLRequestForPath:path
                      GETParameters:params
                             scheme:@"https"
                               host:host
                        consumerKey:kConsumerKey
                     consumerSecret:kConsumerSecret
                        accessToken:kToken
                        tokenSecret:kTokenSecret];
}

@end
