//
//  BookEntity.m
//  Bookshelf
//
//  Created by Jakub Vodak on 9/12/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import "BookEntity.h"
#import "ConnectionManager.h"
#import "Constants.h"
#import "XMLReader.h"

@implementation BookEntity

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
   
    if ([key isEqualToString:@"Id"]) {
        
        self.bookId = value;
    }
    else if ([key isEqualToString:@"New"]) {
        
        if ([value isEqualToString:@"TRUE"]) {
            
            self.bookNew = true;
        }
        else {
            
            self.bookNew = false;
        }
    }
    else {
   
        [super setValue:value forUndefinedKey:key];
    }
}


+ (NSURLConnection *)requestBooksCompletionHandler:(void (^)(NSArray *, NSError *))handler
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kDataSourceUrl]];

    ConnectionManager *connection = [[ConnectionManager alloc] initWithRequest:request];
    
    return [connection executeRequestOnSuccess:^(NSData *data) {
        
        XMLReader *reader = [[XMLReader alloc] initWithXMLData:data];
        
        reader.finishBlock = ^(NSArray *dictBooks){
    
            NSMutableArray *arr = [NSMutableArray new];
            
            for (NSDictionary *dict in dictBooks) {
                
                BookEntity *book = [[BookEntity alloc] initWithDictionary:dict];
                
                [arr addObject:book];
            }

            handler(arr, nil);
        };
        
        [reader startParsing];
    
     } failure:^(NSError *error) {
         
         handler(nil, error);
     }];
}

@end
