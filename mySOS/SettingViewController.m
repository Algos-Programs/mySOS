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
@synthesize switchLocalization = _switchLocalization;
@synthesize liteVersion = _liteVersion;
@synthesize location = _location;

//********************************
#pragma mark - Metodi System Init
//********************************

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init {
    
    [self initLocalVariables];
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initLocalVariables];
	// Do any additional setup after loading the view.
    //[MFile writeDictionary:[NSDictionary dictionaryWithObject:@"Aiuto sono in pericolo!" forKey:KEY_TEXT_MESSAGE]];
}
- (void)viewWillAppear:(BOOL)animated {
    
    //[self clearFields];
    
#warning NON FUNZIONA

    if (_liteVersion) {
        [self.switchLocalization setEnabled:NO];
        [self.switchLocalization setOn:NO];
    }
    else
        [self.switchLocalization setOn:YES];
    
    
    if (_liteVersion) {
        NSLog(@"Free Version");
    }
    else {
        NSLog(
              @"Plus Version");
    }
     
    self.mexNumber1TextField.enabled = YES;
    self.mexNumber2TextField.enabled = YES;
    self.mexNumber3TextField.enabled = YES;
    
    [self initField];
    
}

- (void)viewDidAppear:(BOOL)animated {
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//********************************
#pragma mark - Metod Init
//********************************

- (void)initLocalVariables {
    _liteVersion = NO;
    _location = YES;
    
#ifdef LITE_VERSION
    _liteVersion = YES;
    _location = NO;
    
    NSLog (@"Lite Version");
#endif
    
}

- (void)initField {
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[MFile dictionaryWithString:nil]];
    
    //-- Call Number.
    if ([dic objectForKey:KEY_CALL_NUMBER] == nil)
        self.callNumberTextField.text = @"";
    else
        self.callNumberTextField.text = [dic objectForKey:KEY_CALL_NUMBER];
    
    //-- Mex Number 1
    if ([dic objectForKey:KEY_MEX_1_NUMBER] == nil)
        self.mexNumber1TextField.text = @"";
    else
        self.mexNumber1TextField.text = [dic objectForKey:KEY_MEX_1_NUMBER];
    
    //-- Mex Number 2
    if ([dic objectForKey:KEY_MEX_2_NUMBER] == nil) {
        self.mexNumber2TextField.text = @"";
    }
    else
        self.mexNumber2TextField.text = [dic objectForKey:KEY_MEX_2_NUMBER];
    
    //-- Text SMS
    if ([dic objectForKey:KEY_TEXT_MESSAGE] == nil) {
        self.textMessageTextField.text = @"";
    }
    else
        self.textMessageTextField.text = [dic objectForKey:KEY_TEXT_MESSAGE];
}


//***************************************
#pragma mark - Metodi Actions
//***************************************

//-- TextField Actions  EDITING DID END
- (IBAction)pressCallNumberTextField:(id)sender {
    //Quando Finisce fa qualcosa.
}

//-- TextField Actions EDITING DID BEGIN

- (IBAction)pressMexNumber1TextField:(id)sender {
    
    if (_liteVersion) {
        [SettingViewController showAlertFreeVersion];
        self.mexNumber1TextField.enabled = NO;
    }
}

- (IBAction)pressMexNumber2TextField:(id)sender {
    if (_liteVersion) {
        self.mexNumber2TextField.selected = NO;
        [SettingViewController showAlertFreeVersion];
        self.mexNumber2TextField.enabled = NO;
    }

}

- (IBAction)pressTextMessageTextField:(id)sender  {
    
    if (_liteVersion) {
        [SettingViewController showAlertFreeVersion];
        self.textMessageTextField.enabled = NO;
    }
}

/**
    Qui entra ogni volta che scrivo nel textField callNumber
 */
- (IBAction)didChangeCallNumberTextField:(id)sender {
#warning Fare sempre o solo in free mode?
    if (_liteVersion) {
        self.mexNumber1TextField.text = self.callNumberTextField.text;
    }
}

// -- Button Actions

