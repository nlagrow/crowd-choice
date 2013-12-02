//
//  CCHomeViewController.m
//  CrowdChoice
//
//  Created by Nick LaGrow on 11/22/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import "CCHomeViewController.h"
#import "CCFeaturedTableViewCell.h"
#import <Parse/Parse.h>

@interface CCHomeViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *homeLogo;
@property (strong, nonatomic) IBOutlet UIImageView *featuredImage;
@property (strong, nonatomic) IBOutlet UILabel *featuredTitle;
@property (strong, nonatomic) IBOutlet UITableView *homeTableView;

@property (nonatomic, strong) NSArray *bracketObjects;

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
  
  self.homeTableView.delegate = self;
  self.homeTableView.dataSource = self;
  
  [self.homeTableView registerNib:[UINib nibWithNibName:@"CCFeaturedTableViewCell" bundle:nil] forCellReuseIdentifier:@"CCFeaturedTableViewCell"];
  
  [self loadObjects];

  
  //CCFeaturedTableViewController *ftv_controller = [[CCFeaturedTableViewController alloc] init];
  //[self.homeTableView setDelegate:ftv_controller];
  
    PFQuery *query = [PFQuery queryWithClassName:@"Brackets"];
    [query orderByAscending:@"votes"];
    query.limit = 4;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved the top %d brackets.", objects.count);
            int count = 0;
            // Do something with the found objects
            for (PFObject *object in objects) {
              NSLog(@"%@", object.objectId);
              if (count == 0) {
                //[self.homeLogo setImage:object[@"picture"]];
                [object[@"picture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                  if (!error) {
                    UIImage *image = [UIImage imageWithData:data];
                    [self.featuredImage setImage: image];
                    [self.featuredTitle setText: object[@"question"]];
                    self.featuredTitle.backgroundColor = [UIColor blackColor];
                    self.featuredTitle.textColor = [UIColor whiteColor];
                  }
                }];

              }
              count++;
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [self.bracketObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"CCFeaturedTableViewCell";
  CCFeaturedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  cell.parseObj = [self.bracketObjects objectAtIndex:indexPath.row];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 60.0;
}

- (void)loadObjects
{
  PFQuery *brackets_query = [PFQuery queryWithClassName:@"Brackets"];
  [brackets_query orderByDescending:@"createdAt"];
  [brackets_query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    NSLog(@"hi");
    if (!error)
    {
      NSLog(@"helllooooo");
      self.bracketObjects = [objects subarrayWithRange:NSMakeRange(0, 3)];
      NSLog(@"%@", self.bracketObjects);
    }
    [self.homeTableView reloadData];
  }];
}

@end
