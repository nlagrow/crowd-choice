//
//  CCAddViewController.m
//  CrowdChoice
//
//  Created by Nick LaGrow on 11/22/13.
//  Copyright (c) 2013 nlagrow.pmarino. All rights reserved.
//

#import "CCAddViewController.h"
#import <Parse/Parse.h>

@interface CCAddViewController ()
@property (strong, nonatomic) IBOutlet UITableView *optionsTable;
@property (nonatomic, strong) NSMutableArray *bracketOptions;
@property (nonatomic, strong) NSString *placeHolder;
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
    PFObject *newEntry = [PFObject objectWithClassName:@"Brackets"];
    newEntry[@"votes"] = @0;
    newEntry[@"choices"] = self.bracketOptions;
    newEntry[@"question"] = self.questionField.text;
    NSData *imgData= UIImageJPEGRepresentation(self.mainImage.image, 0.0);
    PFFile *imageFile = [PFFile fileWithData:imgData];
    newEntry[@"picture"] = imageFile;
    [newEntry saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.placeHolder = newEntry.objectId;
            self.questionField.text = @"";
            self.mainImage.image = NULL;
            [self.bracketOptions removeAllObjects];
            [self.optionsTable reloadData];
            
            PFObject *tableStart = [PFObject objectWithClassName:self.placeHolder];
            tableStart[@"user"] = @"placeholder";
            tableStart[@"complete"] = @NO;
            tableStart[@"results"] = [NSNull null];
            [tableStart saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                self.placeHolder = @"";
                [tableStart deleteInBackground];
            }];
        }];
}

- (IBAction)addOption:(id)sender {
  UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"INPUT BELOW" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add",nil];
  alert.alertViewStyle = UIAlertViewStylePlainTextInput;
  UITextField * alertTextField = [alert textFieldAtIndex:0];
  alertTextField.keyboardType = UIKeyboardTypeDefault;
  alertTextField.placeholder = @"Enter the option name";
  [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    NSLog(@"Cancel Tapped.");
  }
  else if (buttonIndex == 1) {
    NSLog(@"Add Tapped.");
    NSLog(@"%@", [alertView textFieldAtIndex:0].text);
    [self.bracketOptions addObject:[alertView textFieldAtIndex:0].text];
    NSLog(@"%@", self.bracketOptions);
    [self.optionsTable reloadData];
  }
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
  self.questionField.placeholder = @"Enter your question";
  
  self.optionsTable.delegate = self;
  self.optionsTable.dataSource = self;
  
  self.bracketOptions = [NSMutableArray new];
  
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






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSLog(@"%d", [self.bracketOptions count]);
  return [self.bracketOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *simpleTableIdentifier = @"Cell";
  
  UITableViewCell *cell = [self.optionsTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
  }
  
  cell.textLabel.text = [self.bracketOptions objectAtIndex:indexPath.row];
  return cell;
}













@end
