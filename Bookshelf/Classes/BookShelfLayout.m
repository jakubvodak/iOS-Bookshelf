//
//  BookShelfLayout.m
//  Bookshelf
//
//  Created by Jakub Vodak on 9/12/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import "BookShelfLayout.h"
#import "ShelfDecorationView.h"

@interface BookShelfLayout()

@property (nonatomic, strong) NSDictionary *shelfFrames;

@end

@implementation BookShelfLayout

- (id)init
{
    if (!(self = [super init])) {
        
        return nil;
    }

    /* Layout properties */
    
    self.sectionInset = UIEdgeInsetsMake(10, 50, 0, 50);

    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.minimumLineSpacing = 15;
    
    self.minimumInteritemSpacing = 50;
    
    self.itemSize = (CGSize) {80, 135};

    [self registerClass:[ShelfDecorationView class] forDecorationViewOfKind:[ShelfDecorationView kind]];
    
    
    return self;
}


#pragma mark Layout Setup

- (void)prepareLayout
{
    [super prepareLayout];
    
    [self prepareShelfFrameLayouts];
}


- (void)prepareShelfFrameLayouts
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    CGFloat y = 0;
    
    CGFloat availableWidth = self.collectionViewContentSize.width - (self.sectionInset.left + self.sectionInset.right);
    
    NSInteger itemsAcross = floorf((availableWidth + self.minimumInteritemSpacing) / (self.itemSize.width + self.minimumInteritemSpacing));
    
    
    /* Compute Y offset for shelf */
    
    y += self.headerReferenceSize.height;

    y += self.sectionInset.top;
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];

    NSInteger rows = ceilf(itemCount/(float)itemsAcross);

    for (int row = 0; row < rows; row++)
    {
        dictionary[[NSIndexPath indexPathForItem:row inSection:0]] = [NSValue valueWithCGRect:CGRectMake(0, y-10, self.collectionViewContentSize.width, 150)];
     
        y += self.itemSize.height;
        
        if (row < rows - 1) {

            y += self.minimumLineSpacing;
        }
    }
    
    y += self.sectionInset.bottom;
    
    y += self.footerReferenceSize.height;
    
    _shelfFrames = [NSDictionary dictionaryWithDictionary:dictionary];
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    /* Default attributes for all cells */
    
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    
    /* Updated attributes for all cells */
    
    NSMutableArray *newArray = [array mutableCopy];
    
    
    /* Custom background setup */
    
    [_shelfFrames enumerateKeysAndObjectsUsingBlock:^(id key, id shelfRect, BOOL *stop) {
        if (CGRectIntersectsRect([shelfRect CGRectValue], rect))
        {
            
            UICollectionViewLayoutAttributes *shelfAttributes =
            [self layoutAttributesForDecorationViewOfKind:[ShelfDecorationView kind]
                                              atIndexPath:key];
            
            shelfAttributes.frame = [shelfRect CGRectValue];
            
            [newArray addObject:shelfAttributes];
        }
    }];
    
    array = [NSArray arrayWithArray:newArray];

    return array;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    id shelfRect = _shelfFrames[indexPath];
    
    if (!shelfRect) {
     
        return nil;
    }
    
    UICollectionViewLayoutAttributes *attributes =
    [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind
                                                                withIndexPath:indexPath];
    attributes.frame = [shelfRect CGRectValue];
    
    attributes.zIndex = -1; // Shelf is lower view
    
    
    return attributes;
}

@end
