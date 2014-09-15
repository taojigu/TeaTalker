//
//  SpeciesDetail1TableViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "SpeciesDetail1TableViewController.h"

#import "Species.h"
#import "Topic.h"
#import "ImageInfo.h"
#import "FullTextViewController.h"
#import "ImageTextViewController.h"
#import "TopicWebViewController.h"


#define SpeciesSection 0
#define IntroductionRow 0
#define CookSkillRow 1

#define TopicSection 1



#define MoreCellIdentifer @"MoreTopicCellIdentifer"
#define IntroductionCellIdentifer @"IntroductionCellIdentifer"
#define CookCellIdentifer @"CookCellIdentifer"
#define TopicCellIdentifer @"TopicCellIdentifer"


#define TopicCellHeight 60


@interface SpeciesDetail1TableViewController ()<NSURLSessionDelegate>{
    @private
    IBOutlet UIScrollView*imageScrollView;

    UIView*loadingView;
    
}

@end

@implementation SpeciesDetail1TableViewController

@synthesize species;

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
        loadingView=[[UIView alloc]initWithFrame:CGRectZero];
        loadingView.backgroundColor=[UIColor blueColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.species.urlString.length!=0) {
        loadingView.frame=self.tableView.bounds;
        [self.tableView addSubview:loadingView];
        [self startRequestSpeciesData];
        
    }
    
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
        return [self.species.topicContainer.elementArray count];
    }
    
    NSAssert(NO, @"Invlidate section");
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(TopicSection==indexPath.section)
    {
        return [self topicCell: tableView indexPath:indexPath];
    }
    
    if (SpeciesSection==indexPath.section) {
        return [self speciesSectionCell:tableView indexPath:indexPath];
    }
    
    NSAssert(NO, @"invalidate section ");
    return nil;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"相关话题";
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
    UIViewController*dstvc=(UIViewController*)[segue destinationViewController];
    
    if ([dstvc class]==[FullTextViewController class]) {
        FullTextViewController*ftvc=(FullTextViewController*)dstvc;
        ftvc.text=self.species.introduction;
        return;
    }
    if ([dstvc class]==[ImageTextViewController class]) {
        ImageTextViewController*itvc=(ImageTextViewController*)dstvc;
        itvc.species=self.species;
        return;
    }
    if ([dstvc class]==[TopicWebViewController class]) {
        NSIndexPath*indexPath=[self.tableView indexPathForSelectedRow];
        Topic*tp=[self.species.topicContainer.elementArray objectAtIndex:indexPath.row];
        TopicWebViewController*twvc=(TopicWebViewController*)dstvc;
        twvc.topic=tp;
        return;
    }
}


#pragma private messages

-(void)startRequestSpeciesData{

    NSAssert(self.species.urlString.length>0, @"Could download species data from nil url");
    NSURLSessionConfiguration*config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession*session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionTask*task=[session dataTaskWithURL:[NSURL URLWithString:self.species.urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (nil!=error) {
            [self displayFailedLoadingView];
            return ;
        }
        loadingView.hidden=YES;
        self.species=[Species fakeSpecies:1];
        [self.tableView reloadData];
        
    }];
    
    [task resume];
    
    
}
-(void)displayFailedLoadingView{
    loadingView.hidden=NO;
    loadingView.backgroundColor=[UIColor redColor];
}


-(UITableViewCell*)speciesSectionCell:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath{
    
    if (IntroductionRow==indexPath.row) {
        UITableViewCell*tcell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:IntroductionCellIdentifer];
        //tcell.headerLabel.text=@"简介";
        //tcell.headerLabel.backgroundColor=[UIColor yellowColor];
        //tcell.backgroundColor=[UIColor blueColor];
        tcell.detailTextLabel.text=self.species.introduction;
        //tcell.bodyLabel.backgroundColor=[UIColor greenColor];
        
        return tcell;
    }
    if (CookSkillRow==indexPath.row) {
        UITableViewCell*cookCell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CookCellIdentifer];        cookCell.detailTextLabel.text=self.species.cookText;
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
