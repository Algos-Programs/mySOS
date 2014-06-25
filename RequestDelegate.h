//
//  RequestDelegate.h
//  myWeights
//
//  Created by Marco Velluto on 21/03/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestDelegate : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong)NSString *eventCode;
@property (nonatomic, strong)NSString *eventDetails;

- (id)init;
- (id)initWithEventCode:(NSString *)aEventCode andEventDetails:(NSString *)aEventDetails;

@end
