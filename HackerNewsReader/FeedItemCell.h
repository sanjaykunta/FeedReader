//
//  FeedItemCell.h
//  HackerNewsReader
//
//  Created by Sanjay Kunta on 6/6/14.
//  Copyright (c) 2014 Kent State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedItemCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel* titleLabel;
@property (nonatomic, weak) IBOutlet UILabel* postedByLabel;
@property (nonatomic, weak) IBOutlet UILabel* postedAgoLabel;
@end
