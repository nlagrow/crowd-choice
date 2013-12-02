//
//  CCFeaturedTableViewCell.m
//  CrowdChoice
//
//  Created by Nick LaGrow on 11/22/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import "CCFeaturedTableViewCell.h"

@implementation CCFeaturedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setParseObj:(PFObject *)parseObj
{
  _parseObj = parseObj;
  self.bracketTitle.text = parseObj[@"question"];
    NSLog(self.bracketTitle.text);
  [_parseObj[@"picture"] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
    if (!error) {
      UIImage *image = [UIImage imageWithData:data];
      [self.bracketImage setImage: image];
    }
  }];
}

@end
