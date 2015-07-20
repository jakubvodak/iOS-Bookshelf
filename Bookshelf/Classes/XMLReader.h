//
//  XMLReader.h
//  Bookshelf
//
//  Created by Jakub Vodak on 9/15/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kSourceTreeLevelRoot,
    kSourceTreeLevelBook,
    kSourceTreeLevelDetail
} kSourceTreeLevel;

@interface XMLReader : NSObject

@property (nonatomic, copy) void (^finishBlock)(NSArray *dictBooks);

- (id)initWithXMLData:(NSData *)data;

- (void)startParsing;

@end
