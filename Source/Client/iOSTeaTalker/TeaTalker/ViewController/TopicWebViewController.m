//
//  TopWebViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-7-10.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TopicWebViewController.h"
#import "Topic.h"

@interface TopicWebViewController ()

@property(nonatomic,strong)IBOutlet UIWebView*webView;

@end

@implementation TopicWebViewController

@synthesize topic;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL* url=[NSURL URLWithString:self.topic.urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:10000]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
