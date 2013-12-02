//
//  CCAddViewController.h
//  CrowdChoice
//
//  Created by Nick LaGrow on 11/22/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCAddViewController : UIViewController <UINavigationControllerDelegate,
                                                   UIImagePickerControllerDelegate,
                                                   UIActionSheetDelegate,
                                                   UITextViewDelegate,
                                                   UITextFieldDelegate,
                                                   UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *questionField;
@property (strong, nonatomic) IBOutlet UIImageView *mainImage;

- (IBAction)mainImageButton:(id)sender;

@end
