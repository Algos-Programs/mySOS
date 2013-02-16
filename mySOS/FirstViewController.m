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

NSString *coordinateUrl = @"";
static CLLocation *Location = nil;

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
    
    Location = [FirstViewController findCurrentLocation];

    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[MFile dictionaryWithString:nil]];

    //-- Controllo se il dic è vuoto.
    if ([[dic allKeys]count] == 0) {
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
    
    callNumber = NO;
    SettingViewController *sc = [[SettingViewController alloc] init];
    
    if ([sc location]) {
        [self sendMessageWithNumbers:[NSArray arrayWithObject:NumberMessage1] withText:TextMessage withLocation:[FirstViewController findCurrentLocation]];
    }
    else {
        [self sendMessageWithNumbers:[NSArray arrayWithObject:NumberMessage1] withText:TextMessage withLocation:nil];
    }
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:NumberCall]]];
}

//*************************
#pragma mark - Messages
//*************************

/**
 Invia un messaggio
    Destinatari: Array
    Testo: text
    Location: se NON è nil le inserisce nel testo nel messaggio.
 */
- (void)sendMessageWithNumbers:(NSArray *)numbers withText:(NSString *)text withLocation:(CLLocation *)location {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
	if([MFMessageComposeViewController canSendText])
	{
        NSString *coordinateStr = [NSString alloc];
        if (location != nil) {
            CLLocationCoordinate2D coordinate=[location coordinate];
            coordinateStr = [coordinateStr initWithFormat:@"\nMi trovo qui: \nLatitudine: %f \nLongitudine: %f\n",coordinate.latitude, coordinate.longitude];
            NSString *googleUrl = [NSString stringWithFormat:@"\nhttps://maps.google.it/maps?saddr=%f,%f", location.coordinate.latitude, location.coordinate.longitude];

            //https://maps.google.it/maps?saddr=45.422408,9.125234
            coordinateStr = [coordinateStr stringByAppendingString:googleUrl];
        }
        else {
            coordinateStr = [coordinateStr initWithString:@""];
        }
        
#warning Inserire textMessage

        
        text = [text stringByAppendingString:coordinateStr];
        controller.body = text;
        controller.recipients = numbers;
		//[self presentModalViewController:controller animated:YES]; 
        [self presentViewController:controller animated:YES completion:nil];
        controller.messageComposeDelegate = self;
	}
    
}

- (NSString *)testURLCoordinate {
    
    CLLocationCoordinate2D start = { 34.052222, -118.243611 };
    CLLocationCoordinate2D destination = { 37.322778, -122.031944 };
    
    NSString *googleMapsURLString = [NSString stringWithFormat:@"http://maps.google.com/?saddr=%1.6f,%1.6f&daddr=%1.6f,%1.6f",
                                     start.latitude, start.longitude, destination.latitude, destination.longitude];
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapsURLString]];
    return googleMapsURLString;
}


/**
    Decido cosa fare a seconda dell'esito del messaggio.
    (Send o Cancel)
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
    
	//[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    /*
    if ([locationManager locationServicesEnabled])
    {
        //Questo metodo chiede all'utente se l'app può essere localizzata.
        [locationManager startUpdatingLocation];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    */
    if ([CLLocationManager locationServicesEnabled]) {
        //Questo metodo chiede all'utente se l'app può essere localizzata.
        [locationManager startUpdatingLocation];
        locationManager.delegate = locationManager.delegate;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    CLLocation *location = [locationManager location];
#pragma mark - aspettare più tempo perchè venga premuto il bottone ok.
    coordinateUrl  = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%1.6f,%1.6f",
                                     location.coordinate.latitude,
                                     location.coordinate.longitude];
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapsURLString]];
    return location;
}

@end

