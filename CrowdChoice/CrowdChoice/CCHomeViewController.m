//
//  CCHomeViewController.m
//  CrowdChoice
//
//  Created by Nick LaGrow on 11/22/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import "CCHomeViewController.h"
#import <Parse/Parse.h>

@interface CCHomeViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *homeLogo;
@property (strong, nonatomic) IBOutlet UIImageView *featuredImage;
@property (strong, nonatomic) IBOutlet UITableView *homeTableView;

- (IBAction)navigateToBrowse:(id)sender;
@end

@implementation CCHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  [self.homeLogo setImage:[UIImage imageNamed: @"logo.png"]];
    PFQuery *query = [PFQuery queryWithClassName:@"Brackets"];
    [query orderByAscending:@"votes"];
    query.limit = 4;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved the top %d brackets.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Switch to the browse tab
- (IBAction)navigateToBrowse:(id)sender {
  self.tabBarController.selectedViewController
  = [self.tabBarController.viewControllers objectAtIndex:1];
}
@end
