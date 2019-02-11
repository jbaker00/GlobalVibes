//
//  ViewController.m
//  GlobalVibes
//
//  Created by James Baker on 4/1/18.
//  Copyright © 2018 James Baker. All rights reserved.
//

#import "ViewController.h"
@import GoogleMobileAds;
#import <sys/utsname.h>


@interface ViewController () <GADBannerViewDelegate>
{
    
}

@property(nonatomic, strong) GADBannerView *bannerView;


@end

@interface ViewController ()
{
    NSMutableArray *trips;
    NSArray *scenes;
    NSArray *flags;
}

@end

@implementation ViewController

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-7871017136061682~9826313932"];
    return YES;
}

@synthesize lastOrientation;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Entering ViewController::viewDidLoad");
    
    //Call to load the google banner Ad
    [self loadGoogleAd];
    

    //Load the trips from the trip file
    trips = [self loadTripsFromFile:@"TripList"];

    NSLog(@"Exiting ViewController::viewDidLoad");

}

- (void)loadGoogleAd
{
    NSLog(@"Entering ViewController::loadGoogleAd");

    self.bannerView = [[GADBannerView alloc]
                       initWithAdSize:kGADAdSizeSmartBannerPortrait];
    
    [self addBannerViewToView:self.bannerView];
    
    //Configure GADBannerView properties
    self.bannerView.adUnitID = @"ca-app-pub-7871017136061682/4609646273";
    //self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    self.bannerView.rootViewController = self;
    
    //Load the Banner Ad
    [self.bannerView loadRequest:[GADRequest request]];
    
    //Register for the Banner events
    NSLog(@"rootViewController : %@", _bannerView.rootViewController);
    _bannerView.delegate = self;

    
    NSLog(@"Exiting ViewController::loadGoogleAd");
}

- (void)addBannerViewToView:(UIView *)bannerView
{
    NSLog(@"Entering ViewController::addBannerViewToView");

    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.bottomLayoutGuide
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
    NSLog(@"Exiting ViewController::addBannerViewToView");
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
    controller->destination = strSelectedDestination;
    controller->picture = strPicture;
    controller->destURL = strDestURL;
}

#pragma mark Table view stuff
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    strSelectedDestination = trips[indexPath.row][2];
    strPicture = trips[indexPath.row][4];
    //strDestURL = trips[indexPath.row][5];

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

#pragma GoogleAdCode
/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
    // Add adView to view and add constraints as above.  Basic Add
    //[self addBannerViewToView:self.bannerView];
    adView.alpha = 0;
    [UIView animateWithDuration:1.0 animations:^{
        adView.alpha = 1;
    }];
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}

@end
