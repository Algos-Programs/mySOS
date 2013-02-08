//
//  MFile.h
//  mySOS
//
//  Created by Marco Velluto on 08/02/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFile : NSObject
+ (void)write;

+ (NSDictionary *)dictionaryWithString:(NSString *)name;

@end
