//
//  TopicTableViewController.m
//  TeaTalker
//
//  Created by user on 14-2-11.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TopicTableViewController.h"
#import "Species.h"
#import "TeaCategory.h"
#import "Topic.h"
#import "ImageInfo.h"
#import "TopicContainerParser.h"
#import "TeaTopicManager.h"
#import "ProgressHUD.h"
#import "ElementsContainer.h"


#import "TopicWebViewController.h"
@interface TopicTableViewController ()<NSURLSessionDelegate,UISearchDisplayDelegate,UISearchBarDelegate>{
    @private
    IBOutlet UISearchDisplayController*searchDisplayController;
    ElementsContainer*searchResultContainer;
    
}

-(IBAction)loadMoreTopics:(id)sender;

@end

@implementation TopicTableViewController

@synthesize topicType;
@synthesize topicDataManager;


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
    searchDisplayController.delegate=self;
    searchDisplayController.searchResultsTitle=@"Result Text";
    
    if (nil==self.topicDataManager) {
        self.topicDataManager=[[TeaTopicManager alloc]init];
    }
    [self requestTopicPage:0];
    if (topicType==TopicTypeSpecies) {
    
    }

    CGFloat height=CGRectGetHeight(self.tableView.tableHeaderView.frame);
    self.tableView.contentOffset=CGPointMake(0, height);
 
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
    ElementsContainer*topicContainer=nil;
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return 1;
        //topicContainer=searchResultContainer;
    }
    else{
        
        topicContainer=self.topicDataManager.topicElementContainer;

    }
    
    return topicContainer.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView==self.searchDisplayController.searchResultsTableView) {
        static NSString* SearchingCellIdentifier=@"SearchingTableViewCell";
        UITableViewCell*searchingCell=[self.tableView dequeueReusableCellWithIdentifier:SearchingCellIdentifier forIndexPath:indexPath];
        NSString*word=self.searchDisplayController.searchBar.text;
        NSString*text=nil;
        if (0==word.length) {
            text=@"搜索词为空";
            searchingCell.exclusiveTouch=YES;
        }
        else{
            text=[NSString stringWithFormat:@"搜索关键字：%@",word];
            searchingCell.exclusiveTouch=NO;
        }
        
        searchingCell.textLabel.text=text;
        return searchingCell;
        
    }
    else{
        static NSString *CellIdentifier = @"TopicCellIdentifer";
        ElementsContainer*topicContainer=nil;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        topicContainer=self.topicDataManager.topicElementContainer;
        Topic*topic=[topicContainer.elementArray objectAtIndex:indexPath.row];
        cell.imageView.image=topic.titleImageInfo.image;
        cell.textLabel.text=topic.title;
        cell.detailTextLabel.text=topic.introduction;
        return cell;
    }
    
    return nil;
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController*dstvc=(UIViewController*)segue.destinationViewController;
    if ([dstvc class]==[TopicWebViewController class]) {
        
        NSIndexPath*indexPath=[self.tableView indexPathForSelectedRow];
        ElementsContainer*topicContainer=[self.topicDataManager topicElementContainer];;
        Topic*tp=[topicContainer.elementArray objectAtIndex:indexPath.row];
        
        TopicWebViewController*twvc=(TopicWebViewController*)dstvc;
        twvc.topic=tp;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
      *detailViewController = [[ alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
#pragma mark -- UISearchBarControlDelegate messages

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    
    return YES;
}
- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller{
    
}
-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
    
}
-(void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView{
    
}
#pragma mark -- UISearchBarDelegate message

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

#pragma mark -- action messages

-(IBAction)loadMoreTopics:(id)sender{
    ElementsContainer*topicContainer=[self.topicDataManager topicElementContainer];
    
    [self requestTopicPage:topicContainer.pageIndex+1];
}

#pragma mark -- private mesages
-(void)requestTopicPage:(NSInteger)pageIndex{
   
    NSString*pageRequestUrlString=[self.topicDataManager pageRequestUrlString:pageIndex];
    NSURLSessionConfiguration*config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession*session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask*task=[session dataTaskWithURL:[NSURL URLWithString:pageRequestUrlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //[MMProgressHUD dismiss];
        [ProgressHUD dismiss];
        if (nil!=error) {
            NSLog(@"The page failed %@",[error localizedFailureReason]);
            return ;
        }
        [self processTopicPage:data];
        [self.tableView reloadData];
        
    }];
    //[MMProgressHUD showWithTitle:@"Start" status:@"nil"];
    [ProgressHUD show:@"Start Downloade" Interaction:NO];
    [task resume];
}
-(void)processTopicPage:(NSData*)data{
    TopicContainerParser*parser=[[TopicContainerParser alloc]init];
    ElementsContainer*resultContainer=[parser parse:data];
    ElementsContainer*topicContainer=[self.topicDataManager topicElementContainer];
    topicContainer.pageIndex++;
    topicContainer.count+=[resultContainer.elementArray count];
    [topicContainer.elementArray addObjectsFromArray:resultContainer.elementArray];
}

@end
