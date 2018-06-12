//
//  ViewController.m
//  GlobalVibes
//
//  Created by James Baker on 4/1/18.
//  Copyright © 2018 James Baker. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    
}


@end

@interface ViewController ()
{
    NSMutableArray *trips;
    NSArray *scenes;
    NSArray *flags;
}

@end

@implementation ViewController

@synthesize lastOrientation;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Entering ViewController::viewDidLoad");
    
    //Load the trips from the trip file
    trips = [self loadTripsFromFile:@"TripList"];

    NSLog(@"Exiting ViewController::viewDidLoad");

}

-(NSMutableArray*)loadTripsFromFile:(NSString*)fileName
{
    NSLog(@"Entering ViewController::loadStopsFromFile");
    
    //Load the file of the fileName
    //Set the error Variable to NIL that we will check later
    NSError *error = nil;
    //Setup the bundle so we can read the file
    NSBundle *main =[NSBundle mainBundle];
    //Setup the file name in the bundlle
    NSString *path = [main pathForResource:fileName ofType:@"txt"];
    //Load the file contents into a string
    NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    //Check for the error code to see if the file read worked
    if(nil != error)
    {
        NSLog(@"Error Resding URL with error %@", error.localizedDescription);
    }
    
    
    //Look at the contents of the file loaded into the string and parse it for the columns per row
    //Set the row seperator
    NSArray* rows = [fileContents componentsSeparatedByString:@"\n"];
    
    //counters
    int iRow = 0;
    int iColumn = 0;
    
    
    //MainArray
    NSMutableArray *rowArray = [NSMutableArray array];
    
    for (NSString *row in rows){
        {
            if(![row isEqualToString:@""])
            {
                //NSLog(@"Starting off row %i with contents %@", iRow, row);
                iRow++; //increent the row counter
                iColumn = 0;
                NSMutableArray *columnArray = [NSMutableArray array];
                
                NSArray* columns = [row componentsSeparatedByString:@","];
                for(NSString *column in columns)
                {
                    //NSLog(@"Adding information to column %i with information %@", iColumn, column);
                    iColumn++; //increment the column counter
                    [columnArray addObject:column];
                }
                
                [rowArray addObject:columnArray];
            }
            else
            {
                //NSLog(@"We found a blank line");
            }
        }
        //NSLog(@"Filled in one row in the table with %i rows and %i columns", iRow, iColumn);
    }
    //NSLog(@"Filled in all rows in the table");
    
    NSLog(@"Exiting ViewController::loadStopsFromFile");
    
    return rowArray;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *controller = [segue destinationViewController];
    controller->destination = strselectedDestination;
}

#pragma mark Table view stuff
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    strselectedDestination = trips[indexPath.row][2];

    [self performSegueWithIdentifier:@"showBooking" sender:self];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [trips count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Entering ViewController:UITAbleView cellForRowAtIndexPath");

    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    //cell.textLabel.text = @"Hello";
    if(indexPath.row)
    {
        //cell.textLabel.text = [trips objectAtIndex:indexPath.row];
        cell.textLabel.text = trips[indexPath.row][1];
        cell.imageView.image = [UIImage imageNamed:trips[indexPath.row][3]];
        //cell.imageView.image = [UIImage imageNamed:[flags objectAtIndex:indexPath.row]];
    }
    NSLog(@"Entering ViewController:UITAbleView cellForRowAtIndexPath");

    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIContentContainer protocol
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
        // Reload Amazon Ad upon rotation.
        // Important: Amazon expandable rich media ads target landscape and portrait mode separately.
        // If your app supports device rotation events, your app must reload the ad when rotating between portrait and landscape mode.
    }];
}



@end
