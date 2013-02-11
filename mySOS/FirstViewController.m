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

NSString *NumberCall = @"";
NSString *NumberMessage1 = @"";
NSString *NumberMessage2 = @"";
NSString *NumberMessage3 = @"";
NSString *TextMessage = @"";



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

- (void)viewWillAppear:(BOOL)animated {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[MFile dictionaryWithString:nil]];
    
    //-- Controllo se il dic è vuoto.
    if ([dic count]) {
        [SettingViewController showAlerWithMessage:@"Impostare i parametri iniziali nella schermata default"];
        self.tabBarController.selectedIndex = 1;
    }
    else {
        NumberCall = [dic objectForKey:KEY_CALL_NUMBER];
        NumberMessage1 = [dic objectForKey:KEY_MEX_1_NUMBER];
        NumberMessage2 = [dic objectForKey:KEY_MEX_2_NUMBER];
        NumberMessage3 = [dic objectForKey:KEY_MEX_3_NUMBER];
        TextMessage = [dic objectForKey:KEY_TEXT_MESSAGE];
    }

}

- (void)viewDidAppear:(BOOL)animated {
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];

}

//*************************
#pragma mark - Actions
//*************************


- (IBAction)pressButtonCallMe:(id)sender {
    [self callNumber];
}

- (IBAction)pressButtonSendMessage:(id)sender {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[MFile dictionaryWithString:nil]];
    
    callNumber = NO;
    [self sendMessageWithNumbers:[NSArray arrayWithObject:NumberMessage1] withText:TextMessage withLocation:[FirstViewController findCurrentLocation]];
    //[self sendMessage];
}

/**
    Invia un messagggio e (solo se questo è stato inviato) chiama il numero prefissato.
 */
- (IBAction)pressButtonSOS:(id)sender {
    
    /*
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[MFile dictionaryWithString:nil]];
    NSString *numberCall = [[NSString alloc] initWithString:[dic objectForKey:KEY_CALL_NUMBER]];
    NSString *sendMessageNumber = [[NSString alloc] initWithString:[dic objectForKey:KEY_MEX_1_NUMBER]];
    NSString *textMessage = [[NSString alloc] initWithString:[dic objectForKey:KEY_TEXT_MESSAGE]];
    
#warning Imlementare questi controlli.
    if (numberCall == nil) {
        //
    }
    if (textMessage == nil) {
        //
    }
     */
    // asserendo callNumber dico di iniziare la chiamata se il messaggio è stato inviato.
    callNumber = YES;
#warning Se message2 non è nil allora invio il mex anche a quel numero.
    [self sendMessageWithNumbers:[NSArray arrayWithObject:NumberMessage1] withText:TextMessage withLocation:[FirstViewController findCurrentLocation]];
}

//*************************
#pragma mark - Calls
//*************************

/**
    Chiama un numero prefissato.
 */
- (void)callNumber {
    
    //-- Chiama il numero di telefono.
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingFormat:NumberCall]]];
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
#warning Se message2 non è nil allora invio il mex anche a quel numero.

        controller.recipients = [NSArray arrayWithObjects: NumberMessage1, nil];
		//controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
        controller.messageComposeDelegate = self;
        //[[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"sms:3460602722"]];
	}
}

- (void)sendMessageWithText:(NSString *)text {
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
		controller.body = text;
		//controller.recipients = [NSArray arrayWithObjects:@"3384865894", @"3382053386", nil];
#warning Se message2 non è nil allora invio il mex anche a quel numero.

        controller.recipients = [NSArray arrayWithObjects: NumberMessage1, nil];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
        //[[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"sms:3460602722"]];
	}
    
}

- (void)sendMessageWithNumbers:(NSArray *)numbers {
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
#warning Inserire textMessage

		controller.body = @"TEST DI PROVA APPLICAZIONE!\nCiao, sono in pericolo, aiutatemi!";
		//controller.recipients = [NSArray arrayWithObjects:@"3384865894", @"3382053386", nil];
        controller.recipients = numbers;
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
        //[[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"sms:3460602722"]];
	}
}


- (void)sendMessageWithLocation:(CLLocation *)location {
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
#warning Inserire textMessage
        controller.body = @"TEST DI PROVA APPLICAZIONE!\nCiao, sono in pericolo, aiutatemi!\nMi trovo qui %i, %i";
        controller.body = TextMessage;
		//controller.recipients = [NSArray arrayWithObjects:@"3384865894", @"3382053386", nil];
#warning Se message2 non è nil allora invio il mex anche a quel numero.

        controller.recipients = [NSArray arrayWithObjects: NumberMessage1, nil];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
        //[[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"sms:3460602722"]];
	}
}

- (void)sendMessageWithNumbers:(NSArray *)numbers withText:(NSString *)text withLocation:(CLLocation *)location {
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
        CLLocationCoordinate2D coordinate=[location coordinate];
        
#warning Inserire textMessage

        NSString *coordinateStr = [[NSString alloc] initWithFormat:@"\nMi trovo qui: \nLongiudine: %f \nLatitudine: %f", coordinate.latitude, coordinate.longitude];
        
        text = [text stringByAppendingString:coordinateStr];
        controller.body = text;
        controller.recipients = numbers;
		[self presentModalViewController:controller animated:YES];
        controller.messageComposeDelegate = self;
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
			break;
		case MessageComposeResultSent:
            
			NSLog(@"sent Message");
            if(callNumber)
                [self callNumber];
            [self.navigationController popToRootViewControllerAnimated:YES];
			break;
		default:
			break;
	}
    
	[self dismissModalViewControllerAnimated:YES];
    
}

//*************************
#pragma mark - Location
//*************************

/**
    Restituisce la localizzazione attuale.
 */
+ (CLLocation*)findCurrentLocation
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    if ([locationManager locationServicesEnabled])
    {
        //Questo metodo chiede all'utente se l'app può essere localizzata.
        [locationManager startUpdatingLocation];
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    CLLocation *location = [locationManager location];
#pragma mark - aspettare più tempo perchè venga premuto il bottone ok.
    return location;
}
@end

