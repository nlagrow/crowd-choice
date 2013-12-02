//
//  CCChoiceViewController.h
//  CrowdChoice
//
//  Created by Nick LaGrow on 12/2/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CCChoiceViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *choiceTitle;
@property (strong, nonatomic) IBOutlet UIImageView *choiceImage;
@property (strong, nonatomic) IBOutlet UILabel *choiceLabel1;
@property (strong, nonatomic) IBOutlet UILabel *choiceLabel2;

@property (strong, nonatomic) PFObject *parseObj;
@end
