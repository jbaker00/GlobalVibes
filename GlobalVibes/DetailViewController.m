//
//  DetailViewController.m
//  GlobalVibes
//
//  Created by James Baker on 6/10/18.
//  Copyright © 2018 James Baker. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Entering DetailViewController::viewDidLoad");
    
    // Do any additional setup after loading the view.
    
    //Set the image to the incomming image here
    //imgTrip = destination;
    NSLog(@"Exiting DetailViewController::viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
