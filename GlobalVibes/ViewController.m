//
//  ViewController.m
//  GlobalVibes
//
//  Created by James Baker on 4/1/18.
//  Copyright © 2018 James Baker. All rights reserved.
//

#import "ViewController.h"
#import <AmazonAd/AmazonAdView.h>
#import <AmazonAd/AmazonAdOptions.h>
#import <AmazonAd/AmazonAdError.h>

@interface ViewController () <AmazonAdViewDelegate>
{
    
}

@property (nonatomic, retain) AmazonAdView *amazonAdView;

@end

@interface ViewController ()
{
    NSArray *trips;
    NSArray *scenes;
    NSArray *flags;
}

@end

@implementation ViewController

@synthesize amazonAdView;
@synthesize lastOrientation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
             nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadAmazonAd];
}

- (void )loadAmazonAd
{
    if (self.amazonAdView) {
        [self.amazonAdView removeFromSuperview];
        self.amazonAdView = nil;
    }
    // Initialize Auto Ad Size View
    // const CGRect adFrame = CGRectMake(0.0f, 20.0f, [UIScreen mainScreen].bounds.size.width, 90.0f);
    //const CGRect adFrame = CGRectMake(0, self.view.frame.size.height - amazonAdView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 90.0f);
    
    NSLog(@"Bottom of screen location is %f",[UIScreen mainScreen].bounds.size.height);
    NSLog(@"Height of the ad is %f",amazonAdView.frame.size.height);
    //const CGRect adFrame = CGRectMake(0.0f, [UIScreen mainScreen].bounds.size.height - 360, [UIScreen mainScreen].bounds.size.width, 90.0f);
    const CGRect adFrame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 90, [UIScreen mainScreen].bounds.size.width, 90);
    self.amazonAdView = [[AmazonAdView alloc] initWithFrame:adFrame];
    [self.amazonAdView setHorizontalAlignment:AmazonAdHorizontalAlignmentCenter];
    [self.amazonAdView setVerticalAlignment:AmazonAdVerticalAlignmentBottom];
    
    // Register the ViewController with the delegate to receive callbacks.
    self.amazonAdView.delegate = self;
    
    //Set the ad options and load the ad
    AmazonAdOptions *options = [AmazonAdOptions options];
    options.isTestRequest = YES;
    //options.
    [self.amazonAdView loadAd:options];
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
        [self loadAmazonAd];
    }];
}

#pragma mark AmazonAdViewDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)adViewDidLoad:(AmazonAdView *)view
{
    // Add the newly created Amazon Ad view to our view.
    [self.view addSubview:view];
    NSLog(@"Ad loaded");
}

- (void)adViewDidFailToLoad:(AmazonAdView *)view withError:(AmazonAdError *)error
{
    NSLog(@"Ad Failed to load. Error code %d: %@", error.errorCode, error.errorDescription);
}

- (void)adViewWillExpand:(AmazonAdView *)view
{
    NSLog(@"Ad will expand");
    // Save orientation so when our ad collapses we can reload an ad
    // Also useful if you need to programmatically rearrange view on orientation change
    lastOrientation = [[UIApplication sharedApplication] statusBarOrientation];
}

- (void)adViewDidCollapse:(AmazonAdView *)view
{
    NSLog(@"Ad has collapsed");
    // Check for if the orientation has changed while the view disappeared.
    if (lastOrientation != [[UIApplication sharedApplication] statusBarOrientation]) {
        [self loadAmazonAd];
    }
}

@end
