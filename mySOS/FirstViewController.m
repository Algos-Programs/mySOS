//
//  FirstViewController.m
//  mySOS
//
//  Created by Marco Velluto on 06/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

BOOL callNumber = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//*************************
#pragma mark - Actions
//*************************


- (IBAction)pressButtonCallMe:(id)sender {
    
    [self callNumber];
}

- (IBAction)pressButtonSendMessage:(id)sender {
    callNumber = NO;
    [self sendMessage];
}

/**
    Invia un messagggio e (solo se questo è stato inviato) chiama il numero prefissato.
 */
- (IBAction)pressButtonSOS:(id)sender {
    // asserendo callNumber dico di iniziare la chiamata se il messaggio è stato inviato.
    callNumber = YES;
    [self sendMessage];
}

//*************************
#pragma mark - Calls
//*************************

/**
    Chiama un numero prefissato.
 */
- (void)callNumber {
    
    //-- Chiama il numero di telefono.
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:0248844556"]];
}

//*************************
#pragma mark - Messages
//*************************

/**
    Invia il messaggio ad un numero.
 */
- (void)sendMessage {
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = @"TEST DI PROVA APPLICAZIONE!\nCiao, sono in pericolo, aiutatemi!";
		//controller.recipients = [NSArray arrayWithObjects:@"3384865894", @"3382053386", nil];
        controller.recipients = [NSArray arrayWithObjects: @"3460602722", nil];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
        //[[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"sms:3460602722"]];
	}

}

/**
    Decido cosa fare a seconda dell'esito del messaggio.
 */
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    switch (result) {
		case MessageComposeResultCancelled:
			NSLog(@"Cancelled");
			break;
		case MessageComposeResultFailed:
			//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"Unknown Error"
            //delegate:self cancelButtonTitle:@”OK” otherButtonTitles: nil];
			//[alert show];
			//[alert release];
			break;
		case MessageComposeResultSent:
            
			NSLog(@"sent");
            if(callNumber)
                [self callNumber];
            [self.navigationController popToRootViewControllerAnimated:YES];
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
    
}
@end
