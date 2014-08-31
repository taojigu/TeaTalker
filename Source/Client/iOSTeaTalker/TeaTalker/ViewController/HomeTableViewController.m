//
//  SearchTableViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-8-28.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "HomeTableViewController.h"
#import "ElementsContainer.h"
#import "Topic.h"
#import "RequestUrlStringUtility.h"
#import "TopicContainerParser.h"
#import "SearchResultTableViewController.h"


@interface HomeTableViewController ()<NSURLSessionDelegate,UISearchBarDelegate>{
    @private
    ElementsContainer*recommandTopicContainer;
    NSMutableArray*keyWowrdArray;

    

}

@end

@implementation HomeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    if (self) {
        recommandTopicContainer=[[ElementsContainer alloc]init];
        //searchResultTopicContanier=[[ElementsContainer alloc]init];
        keyWowrdArray=[[NSMutableArray alloc]init];
        [self fakekeyWordArray];
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self requestRecommandTopic:0 pageSize:12];
    
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
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        return [keyWowrdArray count];
    }
    
    return [recommandTopicContainer.elementArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.searchDisplayController.searchResultsTableView) {
        UITableViewCell*keywordCell=[self keywordCell:indexPath];
        return keywordCell;
    }
    else{
        NSAssert(tableView==self.tableView, @"should not this tableview");
        UITableViewCell*topicCell=[self topicCell:indexPath];
        return  topicCell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView!=self.searchDisplayController.searchResultsTableView) {
        return;
    }
    
    NSString*keyword=[keyWowrdArray objectAtIndex:indexPath.row];
    NSAssert(0!=keyword.length, @"keyword should not be nil");
    self.searchDisplayController.searchBar.text=keyword;
    [self searchWord:keyword];
    
}

#pragma UISearchBar delegate message

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchWord:searchBar.text];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- private messages

-(void)requestRecommandTopic:(NSInteger)pageIndex pageSize:(NSInteger)pageSize{
    
    NSString*urlString=[RequestUrlStringUtility recommandTopicReqeustUrl:pageIndex pageSize:pageSize];
    NSURLSessionConfiguration*config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession*session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask*task=[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (nil!=error) {
            NSLog(@"The page failed %@",[error localizedFailureReason]);
            return ;
        }
        [self processRecommandTopicPageData:data];
        [self.tableView reloadData];
        
    }];
    [task resume];
}
-(void)processRecommandTopicPageData:(NSData*)data{
    TopicContainerParser*parser=[[TopicContainerParser alloc]init];
    ElementsContainer*ec=[parser parse:data];
    [recommandTopicContainer.elementArray addObjectsFromArray:ec.elementArray];
    recommandTopicContainer.pageIndex=ec.pageIndex;
    
}
-(UITableViewCell*)keywordCell:(NSIndexPath*)indexPath{
    static NSString*cellIdentifer=@"KeywordCell";
    UITableViewCell*cell=[self.tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    NSAssert(nil!=cell, @"shoould not nil cell");
    NSString*kewword=[keyWowrdArray objectAtIndex:indexPath.row];
    cell.textLabel.text=kewword;
    return cell;
}

-(UITableViewCell*)topicCell:(NSIndexPath*)indexPath{
    static NSString*cellIdentifer=@"TopicCell";
    UITableViewCell*cell=[self.tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    NSArray*elementArray=nil;
    if (self.searchDisplayController.searchBar.text.length==0) {
        
        elementArray=recommandTopicContainer.elementArray;
    }
   
    Topic *tp=[elementArray objectAtIndex:indexPath.row];
    cell.textLabel.text=tp.title;
    cell.detailTextLabel.text=tp.introduction;
    return cell;
}
-(void)fakekeyWordArray{
    for (NSInteger keyIndex=0; keyIndex<6; keyIndex++) {
        NSString*keyword=[NSString stringWithFormat:@"Keyword %li",(long)keyIndex];
        [keyWowrdArray addObject:keyword];
    }
}

-(void)searchWord:(NSString*)word{
    
    if (0==word.length) {
        return;
    }
    
    UIStoryboard* storyboard=self.storyboard;
    SearchResultTableViewController*srvc=[storyboard instantiateViewControllerWithIdentifier:@"SearchResultTableViewController"];
    srvc.searchWord=word;
    [self.navigationController pushViewController:srvc animated:YES];
}

@end
