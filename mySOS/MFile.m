//
//  MFile.m
//  mySOS
//
//  Created by Marco Velluto on 08/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import "MFile.h"
static NSString * const FILE_NAME = @"File.strings";

@implementation MFile

+ (void)write {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent: FILE_NAME];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"casa", @"CACCA", nil];
    [dic writeToFile:docFile atomically:YES];
}

+ (NSDictionary *)dictionaryWithString:(NSString *)name {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent: FILE_NAME];

    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"File" ofType:@"strings"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:docFile];
    
    return dictionary;
}


@end

