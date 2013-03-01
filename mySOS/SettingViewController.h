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
#import <AddressBook/AddressBook.h>

@interface SettingViewController : UIViewController <UITextFieldDelegate, UITabBarControllerDelegate, UITabBarDelegate, UIAlertViewDelegate>

@property (nonatomic) BOOL liteVersion;
@property (nonatomic) BOOL location;

//-- TextField Outlet
@property (weak, nonatomic) IBOutlet UITextField *callNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *mexNumber1TextField;
@property (weak, nonatomic) IBOutlet UITextField *mexNumber2TextField;
@property (weak, nonatomic) IBOutlet UITextField *mexNumber3TextField;
@property (weak, nonatomic) IBOutlet UITextField *textMessageTextField;


//-- Switch Localizzazione
@property (weak, nonatomic) IBOutlet UISwitch *switchLocalization;
- (IBAction)beginEditingLocaization:(id)sender;
- (IBAction)touchUpInsideSwitchLocalization:(id)sender;

//-- TextField Actions  EDITING DID END
- (IBAction)pressCallNumberTextField:(id)sender;

//-- TextField Actions EDITING DID BEGIN
- (IBAction)pressMexNumber1TextField:(id)sender;
- (IBAction)pressMexNumber2TextField:(id)sender;
- (IBAction)pressTextMessageTextField:(id)sender;

//-- TextField Did Change
- (IBAction)didChangeCallNumberTextField:(id)sender;

//-- Button Actions
- (IBAction)pressButtonSave:(id)sender;
- (IBAction)pressButtonCancel:(id)sender;

/**
 Abbassa la tastiera quando clicco sulla view.
 */
- (IBAction)gestureClouseKeyBoard:(id)sender;

/**
    Mostra un alert Normale
 */
+ (void)showAlert;

/**
    Mostra un alert con titolo: Attenzione!
    con i pulsanti di default Cancel e OK
    e col messaggio desiderato.
 */
+ (void)showAlerWithMessage:(NSString *)message;

/**
    Mostra un alert con titolo e messaggio desiderato
    con i pulsanti di default Cancel e OK.
 */
+ (void)showAlerWithTitle:(NSString *)title withMessage:(NSString *)message;

/**
    Mostra un alert con titolo e messaggio desiderato
    con un solo pulsante OK.
 */
+ (void)showAlertSingleButtonWithTitle:(NSString *)title withMessage:(NSString *)message;

/**
    Mostra un alert apposta per la versione free
    titolo: Attenzione Versione free!
    message: Se vuoi cambiarlo fai l'aggiornamento a 0.79 €.
    buttons: Cancel e OK.
 */
+ (void)showAlertFreeVersion;

/**
    Mostra un alert quando non i paramentri iniziali non sono inseriti.
    titolo: Attenzione
    message: Impostare i parametri iniziali nella schermata default    
    buttons: OK.
 */
+ (void)showAlertMainArgoments;

@end
