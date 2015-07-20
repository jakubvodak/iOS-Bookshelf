//
//  BookEntity.h
//  Bookshelf
//
//  Created by Jakub Vodak on 9/12/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

@interface BookEntity : BaseEntity

@property (nonatomic, strong) NSString *bookId;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *thumbnail;

@property (nonatomic, readwrite, getter = isBookNew) BOOL bookNew;

@property (nonatomic, strong) NSString *thumbExt;

+ (NSURLConnection *)requestBooksCompletionHandler:(void (^)(NSArray* books, NSError* error))handler;

@end
