//
//  Request.h
//  myWeights
//
//  Created by Marco Velluto on 17/12/12.
//  Copyright (c) 2012 algos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Request : NSObject 


+ (Request *)instance;

/**
    @method Esegue una request con i paramatri passati
    (Creazione Record e Creazione Evento)
 
    @param domain: Domain del sito - nil per utilizzare quello di default
    @param aEventCode - Codice dell'evento da creare (@"1" or @"128" etc)
    @param aEventDetails - Il dettaglio dell'evento da creare (@"App Opened").
 */
+ (void)requestWithDomain:(NSString *)domain withEventCode:(NSString *)aEventCode andEventDetails:(NSString *)aEventDetails;



+ (void)requestWithDomain:(NSString *)domain withProducerId:(NSString *)producerId withEventCode:(NSString *)aEventCode andEventDetails:(NSString *)aEventDetails;

/**
 Crea e restituisce un uniqueId formato da idDevice+nameApp.
 */
+ (NSString *)uniqueId;

@end
