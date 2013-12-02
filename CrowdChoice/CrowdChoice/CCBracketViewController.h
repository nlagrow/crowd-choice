//
//  CCBracketViewController.h
//  CrowdChoice
//
//  Created by Nick LaGrow on 12/2/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CCBracketViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *bracketQuestionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *bracketImage;
@property (strong, nonatomic) IBOutlet UILabel *bracketVotesLabel;

@property (strong, nonatomic) PFObject *parseObj;
@end
