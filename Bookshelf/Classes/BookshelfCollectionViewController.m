//
//  BookshelfCollectionViewController.m
//  Bookshelf
//
//  Created by Jakub Vodak on 9/12/14.
//  Copyright (c) 2014 h2ocompany. All rights reserved.
//

#import "BookshelfCollectionViewController.h"
#import "BookCollectionViewCell.h"
#import "ConnectionManager.h"
#import "BookEntity.h"
#import "LogService.h"

@interface BookshelfCollectionViewController ()

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, weak) NSURLConnection *dataRequestConnection;

@property (nonatomic, strong) NSArray *books;

@end

@implementation BookshelfCollectionViewController

static NSString * const reuseIdentifier = @"BookCell";


#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self applyAppearance];
    
    [self loadData];
}

- (void)dealloc
{
    [_dataRequestConnection cancel];
}


#pragma mark - View setup

- (void)applyAppearance
{
    
    /* Collection View */
    
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.collectionView registerClass:[BookCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
    /* Refresh control */
    
    _refreshControl = [UIRefreshControl new];
    
    _refreshControl.tintColor = [UIColor whiteColor];
    
    [_refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    
    [self.collectionView addSubview:_refreshControl];
    
    
    /* Activity indicator */
    
    _activityIndicator = [UIActivityIndicatorView new];
    
    _activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    
    _activityIndicator.color = [UIColor whiteColor];
    
    _activityIndicator.hidesWhenStopped = YES;
    
    [_activityIndicator startAnimating];
    
    [self.view addSubview:_activityIndicator];
    
    
    /* Constraints */
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
}


#pragma mark - CollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _books.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    BookEntity *book = [_books objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = book.title;
    
    [cell setBookNew:book.isBookNew];
    
    
    /* I wish I could use UIImageView+AFNetworking.h | No caching here */
    
    cell.flyerImage.hidden = true;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
    
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:book.thumbnail]];
    
        UIImage *image = [UIImage imageWithData:data];
        
        
        /* In case of wrong URL */
        
        if (!image) {
            
            image = [UIImage imageNamed:@"ImagePlaceholder"];
        }

        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            cell.flyerImage.image = image;
            
            cell.flyerImage.hidden = false;
        });
    });
    
    return cell;
}


#pragma mark - Connection

- (void)loadData
{
    __weak __typeof__(self) weakSelf = self;
    
    _dataRequestConnection = [BookEntity requestBooksCompletionHandler:^(NSArray *books, NSError *error) {
        
        [weakSelf.activityIndicator stopAnimating];
        
        [weakSelf.refreshControl endRefreshing];
        
        if (error) {
            
            [[LogService sharedInstance] logError:error];
        }
        else {

            weakSelf.books = books;
            
            [weakSelf.collectionView reloadData];
        }
    }];
}

@end
