//
//  SearchResultTableViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-8-29.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "ElementsContainer.h"
#import "SearchResultElement.h"
#import "RequestUrlStringUtility.h"
#import "SearchResultParser.h"
#import "TopicWebViewController.h"
#import "SpeciesDetailViewController.h"
#import "Topic.h"
#import "Species.h"
#import "SpeciesDetailTableViewController.h"

@interface SearchResultTableViewController ()<NSURLSessionDelegate>{
    
    @private
    ElementsContainer*searchResultContainer;
    
}



-(void)requestSearchResultPage:(NSString*)word pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize;

@end

@implementation SearchResultTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    searchResultContainer=[[ElementsContainer alloc]init];
    
    
    [self requestSearchResultPage:self.searchWord pageIndex:0 pageSize:12];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResultContainer.elementArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultElement*sre=[searchResultContainer.elementArray objectAtIndex:indexPath.row];
    static NSString*cellIdentifer=nil;
    if (SearchResultTypeSpecies==sre.resultType) {
        cellIdentifer=@"SpeciesCell";
    }
    else{
        cellIdentifer=@"TopicCell";
    }
    UITableViewCell*cell=[self.tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    cell.textLabel.text=sre.title;
    cell.detailTextLabel.text=NSStringFromSearchType(sre.resultType);
    return cell;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    SearchResultElement*result=[searchResultContainer.elementArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    UIViewController*viewcontroller=segue.destinationViewController;
    if ([viewcontroller class]==[TopicWebViewController class]) {

        TopicWebViewController*tvc=(TopicWebViewController*)viewcontroller;
        Topic*tp=[[Topic alloc]init];
        tp.title=result.title;
        tp.urlString=result.urlString;
        tvc.topic=tp;
        return;
    }
    if ([viewcontroller class]==[SpeciesDetailTableViewController class]) {
        
        SpeciesDetailTableViewController*sdtvc=(SpeciesDetailTableViewController*)viewcontroller;
        Species*spc=[[Species alloc]init];
        spc.name=result.title;
        spc.introduction=result.introduction;
        spc.urlString=result.urlString;
        sdtvc.species=spc;
        return;
    }
}


#pragma mark -- NSURLSessionDelegate

#pragma private messages

-(void)requestSearchResultPage:(NSString*)word pageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
    
    NSString*urlString=[RequestUrlStringUtility searchRequestUrlString:word pageIndex:pageIndex pageSize:pageSize];
    NSURLSessionConfiguration*config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession*session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask*task=[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (nil!=error) {
            NSLog(@"The page failed %@",[error localizedFailureReason]);
            return ;
        }
        [self processSearchResult:data];
        [self.tableView reloadData];
        
    }];
    [task resume];
    
}
-(void)processSearchResult:(NSData*)data{
    SearchResultParser*parser=[[SearchResultParser alloc]init];
    ElementsContainer*result=[parser parse:data];
    [searchResultContainer.elementArray addObjectsFromArray:result.elementArray];
    searchResultContainer.pageIndex=result.pageIndex;
    
}


@end
