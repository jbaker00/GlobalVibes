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
    
    //Output the Passed in segway variables
    NSLog(@"Destination is %@", destination);
    NSLog(@"Picture name is %@", picture);
    NSLog(@"URL is %@",destURL);

    //Set the image to the incomming image here
    //imgTrip = destination;
    _imgTrip.image = [UIImage imageNamed:picture];
    
    NSLog(@"Exiting DetailViewController::viewDidLoad");
}
- (IBAction)btnBookIt:(id)sender
{
    UIApplication *application = [UIApplication sharedApplication];
    //localisationName is a arbitrary string here
    //NSString* webName = [self->destURL stringByAddingPercentEncodingWithAllowedCharacters:NSUTF8StringEncoding];
    //NSString* stringURL = [NSString stringWithFormat:self->destURL, webName];
    //NSString* webStringURL = [stringURL stringByAddingPercentEncodingWithAllowedCharacters:NSUTF8StringEncoding];
    //NSURL* URL = [NSURL URLWithString:webStringURL];
    
    NSMutableCharacterSet *alphaNumSymbols = [NSMutableCharacterSet characterSetWithCharactersInString:@"~!@#$&*()-_+=[]:;',/?."];
    [alphaNumSymbols formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
    
    self->destURL = [self->destURL stringByAddingPercentEncodingWithAllowedCharacters:alphaNumSymbols];
    
    NSURL *URL = [NSURL URLWithString:destURL];
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)])
    {
        [application openURL:URL options:@{}
           completionHandler:^(BOOL success) {
               NSLog(@"Open %@: %d",self->destURL,success);
           }];
    }
    else
    {
        BOOL success = [application openURL:URL];
        NSLog(@"Open %@: %d",destURL,success);
    }
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
