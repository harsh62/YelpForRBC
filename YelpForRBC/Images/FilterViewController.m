//
//  FilterViewController.m
//  YelpForRBC
//
//  Created by Harshdeep  Singh on 29/11/15.
//  Copyright © 2015 Harshdeep  Singh. All rights reserved.
//

#import "FilterViewController.h"
#import "SortTableViewCell.h"
#import "SliderTableViewCell.h"

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

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
};              // Default is 1 if not implemented

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Sort By:";
            break;
            
        case 1:
            return @"Number of Results:";
            break;
            
        case 2:
            return @"Radius to Search(In Km's)";
            break;
            
        default:
            return @"";
            break;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            return 1;
            break;
            
        default:
            return 1;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 44;
            break;
            
        case 1:
            return 60;
            break;
            
        case 2:
            return 60;
            break;
            
        default:
            return 44;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}



- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
        return @"";
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = nil;
    switch (indexPath.section) {
        case 0:{
            cellIdentifier = @"SortTableViewCell";
            SortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil){
                cell = [[SortTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *currentSegmentControlValue = [userDefaults valueForKey:@"sort"];
            [cell.segmentControl setSelectedSegmentIndex:currentSegmentControlValue.integerValue];
            return cell;
            break;
        }
        case 1:{
            cellIdentifier = @"SliderTableViewCell";
            SliderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil){
                cell = [[SliderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.slider.tag = 0;
            cell.slider.maximumValue = 50;
            cell.labelSliderValue.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"numberOfResults"];
            cell.slider.value = cell.labelSliderValue.text.integerValue;

            return cell;

            break;
        }
            
        case 2:{
            cellIdentifier = @"SliderTableViewCell";
            SliderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil){
                cell = [[SliderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.slider.tag = 1;
            cell.slider.maximumValue = 10;
            cell.labelSliderValue.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"distance"];
            cell.slider.value = cell.labelSliderValue.text.integerValue;
            
            return cell;

            break;
        }
            
        default:{
            cellIdentifier = @"cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            return cell;
            break;
        }
    }
    

}


-(IBAction)cancelButtonTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)searchButtonTapped:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
