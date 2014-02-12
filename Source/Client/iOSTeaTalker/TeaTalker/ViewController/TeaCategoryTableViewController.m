//
//  TeaCategoryTableViewController.m
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TeaCategoryTableViewController.h"
#import "ASIHTTPRequest.h"
#import "TeaCategory.h"
#import "RequestUrlStringUtility.h"
#import "TeaCategoryArrayParser.h"



@interface TeaCategoryTableViewController ()<ASIHTTPRequestDelegate>

-(void)startDownloadTeaCategory;

@property(nonatomic,strong)NSMutableArray*teaCategoryArray;

@end

@implementation TeaCategoryTableViewController

@synthesize teaCategoryArray;

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
    
    [self startDownloadTeaCategory];

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
    return [self.teaCategoryArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TeaCategory*tc=[self.teaCategoryArray objectAtIndex:section];
    return tc.species.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpeciesCellIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark AsiHttpRequestDelegate messages

-(void)requestFinished:(ASIHTTPRequest *)request{
    TeaCategoryArrayParser*parser=[[TeaCategoryArrayParser alloc]init];
    NSMutableArray*resultArray=[parser parse:request.responseData];
    self.teaCategoryArray=resultArray;
    [self.tableView reloadData];
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"Request Failed");
}

#pragma mark private messages

-(void)startDownloadTeaCategory{
    NSString*urlString=[RequestUrlStringUtility teaCategoryURLString];
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.delegate=self;
    [request startAsynchronous];
}
@end
