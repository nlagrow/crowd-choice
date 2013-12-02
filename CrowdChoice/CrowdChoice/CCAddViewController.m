//
//  CCAddViewController.m
//  CrowdChoice
//
//  Created by Nick LaGrow on 11/22/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import "CCAddViewController.h"

@interface CCAddViewController ()

@end

@implementation CCAddViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (IBAction)saveBracket:(UIButton *)sender {
    //create a new class in parse.
    //create a new entry in the brackets table.
    
}

- (IBAction)pickPhoto:(UIButton *)sender
{
  // If the device does not have a camera, there is no reason to give the user an option.
  if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [self presentImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    return;
  }
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Photo Picker"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"Photo Library", @"Take Photo", nil];
  [actionSheet showInView:self.view];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  // Set delegates so we can hide the keyboard
  self.questionField.delegate = self;
  
  self.mainImage.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
  if([text isEqualToString:@"\n"]) {
    [textView resignFirstResponder];
    return NO;
  }
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
  [aTextField resignFirstResponder];
  return YES;
}

- (void)presentImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  imagePickerController.delegate = self;
  imagePickerController.sourceType = sourceType;
  imagePickerController.allowsEditing = YES;
  [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
  // do nothing if the user cancels
  if (buttonIndex == actionSheet.cancelButtonIndex) {
    return;
  }
  [self presentImagePickerForSourceType:(buttonIndex == 0) ? UIImagePickerControllerSourceTypePhotoLibrary :
   UIImagePickerControllerSourceTypeCamera];
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
  // no-op
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  self.mainImage.image = [info objectForKey:UIImagePickerControllerEditedImage];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end




/*- (void)presentImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  imagePickerController.delegate = self;
  imagePickerController.sourceType = sourceType;
  imagePickerController.allowsEditing = YES;
  [self presentViewController:imagePickerController animated:YES completion:nil];
}



- (IBAction)pickPhoto:(UIButton *)sender
{
  // If the device does not have a camera, there is no reason to give the user an option.
  if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [self presentImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    return;
  }
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Photo Picker"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"Photo Library", @"Take Photo", nil];
  [actionSheet showInView:self.view];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
  // do nothing if the user cancels
  if (buttonIndex == actionSheet.cancelButtonIndex) {
    return;
  }
  [self presentImagePickerForSourceType:(buttonIndex == 0) ? UIImagePickerControllerSourceTypePhotoLibrary :
   UIImagePickerControllerSourceTypeCamera];
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
  // no-op
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  self.imageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end*/