//
//  BookCollectionViewCell.m
//  Bookshelf
//
//  Created by Jakub Vodak on 9/12/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import "BookCollectionViewCell.h"

@interface BookCollectionViewCell ()

@property (nonatomic, strong) UIImageView *bookNewImageView;

@end

@implementation BookCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frameRect {
    
    self = [super initWithFrame:frameRect];
    
    if (self) {
    
        [self applyAppearance];
    }
    
    return self;
}

- (void)applyAppearance
{
    UIView *contentView = self.contentView;
 
    
    /* Title */
    
    _titleLabel = [UILabel new];
    
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel.textColor = [UIColor whiteColor];
    
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    
    _titleLabel.shadowColor = [UIColor blackColor];
    
    _titleLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    
    [contentView addSubview:_titleLabel];
    
    
    /* Book Background */
    
    UIImageView *backgroundImage = [UIImageView new];
    
    backgroundImage.translatesAutoresizingMaskIntoConstraints = NO;
    
    backgroundImage.image = [UIImage imageNamed:@"BookShadow"];
    
    [contentView addSubview:backgroundImage];
    
    
    /* Flyer image */
    
    _flyerImage = [UIImageView new];
    
    _flyerImage.translatesAutoresizingMaskIntoConstraints = NO;
    
    _flyerImage.contentMode = UIViewContentModeScaleToFill;
    
    [backgroundImage addSubview:_flyerImage];
    
    
    /* Sticker New */
    
    _bookNewImageView = [UIImageView new];
    
    _bookNewImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _bookNewImageView.image = [UIImage imageNamed:@"BookNew"];
    
    [backgroundImage addSubview:_bookNewImageView];
    
    
    /* Constraints */
    
    [backgroundImage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-2-[_flyerImage]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flyerImage)]];
    
    [backgroundImage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[_flyerImage]-9-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flyerImage)]];
    
    [backgroundImage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_bookNewImageView]-7-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bookNewImageView)]];
    
    [backgroundImage addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-1-[_bookNewImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bookNewImageView)]];
    
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[backgroundImage]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImage)]];
    
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel(20)][backgroundImage]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel, backgroundImage)]];
    
}


- (void)setBookNew: (BOOL)isNew
{
    _bookNewImageView.hidden = !isNew;
}

@end
