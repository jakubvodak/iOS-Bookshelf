//
//  BaseEntity.m
//  Bookshelf
//
//  Created by Jakub Vodak on 9/13/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import "BaseEntity.h"

DictionaryToEntityKeyAdjusterBlock dictionaryToEntityKeyAdjusterBlock;

@interface BaseEntity()

@end

@implementation BaseEntity 

- (id)initWithDictionary:(NSDictionary*)dictionary
{
    if((self = [super init]))
    {
        if (dictionaryToEntityKeyAdjusterBlock) {
            
            NSMutableDictionary* editedDictionary = [[NSMutableDictionary alloc] initWithCapacity:dictionary.count];
            
            for (NSString* key in dictionary.allKeys) {
                
                NSString* capitalizedKey = dictionaryToEntityKeyAdjusterBlock(key);
                
                editedDictionary[capitalizedKey] = dictionary[key];
            }
            
            [self setValuesForKeysWithDictionary:editedDictionary];
        }
        else {
            
            [self setValuesForKeysWithDictionary:dictionary];
        }
    }
    
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // subclass implementation should set the correct key value mappings for custom keys
}


+ (void)setDictionaryToEntityKeyAdjusterBlock:(DictionaryToEntityKeyAdjusterBlock)block {
    
    dictionaryToEntityKeyAdjusterBlock = [block copy];
}

@end
