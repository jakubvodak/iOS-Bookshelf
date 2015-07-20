//
//  ConnectionManager.h
//  Bookshelf
//
//  Created by Jakub Vodak on 9/13/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OnSuccess) (NSData *data);
typedef void (^OnFailure) (NSError *error);

@interface ConnectionManager : NSObject

- (id)initWithRequest:(NSURLRequest *)urlRequest;

- (NSURLConnection *)executeRequestOnSuccess:(OnSuccess)onSuccessBlock failure:(OnFailure)onFailureBlock;

@end
