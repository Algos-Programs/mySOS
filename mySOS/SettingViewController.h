//
//  SettingViewController.h
//  mySOS
//
//  Created by Marco Velluto on 08/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *callNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *mexNumber1TextField;
@property (weak, nonatomic) IBOutlet UITextField *mexNumber2TextField;
@property (weak, nonatomic) IBOutlet UITextField *mexNumber3TextField;
@property (weak, nonatomic) IBOutlet UITextField *textMessageTextField;

- (IBAction)pressButtonSave:(id)sender;
- (IBAction)pressButtonCancel:(id)sender;

@end
