//
//  SepciesDetailTableViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-7-7.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "SepciesDetailTableViewController.h"
#import "TextTableViewCell.h"
#import "Species.h"
#import "ResourceConfigure.h"
#import "Topic.h"
#import "ImageInfo.h"
#import "TopicWebViewController.h"
#import "TopicTableViewController.h"
#import "TopicDataManager.h"
#import "SpeciesTopicManager.h"

#define SpeciesSection 0
#define IntroductionRow 0
#define CookSkillRow 1

#define TopicSection 1

#define TextTableViewCellIdentifer @"TextTableViewCell"
#define MoreCellIdentifer @"MoreTopicCell"

#define TopicCellIdentifer @"TopicCell"

#define TopicCellHeight 60

@interface SepciesDetailTableViewController (){
    
}



@end

@implementation SepciesDetailTableViewController

@synthesize species;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hidesBottomBarWhenPushed=YES;
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (SpeciesSection==section) {
        return 2;
    }
    if (TopicSection==section) {
        return [self.species.topicContainer.elementArray count]+1;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (SpeciesSection==indexPath.section) {
        return [self speciesSectionCell:tableView indexPath:indexPath];
    }
    if (TopicSection==indexPath.section) {
        return [self topicCell:tableView indexPath:indexPath];
    }
    
    
    // Configure the cell...
    NSAssert(NO,@"The cell should not be nil");
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (SpeciesSection==indexPath.section&&IntroductionRow==indexPath.row) {
        return [TextTableViewCell cellHeightForText:self.species.introduction];
    }
    if (SpeciesSection==indexPath.section&&CookSkillRow==indexPath.row) {
        return [TextTableViewCell cellHeightForText:self.species.cookText];
    }
    
    if (TopicSection==indexPath.section) {
        return TopicCellHeight;
    }
    
    
    NSAssert(NO, @"Invalidate height for the row ");
    return 0;
    
}

#pragma mark -- tableView delegate message

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (TopicSection==section) {
        NSString*title=[NSString stringWithFormat:@"%@的话题",self.species.name];
        return title;
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
   
    UIViewController*dstvc=segue.destinationViewController;
    if ([dstvc class]==[TopicWebViewController class]) {
        NSIndexPath*indexPath=[self.tableView indexPathForSelectedRow];
        NSAssert(TopicSection==indexPath.section, @"Not invalidate topic section");
        TopicWebViewController*twvc=(TopicWebViewController*)dstvc;
        twvc.topic=[self.species.topicContainer.elementArray objectAtIndex:indexPath.row];
        return;
        
    }
    if ([dstvc class]==[TopicTableViewController class]) {
        TopicTableViewController*ttvc=(TopicTableViewController*)dstvc;
        ttvc.topicDataManager=[[SpeciesTopicManager alloc]init];
        
    }
    
}

#pragma mark -- selector message



#pragma mark -- private messages

-(UITableViewCell*)speciesSectionCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    
    if (IntroductionRow==indexPath.row) {
       TextTableViewCell*tcell=(TextTableViewCell*)[tableView dequeueReusableCellWithIdentifier:TextTableViewCellIdentifer];
        tcell.headerLabel.text=@"简介";
        //tcell.headerLabel.backgroundColor=[UIColor yellowColor];
        tcell.bodyLabel.text=self.species.introduction;
        //tcell.bodyLabel.backgroundColor=[UIColor greenColor];
       
        return tcell;
    }
    if (CookSkillRow==indexPath.row) {
        TextTableViewCell*cookCell=(TextTableViewCell*)[tableView dequeueReusableCellWithIdentifier:TextTableViewCellIdentifer];
        cookCell.headerLabel.text=@"泡茶";
        cookCell.bodyLabel.text=self.species.cookText;
        cookCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cookCell;
    }
    NSAssert(NO, @"Species Cell should not be nil");
    return nil;
}
-(UITableViewCell*)topicCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    
    if (indexPath.row==[self.species.topicContainer.elementArray count]) {
        UITableViewCell*moreCell=[tableView dequeueReusableCellWithIdentifier:MoreCellIdentifer];
        return moreCell;
    }
    else{

        Topic*tp=[self.species.topicContainer.elementArray objectAtIndex:indexPath.row];
        UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:TopicCellIdentifer];
        cell.imageView.image=tp.titleImageInfo.image;
        cell.textLabel.text=tp.title;
        cell.detailTextLabel.text=tp.introduction;
        return cell;
    }
    
   

}

@end
