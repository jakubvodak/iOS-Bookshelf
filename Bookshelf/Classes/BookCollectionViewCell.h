//
//  BookCollectionViewCell.h
//  Bookshelf
//
//  Created by Jakub Vodak on 9/12/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *flyerImage;

- (void)setBookNew: (BOOL)isNew;

@end
