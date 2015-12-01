//
//  FilterViewController.m
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 29/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)cancelButtonTapped:(id)sender {
}

- (IBAction)searchButtonTapped:(id)sender {
}

- (IBAction)cancelButtonClicked:(id)sender {
}
- (IBAction)searchButtonTapped:(id)sender {
}
@end
