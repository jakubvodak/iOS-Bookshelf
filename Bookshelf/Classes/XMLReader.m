//
//  XMLReader.m
//  Bookshelf
//
//  Created by Jakub Vodak on 9/15/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import "XMLReader.h"

@interface XMLReader() <NSXMLParserDelegate>

@property (nonatomic, strong) NSString *currentElement;

@property (nonatomic, strong) NSXMLParser *xmlParser;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSMutableDictionary *itemBeingParsed;

@property (nonatomic) NSInteger level;

@end

@implementation XMLReader

- (id)initWithXMLData:(NSData *)data
{
    if((self = [super init]))
    {
        _level = kSourceTreeLevelRoot;
        
        _items = [NSMutableArray new];
        
        _xmlParser = [[NSXMLParser alloc] initWithData:data];
        
        _xmlParser.delegate = self;
    }
    
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {

    if (_level == kSourceTreeLevelBook) {

        self.itemBeingParsed = [NSMutableDictionary new];
    }
    else if (_level == kSourceTreeLevelDetail) {

        self.currentElement = elementName;
    }
    
    _level++;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    self.currentElement = nil;
    
    if (_level == kSourceTreeLevelDetail) {
        
        [_items addObject:_itemBeingParsed];
    }
    
    _level--;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_level == kSourceTreeLevelDetail + 1) {
        
        [_itemBeingParsed setValue:string forKey:[_currentElement capitalizedString]];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    _finishBlock(_items);
}

- (void)startParsing
{
    [_xmlParser parse];
}

@end
