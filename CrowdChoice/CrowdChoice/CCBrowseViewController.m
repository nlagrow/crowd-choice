//
//  CCBrowseViewController.m
//  CrowdChoice
//
//  Created by Nick LaGrow on 11/22/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import "CCBrowseViewController.h"
#import "CCBrowseTableViewCell.h"
#import "CCBracketViewController.h"
#import <Parse/Parse.h>

@interface CCBrowseViewController ()
@property (strong, nonatomic) IBOutlet UITableView *browseTableView;
@property (nonatomic, strong) NSArray *bracketObjects;
@property (nonatomic, assign) BOOL top;
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
    self.top = YES;
  self.browseTableView.delegate = self;
  self.browseTableView.dataSource = self;

  [self.browseTableView registerNib:[UINib nibWithNibName:@"CCBrowseTableViewCell" bundle:nil] forCellReuseIdentifier:@"CCBrowseTableViewCell"];
  
  [self loadObjects];
    
}
- (IBAction)switchSort:(id)sender {
    self.top = !(self.top);
    if (self.top) {
        PFQuery *brackets_query = [PFQuery queryWithClassName:@"Brackets"];
        
        // Initially sort by number of votes
        [brackets_query orderByDescending:@"votes"];
        [brackets_query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSLog(@"hi");
            if (!error)
            {
                NSLog(@"helllooooo");
                self.bracketObjects = objects;
                NSLog(@"%ld", (long)self.bracketObjects.count);
            }
            [self.browseTableView reloadData];
        }];
    }
    else {
        PFQuery *brackets_query = [PFQuery queryWithClassName:@"Brackets"];
        
        // Initially sort by number of votes
        [brackets_query orderByDescending:@"createdAt"];
        [brackets_query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSLog(@"hi");
            if (!error)
            {
                NSLog(@"helllooooo");
                self.bracketObjects = objects;
                NSLog(@"%ld", (long)self.bracketObjects.count);
            }
            [self.browseTableView reloadData];
        }];
    }
}

-(void) viewDidAppear:(BOOL)animated
{
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
  [brackets_query orderByDescending:@"votes"];
  [brackets_query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    NSLog(@"hi");
    if (!error)
    {
      NSLog(@"helllooooo");
      self.bracketObjects = objects;
      NSLog(@"%ld", (long)self.bracketObjects.count);
    }
    [self.browseTableView reloadData];
  }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Initialize new viewController
    CCBracketViewController *viewController = [[CCBracketViewController alloc] initWithNibName:@"CCBracketViewController" bundle:nil];
    viewController.parseObj = [self.bracketObjects objectAtIndex:indexPath.row];
    
    //Pass selected value to a property declared in NewViewController
    //viewController.valueToPrint = selectedValue;
    //Push new view to navigationController stack
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
