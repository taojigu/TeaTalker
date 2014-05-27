//
//  SpeciesDetailViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-5-6.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "SpeciesDetailViewController.h"
#import "Species.h"


#define IntroductionSection 0
#define TopicSection 1

@interface SpeciesDetailViewController ()

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
    self.hidesBottomBarWhenPushed=YES;
    self.tabBarController.tabBar.hidden=YES;
    
    [self addTapRecognizer];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
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
    if (IntroductionSection==indexPath.section) {
        CellIdentifier=@"IntroductionCellIdentifer";
    }
   
    if (TopicSection==indexPath.section) {
        CellIdentifier=@"TopicCellIdentifer";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (IntroductionSection==section) {
        return 1;
    }
    if (TopicSection==section) {
        return 9;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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

@end
