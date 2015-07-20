//
//  BaseEntity.h
//  Bookshelf
//
//  Created by Jakub Vodak on 9/13/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString* (^DictionaryToEntityKeyAdjusterBlock)(NSString* key);

@interface BaseEntity : NSObject

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
