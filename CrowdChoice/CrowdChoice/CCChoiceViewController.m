//
//  CCChoiceViewController.m
//  CrowdChoice
//
//  Created by Nick LaGrow on 12/2/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import "CCChoiceViewController.h"

@interface CCChoiceViewController ()

@end

@implementation CCChoiceViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setParseObj:(PFObject *)parseObj
{
  _parseObj = parseObj;
  
  [_parseObj[@"picture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
    if (!error) {
      self.choiceTitle.text = parseObj[@"question"];
      [self.thisOneButton setTitle:@"This One"
                          forState:UIControlStateNormal];
      [self.thatOneButton setTitle:@"That One"
                          forState:UIControlStateNormal];
      UIImage *image = [UIImage imageWithData:data];
      [self.choiceImage setImage: image];
    }
  }];
}
- (IBAction)thisOne:(id)sender {
  NSLog(@"This one");
  CCChoiceViewController *viewController = [[CCChoiceViewController alloc] initWithNibName:@"CCChoiceViewController" bundle:nil];
  viewController.parseObj = self.parseObj;
  [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)thatOne:(id)sender {
  NSLog(@"That one");
  CCChoiceViewController *viewController = [[CCChoiceViewController alloc] initWithNibName:@"CCChoiceViewController" bundle:nil];
  viewController.parseObj = self.parseObj;
  //[self.navigationController popViewControllerAnimated:YES];
  //[self.navigationController pushViewController:viewController animated:YES];
  
  NSArray *viewCons = self.navigationController.viewControllers;
  NSMutableArray *newCons = [[NSMutableArray alloc] init];
  [newCons addObjectsFromArray:viewCons];
  [newCons replaceObjectAtIndex:newCons.count - 1 withObject:viewController];
  
  [[self navigationController] setViewControllers:newCons];
}

@end
