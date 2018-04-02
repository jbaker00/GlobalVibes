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
    NSArray *trips;
    NSArray *scenes;
    NSArray *flags;
}

@end

@implementation ViewController

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


@end
