//
//  FeedDownloader.h
//  HackerNewsReader
//
//  Created by Sanjay Kunta on 6/6/14.
//  Copyright (c) 2014 Kent State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FeedDownloaderDelegate <NSObject>

- (void)didFinishDonwloadingFeeds:(NSArray*)feeds withError:(NSError*)error;

@end

@interface FeedDownloader : NSObject
@property (nonatomic, weak) id<FeedDownloaderDelegate> delegate;
- (void) downloadFeeds;
@end
