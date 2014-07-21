//
//  TopWebViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-7-10.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TopicWebViewController.h"
#import "Topic.h"
#import "IMTWebView.h"
#import "ChromeProgressBar.h"

#define ProgressBarHeight 4

@interface TopicWebViewController ()<IMTWebViewProgressDelegate,UIWebViewDelegate>{
    @private
    ChromeProgressBar*progressBar;
    IBOutlet UIView*reloadTapView;
}

@property(nonatomic,strong)IBOutlet IMTWebView*webView;

@end

@implementation TopicWebViewController

@synthesize topic;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        progressBar=[[ChromeProgressBar alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        progressBar=[[ChromeProgressBar alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        
    }
    return self;
}

-(void)loadView{
    [super loadView];
    self.webView.backgroundColor=[UIColor blackColor];
    UITapGestureRecognizer* reloadTapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadTap:)];
    [reloadTapView addGestureRecognizer:reloadTapRecognizer];
    reloadTapView.hidden=YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title=self.topic.title;
    self.webView.progressDelegate=self;
    self.webView.delegate=self;
    
    CGRect rect=CGRectMake(0, 64, CGRectGetWidth(self.view.frame), ProgressBarHeight);
    progressBar.frame=rect;
    
    [self.webView addSubview:progressBar];
    
    [self startRequestPage];
    

    
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

#pragma mark -- webview delegate

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"Failed to load URL ,for error :%@",[error localizedDescription]);
    [reloadTapView removeFromSuperview];
    reloadTapView.frame=self.webView.bounds;
    reloadTapView.hidden=NO;
    [self.webView addSubview:reloadTapView];
    
}

- (void) webView:(IMTWebView*)webView didReceiveResourceNumber:(int)resourceNumber totalResources:(int)totalResources{
    [progressBar setProgress:((float)resourceNumber) / ((float)totalResources) animated:NO];
    
    //Reset resource count after finished
    if (resourceNumber == totalResources) {
        self.webView.resourceCount = 0;
        self.webView.resourceCompletedCount = 0;
    }
}

#pragma mark -- private messages

-(void)startRequestPage{
    
    NSURL* url=[NSURL URLWithString:self.topic.urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowed timeoutInterval:10000]];
    progressBar.hidden=NO;
    [progressBar setProgress:0 animated:NO];
}
-(void)reloadTap:(UITapGestureRecognizer*)recognizer{
    UIView*tapView=recognizer.view;
    tapView.hidden=YES;
    
    
}

@end
