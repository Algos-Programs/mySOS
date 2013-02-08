//
//  MPlist.m
//  mySOS
//
//  Created by Marco Velluto on 08/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import "MPlist.h"

@implementation MPlist

//--- lista articoli in ordine alfabetico
//--- legge dictionary
//--- crea lista articoli

+ (NSArray *)arrayFromPlistName:(NSString *)plistName {
    
    NSDictionary *dictionary = [MPlist dictionaryWithString:plistName];
    NSArray *listaOggetti = [MPlist arrayFromDictionary:dictionary];
    listaOggetti = [listaOggetti sortedArrayUsingSelector:@selector(compare:)];
    
    return listaOggetti;
}

+ (NSArray *)arrayFromDictionary:(NSDictionary *)dictionary {
    
    NSMutableArray *listaTemp = [[NSMutableArray alloc] init];
    for (id key in dictionary) {
        
        id value = [dictionary objectForKey:key];
        
        for (id riga in value) {
            
            id stringa = (NSString *)riga;
            [listaTemp addObject:stringa];
        }
    }
    return [[NSArray alloc] initWithArray:listaTemp];
}

+ (NSDictionary *)dictionaryWithString:(NSString *)name {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return dictionary;
}

+ (NSDictionary *)getDictionaryArticoliFromPlistName:(NSString *)plistName {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return dictionary;
    
}

+ (void)writeDictionary:(NSDictionary *)dictionary fromPlistName:(NSString *)plistName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[plistName stringByAppendingFormat:@".plist"]]; //3
    
    //here add elements to data file and write data to file
    [dictionary writeToFile:path atomically:YES];
}

+ (NSString *)pathPlist {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Pesi.plist"]; //3
    
    return path;
}

//LEGGE I DATI DALLA PLIST DATO IL NOME
+ (NSDictionary *)readPlistName:(NSString *)plistName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //1
    NSString *documentsDirectory = [paths objectAtIndex:0]; //2
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[plistName stringByAppendingFormat:@".plist"]]; //3
    
    NSMutableDictionary *savedStock = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    //load from savedStock example int value
    
    return savedStock;
}

#pragma  mark - Metodi di comodo

+ (NSDictionary *)createDictionaryWithObject:(NSObject *)obj andKey:(NSString *)key {
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:obj, key, nil];
    return dic;
    
    
}

/*
 - (NSArray *)listaArticoli {
 static NSString *namePlist = @"articoli";
 
 //--- legge dictionary
 NSDictionary *dictionary = [self dictionaryWithString:namePlist];
 
 //--- crea lista articoli
 NSArray *listaArticoli = [self articoliFromDictionary:dictionary];
 
 //--- ordina in modo alfabetico
 listaArticoli = [listaArticoli sortedArrayUsingSelector:@selector(compare:)];
 
 return listaArticoli;
 
 }
 */



@end
