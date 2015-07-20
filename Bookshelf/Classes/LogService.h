//
//  LogService.h
//  Bookshelf
//
//  Created by Jakub Vodak on 9/13/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogService : NSObject

+ (LogService*)sharedInstance;

- (void)logError:(NSError*)error;

@end
