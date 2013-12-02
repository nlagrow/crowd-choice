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
      self.choiceLabel1.text = @"This one";
      self.choiceLabel2.text = @"That one";
      UIImage *image = [UIImage imageWithData:data];
      [self.choiceImage setImage: image];
    }
  }];
}

@end