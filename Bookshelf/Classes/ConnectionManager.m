//
//  ConnectionManager.m
//  Bookshelf
//
//  Created by Jakub Vodak on 9/13/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import "ConnectionManager.h"

@interface ConnectionManager()

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) NSMutableData *responseData;

@property (nonatomic, copy) OnSuccess onSuccess;

@property (nonatomic, copy) OnFailure onFailure;

@end

@implementation ConnectionManager

- (id)initWithRequest:(NSURLRequest *)urlRequest
{
    self = [super init];
 
    if (self) {
    
        self.request = urlRequest;
    }

    return self;
}


- (NSURLConnection *)executeRequestOnSuccess:(OnSuccess)onSuccessBlock
                                     failure:(OnFailure)onFailureBlock
{
    self.onSuccess = onSuccessBlock;
    
    self.onFailure = onFailureBlock;
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self];
    
    return connection;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc] init];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}


- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    return nil;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.onSuccess) {
     
        self.onSuccess(_responseData);
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.onFailure) {
     
        self.onFailure(error);
    }
}

@end