- (IBAction)pressButtonSave:(id)sender {
    if ((![self.callNumberTextField.text isEqual: @""]) && (((![self.mexNumber1TextField.text isEqual: @""]) || (![self.mexNumber2TextField.text isEqual: @""]) || (![self.mexNumber3TextField.text isEqual: @""]))) & (![self.textMessageTextField.text isEqual:@""])) {
        
        //if ([self.switchLocalization isOn])
#warning Continuare da qui!
        
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        [mDic setObject:self.callNumberTextField.text forKey:KEY_CALL_NUMBER];
        [mDic setObject:self.mexNumber1TextField.text forKey:KEY_MEX_1_NUMBER];
        [mDic setObject:self.mexNumber2TextField.text forKey:KEY_MEX_2_NUMBER];
        [mDic setObject:self.textMessageTextField.text forKey:KEY_TEXT_MESSAGE];
        [MFile writeDictionary:mDic];
        self.tabBarController.selectedIndex = 0;
    }
    else {
        [SettingViewController showAlert];
    }
    [self keyBoardDown];
    
}


- (IBAction)pressButtonCancel:(id)sender {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[MFile dictionaryWithString:nil]];
    if ((![[dic objectForKey:KEY_CALL_NUMBER] isEqual: @""]) & (((![[dic objectForKey:KEY_MEX_1_NUMBER] isEqual: @""]) || (![[dic objectForKey:KEY_MEX_2_NUMBER] isEqual: @""])) & (![[dic objectForKey:KEY_TEXT_MESSAGE] isEqual: @""]))) {
        
        [self keyBoardDown];
        self.tabBarController.selectedIndex = 0;
    }
    else 
        [SettingViewController showAlert];
}

/**
    Abbassa la tastiera quando clicco sulla view.
 */
- (IBAction)gestureClouseKeyBoard:(id)sender {
    [self keyBoardDown];
}


- (IBAction)beginEditingLocaization:(id)sender {
    
    if (_liteVersion) {
        [self.switchLocalization setEnabled:NO];
        [SettingViewController showAlertFreeVersion];
    }
}

- (IBAction)touchUpInsideSwitchLocalization:(id)sender {
    if (_liteVersion) {
        [self.switchLocalization setEnabled:NO];
        [SettingViewController showAlertFreeVersion];
    }
}


//***************************************
#pragma mark - Metodi Intercettazione
//***************************************

/**
 Intercetta quando comincia a scrivere
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField {

}
/**
    Intercetta quando finisci di scrivere.
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
}

//***************************************
#pragma mark - Metodi Aler
//***************************************

+ (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Alert Title here"
                                                   message: @"Alert Message here"
                                                  delegate: self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OK",nil];
    
    alert = [alert init];
    [alert setTitle:@"Attenzione!"];
    [alert setMessage:@"I campi 'call' e almeno un destinatario del messaggio sono obbligatori"];
    [alert show];
}

+ (void)showAlerWithMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Attenzione!"
                                                   message: message
                                                  delegate: self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OK",nil];
    [alert show];
}

+ (void)showAlerWithTitle:(NSString *)title withMessage:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: title
                                                   message: message
                                                  delegate: self
                                         cancelButtonTitle:@"Cancel"
                                         otherButtonTitles:@"OK",nil];
    [alert show];
}

+ (void)showAlertFreeVersion {
    
    [SettingViewController showAlerWithTitle:@"Attenzione!" withMessage:@"Se vuoi cambiarlo fai l'aggiornamento a 0.79 €"];
}

//***************************************
#pragma mark - Metodi di Comodo
//***************************************

/**
 Abbassa la tastiera
 */
- (void)keyBoardDown {
    [self.callNumberTextField resignFirstResponder];
    [self.mexNumber1TextField resignFirstResponder];
    [self.mexNumber2TextField resignFirstResponder];
    [self.mexNumber3TextField resignFirstResponder];
    [self.textMessageTextField resignFirstResponder];
}

//***************************************
#pragma mark - Metodi Dictionary / File
//***************************************

/**
    Pulisce inserendo @"" per ogni campo sul Dictionary nel file
 */
- (void)clearFields {
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    [mDic setObject:@"" forKey:KEY_CALL_NUMBER];
    [mDic setObject:@"" forKey:KEY_MEX_1_NUMBER];
    [mDic setObject:@"" forKey:KEY_MEX_2_NUMBER];
    [mDic setObject:@"" forKey:KEY_TEXT_MESSAGE];
    [MFile writeDictionary:mDic];
}


@end
