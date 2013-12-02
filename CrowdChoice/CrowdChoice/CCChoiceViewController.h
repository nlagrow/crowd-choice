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
@property (strong, nonatomic) IBOutlet UIButton *thisOneButton;
@property (strong, nonatomic) IBOutlet UIButton *thatOneButton;
@property(nonatomic, assign) NSUInteger current;
@property(nonatomic, assign) NSUInteger maxim;
@property (strong, nonatomic) PFObject *parseObj;
@end
