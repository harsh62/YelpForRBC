//
//  FilterViewController.h
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 29/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewFiltering;

@end
