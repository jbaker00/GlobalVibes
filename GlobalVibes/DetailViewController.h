//
//  DetailViewController.h
//  GlobalVibes
//
//  Created by James Baker on 6/10/18.
//  Copyright © 2018 James Baker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    @public NSString *destination;
    @public NSString *picture;
    @public NSString *destURL;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imgTrip;

@end
