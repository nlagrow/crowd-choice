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
    //[self.thisOneButton setTitle:@""
      //                  forState:UIControlStateNormal];
    //[self.thatOneButton setTitle:@""
     //                   forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setParseObj:(PFObject *)parseObj
{
  _parseObj = parseObj;
    self.maxim = [parseObj[@"choices"] count];
    if (self.current > self.maxim * self.maxim * self.maxim) {
        self.current = 0;
    }
    NSLog(@"%ld", (long) self.current);
    NSLog(@"%ld", (long) self.maxim);
    NSLog(@"dog");
  [_parseObj[@"picture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
    if (!error) {
      UIImage *image = [UIImage imageWithData:data];
      [self.choiceImage setImage: image];
        self.choiceTitle.text = parseObj[@"question"];
        if (self.maxim > self.current){
            NSInteger i = self.current;
            NSLog([parseObj[@"choices"] objectAtIndex:i]);
            [self.thisOneButton setTitle:[parseObj[@"choices"] objectAtIndex:i]
                            forState:UIControlStateNormal];
        [self.thatOneButton setTitle:[parseObj[@"choices"] objectAtIndex:(i + 1)]
                          forState:UIControlStateNormal];
            NSLog(@"%ld", (long) self.current);
            NSLog(@"%ld", (long) self.maxim);
            NSLog(@"frog");
         self.current = self.current + 1;
        }
    }

  }
];
    
    
    
   // if (self.maxim > self.current) {
   //     NSLog([parseObj[@"choices"] objectAtIndex:self.current]);
  //      [self.thisOneButton setTitle:[parseObj[@"choices"] objectAtIndex:self.current]
     //                       forState:UIControlStateNormal];
  //      if ((self.current + 1) < self.maxim) {
       //     [self.thatOneButton setTitle:[parseObj[@"choices"] objectAtIndex:(self.current + 1)]
         //                       forState:UIControlStateNormal];
 //       }
  //      else {
  //          [self.thatOneButton setTitle:[parseObj[@"choices"] objectAtIndex:(self.current - 1)]
 //                               forState:UIControlStateNormal];
 //       }
   //     self.current =  self.current;
   // }
}

- (IBAction)thisOne:(id)sender {
    NSLog(@"This one");
    CCChoiceViewController *viewController = [[CCChoiceViewController alloc] initWithNibName:@"CCChoiceViewController" bundle:nil];
    viewController.parseObj = self.parseObj;
    //[self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController pushViewController:viewController animated:YES];
    
    NSArray *viewCons = self.navigationController.viewControllers;
    NSMutableArray *newCons = [[NSMutableArray alloc] init];
    [newCons addObjectsFromArray:viewCons];
    [newCons replaceObjectAtIndex:newCons.count - 1 withObject:viewController];
    
    [[self navigationController] setViewControllers:newCons];
    viewController.parseObj = self.parseObj;
    viewController.current = self.current;
     viewController.maxim = self.maxim;
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
     viewController.parseObj = self.parseObj;
    viewController.current = self.current;
    viewController.maxim = self.maxim;
}

@end
