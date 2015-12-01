//
//  WebServiceLayer.h
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 30/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceLayer : NSObject

typedef void (^CompletionHandlerBlock) (NSMutableArray *,NSError*);

+ (WebServiceLayer *)sharedInstance;
@property (strong , nonatomic) NSMutableArray * arrayOfBusinesses;
- (void)queryTopBusinessInfoForTerm:(NSString *)term location:(NSString *)location completionHandler:(void (^)(NSMutableArray *topBusinessJSON, NSError *error))completionHandler;



@end
