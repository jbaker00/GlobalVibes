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
    NSArray *trips;
    NSArray *scenes;
    NSArray *flags;
}

@end

@implementation ViewController

@synthesize lastOrientation;

- (void)viewDidLoad {
    [super viewDidLoad];
    /*// Do any additional setup after loading the view, typically from a nib.
    trips = [NSArray arrayWithObjects:@ "Group cruise to Bermuda",
             @"Group land vacation to Playa Del Carmen",
             @"Group Disney Cruise to Caribbean",
             @"Group cruise to Bahama",
             @"Group land vacation to Thailand",
             @"Group cruise to Mediterranean",
             @"Group land vacation to Honolulu",
             @"Jamican Vacation",
             @"Fiji Vacation",
             @"Ft Lauderdale Vacation",
             @"Los Cabos, Mexico Vacation",
             @"Santa Barbara California Vacation",
             @"Mykonos, Greece Vacation",
             @"Riviera Maya, Mexico Vacation",
             @"Indonesia Vacation",
             @"Nassau Paradise Island, Bahamas Vacation",
             @"St. Vincent & the Grenadines Vacation",
             @"Ibiza, Spain",
             @"Orlando, Florida Vacation",
             @"Cambodia Vacation",
             nil];
        //@"Iceland Vacation",@"Paris, France Vacation",@"New Orleans, Louisiana Vacation",@"London, England Vacation",@" Rome, Italy Vacation",nil];
    scenes = [NSArray arrayWithObjects:@"1-BrumudaScene.jpeg",@"2-PlayaDelCarmenScene.jpeg",@"3-DisneyCruiseScene.jpeg",@"4-BahamaScene.jpeg",@"5-ThailandScene.jpeg",@"6-MediterraneanScene.jpeg",@"7-HawaiiScene.jpeg",nil];
    flags = [NSArray arrayWithObjects:@"1-BermudaFlag.jpeg",
             @"2-PlayaDelCarmenFlag.jpeg",
             @"3-DisneyFlag.jpeg",
             @"4-BahamasFlag.jpeg",
             @"5-ThailandFlag.jpeg",
             @"6-MediterraneanFlag.jpeg",
             @"7-HawaiiFlag.jpeg",
             @"8-JamicaFlag.jpeg",
             @"9-FijiFlag.jpeg",
             @"10-FlordiaFlag.jpeg",
             @"11-LosCabosFlag.jpeg",
             @"12-SantaBarbraFlag.jpeg",
             @"13-GreeceFlag.jpeg",
             @"14-RivieraMayaFlag.jpeg",
             @"15-IndonesiaFlag.jpeg",
             @"16-NassauFlag.jpeg",
             @"17-StVincentTheGrenadinesFlag.jpeg",
             @"18-IbizaFlag.jpeg",
             @"19-FloridaFlag.jpeg",
             @"20-CambodiaFlag.jpeg",
             nil];*/
    NSMutableArray *tripsList = [self loadTripsFromFile:@"BusListSrc"];  
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showBooking" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [trips count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [trips objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[flags objectAtIndex:indexPath.row]];
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
