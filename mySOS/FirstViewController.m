//
//  FirstViewController.m
//  mySOS
//
//  Created by Marco Velluto on 06/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import "FirstViewController.h"
#import "Request.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize location = _location;
@synthesize locationManager = _locationManager;

BOOL callNumber = NO;

NSString *NumberCall = @"";
NSString *NumberMessage1 = @"";
NSString *NumberMessage2 = @"";
NSString *NumberMessage3 = @"";
NSString *TextMessage = @"";

NSString *coordinateUrl = @"";

- (void)viewDidLoad  //ok
{
    [super viewDidLoad];
    _location = [CLLocation alloc];
    
    [Request requestWithDomain:nil withProducerId:@"10" withEventCode:@"1" andEventDetails:@"App Opened"];
	// Do any additional setup after loading the view, typically from a nib.
    //[Request requestWithDomain:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {

    
    //Location = [FirstViewController findCurrentLocation];
    _location = [_location init];
    _locationManager = [[CLLocationManager alloc] init];
    
    
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    //[self.view setBackgroundColor:<#(UIColor *)#>]
}

- (CLLocation*)findCurrentLocation
{
    _locationManager = [[CLLocationManager alloc] init];
    
    if ([CLLocationManager locationServicesEnabled]) {
        //Questo metodo chiede all'utente se l'app può essere localizzata.
        [_locationManager startUpdatingLocation];
        _locationManager.delegate = _locationManager.delegate;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    CLLocation *location = [_locationManager location];
#pragma mark - aspettare più tempo perchè venga premuto il bottone ok.
    
    coordinateUrl = [FirstViewController googleMapsURL:location];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapsURLString]];
    return location;
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[MFile dictionaryWithString:nil]];

    //-- Controllo se il dic è vuoto.
    if ([[dic allKeys]count] == 0) {
        //
        //[SettingViewController showAlerWithMessage:@"Impostare i parametri iniziali nella schermata default"];
        [SettingViewController showAlertMainArgoments];
        self.tabBarController.selectedIndex = 1;
        
    }
    else {
        _location = [FirstViewController findCurrentLocation];
        
        NumberCall = [dic objectForKey:KEY_CALL_NUMBER];
        NumberMessage1 = [dic objectForKey:KEY_MEX_1_NUMBER];
        NumberMessage2 = [dic objectForKey:KEY_MEX_2_NUMBER];
        NumberMessage3 = [dic objectForKey:KEY_MEX_3_NUMBER];
        TextMessage = [dic objectForKey:KEY_TEXT_MESSAGE];
    }

}

//*************************
#pragma mark - Actions
//*************************


- (IBAction)pressButtonCallMe:(id)sender {
    [self callNumber];
    [Request requestWithDomain:nil withProducerId:@"10" withEventCode:@"2" andEventDetails:@"Pressed Botton Call"];
}

- (IBAction)pressButtonSendMessage:(id)sender {
    
    [Request requestWithDomain:nil withProducerId:@"10"withEventCode:@"3" andEventDetails:@"Pressed Button Send SMS"];
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
    
    
    [Request requestWithDomain:nil withProducerId:@"10" withEventCode:@"4" andEventDetails:@"Pressed Button SOS"];
    // asserendo callNumber dico di iniziare la chiamata se il messaggio è stato inviato.
    callNumber = YES;
#warning Se message2 non è nil allora invio il mex anche a quel numero.
    SettingViewController *svc = [[SettingViewController alloc] init];
    if ([svc location]) {
        [self sendMessageWithNumbers:[NSArray arrayWithObject:NumberMessage1] withText:TextMessage withLocation:[FirstViewController findCurrentLocation]];
    }
    else {
        [self sendMessageWithNumbers:[NSArray arrayWithObject:NumberMessage1] withText:TextMessage withLocation:nil];
    }
}

//*************************
#pragma mark - Alert methos
//*************************

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    int c = 9;
}

//*************************
#pragma mark - Calls Methods
//*************************

/**
    Chiama un numero prefissato.
 */
- (void)callNumber {
        
    if ([NumberCall isEqual: @""]) {
        [SettingViewController showAlertMainArgoments];
    }
    else {
        //-- Chiama il numero di telefono.
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString:NumberCall]]];
    }
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
            
            NSString *googleUrl = [[NSString alloc] initWithString:[FirstViewController googleMapsURL:location]];

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

    if ([CLLocationManager locationServicesEnabled]) {
        //Questo metodo chiede all'utente se l'app può essere localizzata.
        [locationManager startUpdatingLocation];
        locationManager.delegate = locationManager.delegate;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    CLLocation *location = [locationManager location];
#pragma mark - aspettare più tempo perchè venga premuto il bottone ok.

    coordinateUrl = [FirstViewController googleMapsURL:location];
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:googleMapsURLString]];
    return location;
}

/**
 Genera un url di google maps passata la location
 */
+ (NSString *)googleMapsURL:(CLLocation *)location {
    NSString *googleUrl = [NSString stringWithFormat:@"\nhttps://maps.google.it/maps?saddr=%f,%f", location.coordinate.latitude, location.coordinate.longitude];
    return googleUrl;
}



@end

