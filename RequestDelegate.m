//
//  RequestDelegate.m
//  myWeights
//
//  Created by Marco Velluto on 21/03/13.
//  Copyright (c) 2013 algos. All rights reserved.
//

#import "RequestDelegate.h"
#import "Request.h"

@interface Request ()

/**
 @method
 Crea un evento. (Nascosta all'utente).
 
 @throws
 * se si vuole utilizzare il domain di default
 passare nil.
 * se si vuole utilizzare l'action di default
 passare nil.
 * se si vuole utilizzare l'unique id di default
 passare nil.
 */
+ (void)requestEventWithDomain:(NSString *)domain
                    withAction:(NSString *)action
                  withUniqueId:(NSString *)uniqueId
                 withEventCode:(NSString *)eventCode
              withEventDetails:(NSString *)eventDetails;

@end


@implementation RequestDelegate
@synthesize eventCode;
@synthesize eventDetails;

- (id)init {
    
    self = [super init];
    self.eventDetails = @"Detail";
    self.eventCode = @"91";
    
    return self;
}

- (id)initWithEventCode:(NSString *)aEventCode andEventDetails:(NSString *)aEventDetails {
    
    self = [super init];
    self.eventDetails = aEventDetails;
    self.eventCode = aEventCode;
    
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
        
    NSHTTPURLResponse *urlRestponse = [[NSHTTPURLResponse alloc] init];
    urlRestponse = (NSHTTPURLResponse *)response;
    
    NSDictionary * dic = [urlRestponse allHeaderFields];
    NSString *str = [dic objectForKey:@"success"];
    
    if ([str isEqualToString:@"true"]) {
        
        NSLog(@"_-_ Record Creato");
        [Request requestEventWithDomain:nil withAction:nil withUniqueId:[Request uniqueId] withEventCode:self.eventCode withEventDetails:self.eventDetails];
    }
    else {
        NSLog(@"*** Errore: Record non creato");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}
@end
