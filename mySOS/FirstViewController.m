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
BOOL changeView = NO;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //-- Controllo se ci sono già inseriti i dati.

    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[MFile dictionaryWithString:nil]];
    if ([[dic objectForKey:KEY_CALL_NUMBER] isEqual: @""] & [[dic objectForKey:KEY_MEX_1_NUMBER] isEqual: @""] & [[dic objectForKey:KEY_TEXT_MESSAGE] isEqual: @""]) {
        
        [SettingViewController showAlerWithMessage:@"Impostare i parametri iniziali nella schermata default"];
        changeView = YES;
    }
    
    //_____
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    if(changeView)
        self.tabBarController.selectedIndex = 1;
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
    callNumber = NO;
    [self sendMessageWithNumbers:[NSArray arrayWithObject:@"3460602722"] withText:@"Aiuto mi sono tagliato una gamba" withLocation:[FirstViewController findCurrentLocation]];
    //[self sendMessage];
}

/**
    Invia un messagggio e (solo se questo è stato inviato) chiama il numero prefissato.
 */
- (IBAction)pressButtonSOS:(id)sender {
    // asserendo callNumber dico di iniziare la chiamata se il messaggio è stato inviato.
    callNumber = YES;
    [self sendMessageWithNumbers:[NSArray arrayWithObject:@"3460602722"] withText:@"Aiuto mi sono tagliato una gamba" withLocation:[FirstViewController findCurrentLocation]];
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
        controller.recipients = [NSArray arrayWithObjects: @"3460602722", nil];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
        //[[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"sms:3460602722"]];
	}
    
}

- (void)sendMessageWithNumbers:(NSArray *)numbers {
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
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
		controller.body = @"TEST DI PROVA APPLICAZIONE!\nCiao, sono in pericolo, aiutatemi!\nMi trovo qui %i, %i";
		//controller.recipients = [NSArray arrayWithObjects:@"3384865894", @"3382053386", nil];
        controller.recipients = [NSArray arrayWithObjects: @"3460602722", nil];
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

+ (CLLocation*)findCurrentLocation
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    if ([locationManager locationServicesEnabled])
    {
        //locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
    }
    CLLocation *location = [locationManager location];
    
    return location;
}
@end

