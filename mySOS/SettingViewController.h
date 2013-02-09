//
//  SettingViewController.h
//  mySOS
//
//  Created by Marco Velluto on 08/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFile.h"
#import "AppDelegate.h"
@interface SettingViewController : UIViewController <UITextFieldDelegate>

//-- TextField Outlet
@property (weak, nonatomic) IBOutlet UITextField *callNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *mexNumber1TextField;
@property (weak, nonatomic) IBOutlet UITextField *mexNumber2TextField;
@property (weak, nonatomic) IBOutlet UITextField *mexNumber3TextField;
@property (weak, nonatomic) IBOutlet UITextField *textMessageTextField;

//-- TextField Actions  EDITING DID END
- (IBAction)pressCallNumberTextField:(id)sender;

//-- TextField Actions EDITING DID BEGIN
- (IBAction)pressMexNumber1TextField:(id)sender;
- (IBAction)pressMexNumber2TextField:(id)sender;
- (IBAction)pressTextMessageTextField:(id)sender;

//-- Button Actions
- (IBAction)pressButtonSave:(id)sender;
- (IBAction)pressButtonCancel:(id)sender;

@end
