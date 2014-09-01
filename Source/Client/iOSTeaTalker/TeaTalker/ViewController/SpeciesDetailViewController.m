//
//  SpeciesDetailViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-5-6.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "SpeciesDetailViewController.h"
#import "Species.h"
#import "ImageInfo.h"

#import "RequestUrlStringUtility.h"
#import "TopicContainerParser.h"
#import "CookSkillViewController.h"




#define CookSection 0
#define TopicSection 1

@interface SpeciesDetailViewController ()<NSURLSessionDelegate,UITableViewDelegate>{
    
    @private
    IBOutlet UIBarButtonItem* topicButton;
    
}

@property(nonatomic,strong)ElementsContainer*topicContainer;

-(IBAction)rightButtonClicked:(id)sender;
@end

@implementation SpeciesDetailViewController

@synthesize species;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        self.navigationItem.rightBarButtonItem.action=@selector(rightButtonClicked:);
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.hidesBottomBarWhenPushed=YES;
    //self.tabBarController.tabBar.hidden=YES;
    
    if (0==[self.species.urlString length]) {
        [self requestSpeciesData];
    }
    else{
        [self loadSpeciesData];
    }
    

    
    //[self addTapRecognizer];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    //self.navigationController.navigationBarHidden=NO;
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

#pragma mark -- UITableView DataSource and Delegate

-(UITableViewCell*)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellIdentifer";
    if (CookSection==indexPath.section) {
        CellIdentifier=@"CookCellIdentifer";
    }
   
    if (TopicSection==indexPath.section) {
        CellIdentifier=@"TopicCellIdentifer";
    }
    
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (CookSection==section) {
        return 1;
    }
    if (TopicSection==section) {
        return 9;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}




#pragma mark -- selector messages

-(void)viewTapped:(UIGestureRecognizer*)recg{
    
    CGPoint touchPoint=[recg locationInView:self.view];
    if (CGRectContainsPoint(tableView.frame, touchPoint)) {
        recg.cancelsTouchesInView=YES;
        
        return;
    }
    if (self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=NO;
    }
    else{
        self.navigationController.navigationBarHidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController*dstCntrl=[segue destinationViewController];
    if ([dstCntrl isKindOfClass:[CookSkillViewController class]]) {
        CookSkillViewController*ckvc=(CookSkillViewController*)dstCntrl;
        ckvc.cookImageInfoArray=self.species.cookImageInfoArray;
        ckvc.cookIntroduction=species.cookText;
        return;
    }
}


#pragma mark -- private messages

-(void)requestSpeciesData{
    NSAssert(0!=self.species.urlString.length, @"Species url should not be nil");
    NSURLSessionConfiguration*config=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession*session=[NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionTask*task=[session dataTaskWithURL:[NSURL URLWithString:self.species.urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (nil!=error) {
            NSLog(@"Faild to load Species Data ,Error:%@",[error localizedDescription]);
            return ;
        }
        [self processSpeciesData:data];
    }];
    [task resume];
}
-(void)processSpeciesData:(NSData*)data{
    
    self.species=[Species fakeSpecies:0];
    [self loadSpeciesData];

}
-(void)loadSpeciesData{
    introductionTextView.text=self.species.introduction;
    ImageInfo*iif=[self.species.imageInfoArray objectAtIndex:0];
    
    headerImageView.image=iif.image;
    
    [self requestTopicData:0];
}

-(void)addTapRecognizer{
    UITapGestureRecognizer*tapRecg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapRecg];
}
-(void)requestTopicData:(NSInteger)pageIndex{
    
    NSString*urlString=[RequestUrlStringUtility topicUrlString:self.species.speciesId pageIndex:pageIndex pageSize:12];
    
    NSURLSessionConfiguration*config=[NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession*session=[NSURLSession sessionWithConfiguration:config];
    NSURLSessionTask*task=[session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (nil!=error) {
             NSLog(@"topic request failed");
            return ;
        }
       
        TopicContainerParser*parser=[[TopicContainerParser alloc]init];
        ElementsContainer*topicPage=[parser parse:data];
        [self.topicContainer.elementArray addObjectsFromArray:topicPage.elementArray];
        return ;
    }];
    
    [task resume];
}
                           
                           
-(IBAction)rightButtonClicked:(id)sender{
    
}


@end
