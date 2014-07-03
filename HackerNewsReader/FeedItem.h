//
//  FeedItem.h
//  HackerNewsReader
//
//  Created by Sanjay Kunta on 6/6/14.
//  Copyright (c) 2014 Kent State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSNumber* commentCount;
@property (nonatomic, strong) NSString* postedBy;
@property (nonatomic, strong) NSString* postedAgo;
@property (nonatomic, strong) NSNumber* points;

@end
