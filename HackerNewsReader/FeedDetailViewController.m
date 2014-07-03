//
//  FeedDetailViewController.m
//  HackerNewsReader
//
//  Created by Sanjay Kunta on 6/6/14.
//  Copyright (c) 2014 Kent State University. All rights reserved.
//

#import "FeedDetailViewController.h"

@interface FeedDetailViewController() <UIWebViewDelegate>
@property (nonatomic, weak) IBOutlet UIWebView* feedDetailWebView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView* activityIndicator;
@end

@implementation FeedDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //Set title
    self.title = _feedTitle;
    
    //Load url into the webview
    NSURL* url = [NSURL URLWithString:_feedURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [_feedDetailWebView loadRequest:request];
}

#pragma mark - UIWebViewDelegate methods
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //start animating activity indicator when webview starts loading
    [_activityIndicator startAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //stop animating activity indicator when webview has error loading
    [_activityIndicator stopAnimating];
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Unable to load feed page" message:@"There was an error loading feed from Hacker news. Please verify your network connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //stop animating activity indicator when webview ends loading
    [_activityIndicator stopAnimating];
}

@end
