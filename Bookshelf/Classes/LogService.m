//
//  LogService.m
//  Bookshelf
//
//  Created by Jakub Vodak on 9/13/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import "LogService.h"

@implementation LogService

+ (LogService*)sharedInstance {
    
    static LogService* sharedInstance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [LogService new];
    });
    
    return sharedInstance;
}

- (void)logError:(NSError *)error {
    
    NSParameterAssert(error);
    
    NSLog(@"%@", error);
}

@end
