//
//  FeedDownloader.m
//  HackerNewsReader
//
//  Created by Sanjay Kunta on 6/6/14.
//  Copyright (c) 2014 Kent State University. All rights reserved.
//

#import "FeedDownloader.h"
#import "FeedItem.h"

NSString* const HackerNewsURL = @"http://api.ihackernews.com/page";

@implementation FeedDownloader

- (void)downloadFeeds{
    //As we want to call some local method inside the completion block, to avoid retain cycle we use weakSelf.
    __weak FeedDownloader* weakSelf = self;
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:HackerNewsURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                //If no error parse json
                if (!error) {
                    //Parse json data
                    NSDictionary* parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                    //Get feed items from the json
                    NSArray* feedItemsJSON = parsedJSON[@"items"];
                    
                    NSMutableArray* feedItems = [NSMutableArray arrayWithCapacity:feedItemsJSON.count];

                    //Loop through all parsed json feed items and save them to an array
                    for (NSDictionary* feedItem in feedItemsJSON) {
                        FeedItem* item = [[FeedItem alloc] init];
                        item.title = [weakSelf returnNonNullStringIfNull:feedItem[@"title"]] ;
                        item.url = [weakSelf returnNonNullStringIfNull:feedItem[@"url"]] ;
                        item.commentCount = feedItem[@"commentCount"];
                        item.points = feedItem[@"points"];
                        item.postedAgo = [weakSelf returnNonNullStringIfNull:feedItem[@"postedAgo"]];
                        item.postedBy = [weakSelf returnNonNullStringIfNull:feedItem[@"postedBy"]];
                        
                        [feedItems addObject:item];
                    }
                    
                    [weakSelf postToDelegateWithFeedItems:feedItems error:error];
                }else{
                    [weakSelf postToDelegateWithFeedItems:nil error:error];
                }
            }] resume];

}

- (NSString*)returnNonNullStringIfNull:(NSString*)value{
    //Check if string is not null and has some value
    if (value != (id)[NSNull null] && value.length > 0) {
        return value;
    }
    return @"";
}

- (void)postToDelegateWithFeedItems:(NSArray*)feedItems error:(NSError*)error{
    //As this method is called from NSURLSession completion handler block it runs in background thread. So call the delegate correctly we have to run it in main thread.
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate) {
            [self.delegate didFinishDonwloadingFeeds:feedItems withError:error];
        }
    });
}

@end
