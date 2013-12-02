//
//  CCFeaturedTableViewController.m
//  CrowdChoice
//
//  Created by Nick LaGrow on 12/2/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import "CCFeaturedTableViewController.h"
#import "CCFeaturedTableViewCell.h"
#import <Parse/Parse.h>

@interface CCFeaturedTableViewController ()
@property (nonatomic, strong) NSArray *bracketObjects;
@end

@implementation CCFeaturedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.tableView registerNib:[UINib nibWithNibName:@"CCFeaturedTableViewCell" bundle:nil] forCellReuseIdentifier:@"CCFeaturedTableViewCell"];
  
  [self loadObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
  return 90.0;
}

- (void)loadObjects
{
  PFQuery *brackets_query = [PFQuery queryWithClassName:@"Brackets"];
  [brackets_query orderByDescending:@"createdAt"];
  [brackets_query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error)
    {
      self.bracketObjects = objects;
    }
    [self.tableView reloadData];
  }];
}

@end
