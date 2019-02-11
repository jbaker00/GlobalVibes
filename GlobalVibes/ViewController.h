//
//  ViewController.h
//  GlobalVibes
//
//  Created by James Baker on 4/1/18.
//  Copyright © 2018 James Baker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface ViewController : UIViewController
{
    @public NSString *strSelectedDestination;
    @public NSString *strDestURL;
    @public NSString *strPicture;
    
}

@property (assign, nonatomic) UIInterfaceOrientation lastOrientation;


@end

