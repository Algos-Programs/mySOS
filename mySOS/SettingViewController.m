//
//  SettingViewController.m
//  mySOS
//
//  Created by Marco Velluto on 08/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.textMessageTextField.text = @"Aiuto mi sono tagliato una gamba!";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//***************************************
#pragma mark - Metodi Actions
//***************************************

//-- TextField Actions  EDITING DID END
- (IBAction)pressCallNumberTextField:(id)sender {
    self.mexNumber1TextField.text = self.callNumberTextField.text;
}

//-- TextField Actions EDITING DID BEGIN

- (IBAction)pressMexNumber1TextField:(id)sender {
}

- (IBAction)pressMexNumber2TextField:(id)sender {
}

- (IBAction)pressTextMessageTextField:(id)sender {
}

// -- Button Actions

- (IBAction)pressButtonSave:(id)sender {
    if ((![self.callNumberTextField.text isEqual: @""]) && ((![self.mexNumber1TextField.text isEqual: @""]) || (![self.mexNumber2TextField.text isEqual: @""]) || (![self.mexNumber3TextField.text isEqual: @""]))) {
        
        [MFile write];
        [MFile dictionaryWithString:nil];
    }
    else {
        [self showAlert];
    }
}


- (IBAction)pressButtonCancel:(id)sender {
    
    self.tabBarController.selectedIndex = 0;
}

//***************************************
#pragma mark - Metodi Intercettazione
//***************************************

/**
 Intercetta quando comincia a scrivere
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    int k = 9;
    if (textField == self.mexNumber1TextField) {
        int c = 9;
        //NON PUOI!
    }
}
/**
    Intercetta quando finisci di scrivere.
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
}
//***************************************
#pragma mark - Metodi Aler
//***************************************

- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Alert Title here"
                                                   message: @"Alert Message here"
                                                  delegate: self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OK",nil];
    
    alert = [alert init];
    [alert setTitle:@"Attenzione"];
    [alert setMessage:@"I campi 'call' e almeno un destinatario del messaggio sono obbligatori"];
    [alert show];
}






@end
