//
//  ViewController.m
//  HackerNewsReader
//
//  Created by Sanjay Kunta on 6/6/14.
//  Copyright (c) 2014 Kent State University. All rights reserved.
//

#import "FeedsViewController.h"
#import "FeedDownloader.h"
#import "FeedItem.h"
#import "FeedDownloader.h"
#import "FeedItemCell.h"
#import "FeedDetailViewController.h"

@interface FeedsViewController () <UITableViewDataSource, FeedDownloaderDelegate>{
    FeedDownloader* feedDownloader;
}
@property (nonatomic, weak) IBOutlet UITableView* feedsTableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView* activityIndicator;
@property (nonatomic, strong) NSArray* feedItems;
@end

@implementation FeedsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    feedDownloader = [[FeedDownloader alloc] init];
    feedDownloader.delegate = self;
    [feedDownloader downloadFeeds];
    [_activityIndicator startAnimating];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //Set title and url for detail view
    if ([segue.identifier isEqualToString:@"FeedDetailSegueIdentifier"]) {
        FeedDetailViewController* detailViewController = (FeedDetailViewController*)segue.destinationViewController;
        FeedItem* feedItem = _feedItems[_feedsTableView.indexPathForSelectedRow.row];
        detailViewController.feedTitle = feedItem.title;
        detailViewController.feedURL = feedItem.url;
    }
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _feedItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"FeedItemCell";
    FeedItemCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    FeedItem* item = _feedItems[indexPath.row];
    
    cell.titleLabel.text = item.title;
    cell.postedByLabel.text =  item.postedBy;
    cell.postedAgoLabel.text = item.postedAgo;
    return cell;
}

#pragma mark - FeedDownloaderDelegate methods
- (void)didFinishDonwloadingFeeds:(NSArray *)feeds withError:(NSError *)error{
    if (!error) {
        _feedItems = feeds;
        [self.feedsTableView reloadData];
    }else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Unable to donwload" message:@"There was an error downloading feeds from Hacker news.  Please verify your network connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
    [_activityIndicator stopAnimating];
}

@end
