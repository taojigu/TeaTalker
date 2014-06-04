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
#import "AsiHttpRequest.h"
#import "RequestUrlStringUtility.h"
#import "TopicContainerParser.h"


#define CookSection 0
#define TopicSection 1

@interface SpeciesDetailViewController ()<ASIHTTPRequestDelegate>

@property(nonatomic,strong)ElementsContainer*topicContainer;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.hidesBottomBarWhenPushed=YES;
    //self.tabBarController.tabBar.hidden=YES;
    
    introductionTextView.text=self.species.introduction;
    ImageInfo*iif=[self.species.imageInfoArray objectAtIndex:0];
    
    headerImageView.image=iif.image;
    
    [self requestTopicData:0];
    
    [self addTapRecognizer];

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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellIdentifer";
    if (CookSection==indexPath.section) {
        CellIdentifier=@"CookCellIdentifer";
    }
   
    if (TopicSection==indexPath.section) {
        CellIdentifier=@"TopicCellIdentifer";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
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
    if (self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden=NO;
        self.tabBarController.tabBar.hidden=NO;
    }
    else{
        self.navigationController.navigationBarHidden=YES;
        self.tabBarController.tabBar.hidden=YES;
    }
}



#pragma mark -- private messages

-(void)addTapRecognizer{
    UITapGestureRecognizer*tapRecg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tapRecg];
}
-(void)requestTopicData:(NSInteger)pageIndex{
    NSString*urlString=[RequestUrlStringUtility topicUrlString:self.species.speciesId pageIndex:pageIndex pageSize:12];
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.delegate=self;
    [request startAsynchronous];
}

#pragma mark -- AsiHttpRequestDelegate messages

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSData*data=[request responseData];
    TopicContainerParser*parser=[[TopicContainerParser alloc]init];
    ElementsContainer*topicPage=[parser parse:data];
    [self.topicContainer.elementArray addObjectsFromArray:topicPage.elementArray];
    
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    NSLog(@"topic request failed");
}
@end
