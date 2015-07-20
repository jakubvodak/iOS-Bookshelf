//
//  ShelfDecorationView.m
//  Bookshelf
//
//  Created by Jakub Vodak on 9/13/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import "ShelfDecorationView.h"

@implementation ShelfDecorationView

- (instancetype)initWithFrame:(CGRect)frameRect {
    
    self = [super initWithFrame:frameRect];
    
    if (self) {
    
        [self applyAppearance];
    }
    
    return self;
}


- (void)applyAppearance
{
    /* Background Image */
    
    UIImageView *backgroundImageView = [UIImageView new];
    
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    backgroundImageView.image = [[UIImage imageNamed:@"ShelfcellBgr"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 40, 0, 40)];
    
    [self addSubview:backgroundImageView];
    
    
    /* Constranints */
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[backgroundImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImageView)]];
}


+ (NSString *)kind
{
    return @"ShelfDecorationView";
}

@end
