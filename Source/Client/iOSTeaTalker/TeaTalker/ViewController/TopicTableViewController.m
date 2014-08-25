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

#import "ElementsContainer.h"

#import "TopicWebViewController.h"
@interface TopicTableViewController ()<NSURLSessionDelegate>{
    @private
    IBOutlet UISearchDisplayController*searchDisplayController;
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
    ElementsContainer*topicContainer=self.topicDataManager.topicElementContainer;
    return topicContainer.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TopicCellIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    ElementsContainer*topicContainer=[self.topicDataManager topicElementContainer];
    Topic*topic=[topicContainer.elementArray objectAtIndex:indexPath.row];
    cell.imageView.image=topic.titleImageInfo.image;
    cell.textLabel.text=topic.title;
    cell.detailTextLabel.text=topic.introduction;
    
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
        if (nil!=error) {
            NSLog(@"The page failed %@",[error localizedFailureReason]);
            return ;
        }
        [self processTopicPage:data];
        [self.tableView reloadData];
        
    }];
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
