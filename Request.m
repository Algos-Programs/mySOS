//
//  Request.m
//  myWeights
//
//  Created by Marco Velluto on 17/12/12.
//  Copyright (c) 2012 algos. All rights reserved.
//
/*
 
 Nome Classe: DroidActivator. (Singleton)
 
 set indirizzo ip.
 init with domanin.
 
 */
#import "Request.h"
#import "RequestDelegate.h"
#import "RequestEventDelegate.h"


@implementation Request

static NSString * const ACTION_NEW_EVENT = @"event";
static NSString * const DOMAIN_SITO = @"http://droidactivator.algos.it/da_backend/check.php";
static NSString * const ACTION_HEAD_RECORD = @"ensureactivationrecord";

static NSString * const ACTION = @"Action";
static NSString * const UNIQUE_ID = @"Uniqueid";
static NSString * const PRODUCER_ID = @"Producerid";
static NSString * const APP_NAME = @"Appname";
static NSString * const TRACK_ONLY = @"Trackingonly";
static NSString * const DEVICE_INFO = @"Deviceinfo";

static NSString * const KEY_UUID = @"KeyUUID";

//--Lazy initialization per garantire che la classe sia un Singleton
+ (Request *)instance {
    // the instance of this class is stored here
    static Request *myInstance = nil;
    
    // check to see if an instance already exists
    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
        
        // initialize variables here
    }
    // return the instance of this class
    return myInstance;
}

//TODO: REQUEST COMPLETA - Creazione nuovo record ed evento.
+ (void)requestWithDomain:(NSString *)domain
            withEventCode:(NSString *)aEventCode
          andEventDetails:(NSString *)aEventDetails {
    
    [Request requestWithDomain:domain withProducerId:nil withEventCode:aEventCode andEventDetails:aEventDetails];

}

//TODO: REQUEST COMPLETA - Creazione nuovo record ed evento.
+ (void)requestWithDomain:(NSString *)domain
           withProducerId:(NSString *)producerId
            withEventCode:(NSString *)aEventCode
          andEventDetails:(NSString *)aEventDetails {
    

    NSString *uuidStr = [Request uniqueId];
    
        if (!domain) {
        domain = DOMAIN_SITO;
    }
    if (!producerId) {
        producerId = @"9";
    }
    
    //Nome app
    NSString *nameApp = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    //-- Impostazioni Request
    NSURL *url = [NSURL URLWithString:domain];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    
    //-- INFO DEVICE
    NSString *deviceInfo = [[NSString alloc] init];
    deviceInfo = [deviceInfo stringByAppendingFormat:@"Name: %@", [[UIDevice currentDevice] name]];
    deviceInfo = [deviceInfo stringByAppendingFormat:@" - Model: %@", [[UIDevice currentDevice] model]];
    deviceInfo = [deviceInfo stringByAppendingFormat:@" -  SysName: %@", [[UIDevice currentDevice] systemName]];
    deviceInfo = [deviceInfo stringByAppendingFormat:@" - SysVer: %@", [[UIDevice currentDevice] systemVersion]];
    
    //-- Riempio la request con le informazioni
    [request setValue:@"ensureactivationrecord" forHTTPHeaderField:ACTION];
    [request setValue:uuidStr forHTTPHeaderField:UNIQUE_ID];
    [request setValue:producerId forHTTPHeaderField:PRODUCER_ID];
    [request setValue:nameApp forHTTPHeaderField:APP_NAME];

    
    [request setValue:@"true" forHTTPHeaderField:TRACK_ONLY];
    [request setValue:deviceInfo forHTTPHeaderField:DEVICE_INFO];
    
    // -- Invio Request
    RequestDelegate *delegate = [[RequestDelegate alloc] initWithEventCode:aEventCode andEventDetails:aEventDetails];
    NSURLConnection *urlConnetction = [[NSURLConnection alloc] initWithRequest:request delegate:delegate];

    if (urlConnetction) {
        NSLog(@"-_- Request Sent");
    }
    else {
        NSLog(@"****ERROR: urlConnection is NIL");
        
    }
}


/**
    Invia una request di creazione nuovo evento.
 
 *-> se si vuole utilizzare il domain di default
 passare nil.
 *-> se si vuole utilizzare l'action di default
 passare nil.
 *-> se si vuole utilizzare l'unique id di default
 passare nil.
 */
//TODO: Creazione nuovo evento, chiamato dal RequestDelegate (NB. Nascosto all'utente).
+ (void)requestEventWithDomain:(NSString *)domain
               withAction:(NSString *)action
             withUniqueId:(NSString *)uniqueId
            withEventCode:(NSString *)eventCode
         withEventDetails:(NSString *)eventDetails{
    
    
    if (domain == nil)
        domain = DOMAIN_SITO;
    
    if (action == nil)
        action = ACTION_NEW_EVENT;
    
    if (uniqueId == nil)
        uniqueId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
        
    //_---_---____---_-_-__---__---------__---___
    NSURL *url = [NSURL URLWithString:domain];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    //--- Creo un evento
    [request setValue:action forHTTPHeaderField:@"Action"];
    [request setValue:uniqueId forHTTPHeaderField:@"Uniqueid"];
    [request setValue:eventCode forHTTPHeaderField:@"Eventcode"];
    [request setValue:eventDetails forHTTPHeaderField:@"Eventdetails"];
    
    RequestEventDelegate *delegate = [[RequestEventDelegate alloc] init];
    NSURLConnection *urlConnetction = [[NSURLConnection alloc] initWithRequest:request delegate:delegate];
    
    if (urlConnetction) {
        NSLog(@"Request Event Sent");
    }
    else {
        NSLog(@"****ERROR: urlConnection is NIL");
        
    }
}

+ (NSString *)uniqueId {
    
    //-- Controllo UUID
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] init];
    userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *uuidStr = [userDefault stringForKey:KEY_UUID];
    
    if (!uuidStr) {
        //-- Creo un uuid
        uuidStr = [Request generateUuidString];
        [userDefault setObject:uuidStr forKey:KEY_UUID];
        [userDefault synchronize]; //Salvo uuid
    }
    return uuidStr;
}

+ (NSString *)uniqueIdWithName {
    
    NSString *nameApp = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    // -- ID device
    NSString *idDeviceStr = [NSString alloc];
    idDeviceStr = [idDeviceStr initWithString:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    idDeviceStr = [idDeviceStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    idDeviceStr = [idDeviceStr stringByAppendingString:nameApp];
    return idDeviceStr;
}

+ (NSString *)generateUuidString {
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    NSString *uuidStr = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    CFRelease(uuid);
    return uuidStr;
}


@end
