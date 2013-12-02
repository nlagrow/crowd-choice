//
//  CCBrowseViewController.m
//  CrowdChoice
//
//  Created by Nick LaGrow on 11/22/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import "CCBrowseViewController.h"
#import "CCBrowseTableViewCell.h"

@interface CCBrowseViewController ()
@property (strong, nonatomic) IBOutlet UITableView *browseTableView;
@property (nonatomic, strong) NSArray *bracketObjects;
@end

@implementation CCBrowseViewController

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
  self.browseTableView.delegate = self;
  self.browseTableView.dataSource = self;

  [self.browseTableView registerNib:[UINib nibWithNibName:@"CCBrowseTableViewCell" bundle:nil] forCellReuseIdentifier:@"CCBrowseTableViewCell"];
  
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
  static NSString *CellIdentifier = @"CCBrowseTableViewCell";
  CCBrowseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
  
  // Initially sort by number of votes
  [brackets_query orderByDescending:@"createdAt"];
  [brackets_query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    NSLog(@"hi");
    if (!error)
    {
      NSLog(@"helllooooo");
      self.bracketObjects = objects;
      NSLog(@"%@", self.bracketObjects);
    }
    [self.browseTableView reloadData];
  }];
}


@end
