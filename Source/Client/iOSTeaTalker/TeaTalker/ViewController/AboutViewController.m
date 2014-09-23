//
//  AboutViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-22.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "AboutViewController.h"
#import "About.h"
#import "AboutParser.h"

@interface AboutViewController ()<NSURLSessionDelegate>{
    @private
    IBOutlet UITextView*textView;
}

@end

@implementation AboutViewController

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
    textView.hidden=YES;
    
    [self requestAboutData];
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

#pragma privage messages

-(void)requestAboutData{
    NSURLSessionConfiguration*config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession*session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSString*urlString=[RequestUrlStringUtility aboutDataUrlString];
    NSURLSessionDataTask*task=[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [ProgressHUD dismiss];
        if (error!=nil) {
            NSLog(@"Failed to download About Info:%@",[error description]);
            return ;
        }
        
        AboutParser*parser=[[AboutParser alloc]init];
        About*abt=[parser parse:data];
        if ([abt.resultState.resultCode isEqualToString:ResultCodeFailed]) {
            NSLog(@"About Result is failed");
            return;
        }
        textView.hidden=NO;
        textView.text=abt.text;
        
        return ;
    }];
    [task resume];
    [ProgressHUD show:@"Loading" Interaction:NO];
    
}







@end
