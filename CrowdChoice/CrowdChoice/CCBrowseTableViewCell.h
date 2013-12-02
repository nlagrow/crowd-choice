//
//  CCBrowseTableViewCell.h
//  CrowdChoice
//
//  Created by Nick LaGrow on 11/22/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CCBrowseTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bracketImage;
@property (strong, nonatomic) IBOutlet UILabel *bracketTitle;
@property (strong, nonatomic) PFObject *parseObj;
@end
