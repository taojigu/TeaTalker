//
//  TeaCategoryTableViewController.m
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TeaCategoryTableViewController.h"
#import "TeaCategory.h"
#import "RequestUrlStringUtility.h"
#import "TeaCategoryArrayParser.h"
#import "TeaCategoryViewController.h"
#import "ProgressHUD.h"

#define NameLabelTag 100
#define CategoryImageViewTag 101



@interface TeaCategoryTableViewController ()

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController*dstvc=[segue destinationViewController];
    if ([dstvc isKindOfClass:[TeaCategoryViewController class]]) {
        UITableViewCell*cell=(UITableViewCell*)sender;
        NSIndexPath*indexPath=[self.tableView indexPathForCell:cell];
        TeaCategory*tc=[self.teaCategoryArray objectAtIndex:indexPath.row];
        TeaCategoryViewController*tcvc=(TeaCategoryViewController*)dstvc;
        tcvc.teaCategory=tc;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.teaCategoryArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TeaCategoryCellIdentefer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel*nameLabel=(UILabel*)[cell viewWithTag:NameLabelTag];
    
    TeaCategory*tc=[self.teaCategoryArray objectAtIndex:indexPath.row];
    nameLabel.text=tc.categoryName;
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



#pragma mark private messages

-(void)startDownloadTeaCategory{
    NSString*urlString=[RequestUrlStringUtility teaCategoryURLString];
    NSURLSessionConfiguration*config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession*session=[NSURLSession sessionWithConfiguration:config];
    NSURLSessionTask*task=[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [ProgressHUD dismiss];
        if (nil!=error) {
             NSLog(@"Request Failed:%@",urlString);
            return ;
        }
        TeaCategoryArrayParser*parser=[[TeaCategoryArrayParser alloc]init];
        NSMutableArray*resultArray=[parser parse:data];
        self.teaCategoryArray=resultArray;
        [self.tableView reloadData];
        return ;
    }];
    [ProgressHUD show:@"Waiting" Interaction:NO];
    [task resume];
}
@end
