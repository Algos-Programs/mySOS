//
//  MFile.h
//  mySOS
//
//  Created by Marco Velluto on 08/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const KEY_CALL_NUMBER = @"call";
static NSString * const KEY_MEX_1_NUMBER = @"mex1";
static NSString * const KEY_MEX_2_NUMBER = @"mex2";
static NSString * const KEY_MEX_3_NUMBER = @"mex3";
static NSString * const KEY_TEXT_MESSAGE = @"textMessage";

@interface MFile : NSObject

+ (void)writeWithObject:(NSObject *)obj andKey:(NSString *)key;
+ (void)writeDictionary:(NSDictionary *)dic;

+ (NSDictionary *)dictionaryWithString:(NSString *)name;
@end
