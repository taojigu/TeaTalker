//
//  CookSkillViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-6-4.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "CookSkillViewController.h"
#import "Topic.h"
#import "ImageInfo.h"
#import "ImageInfoUnitView.h"

@interface CookSkillViewController ()

@end

@implementation CookSkillViewController

@synthesize cookImageInfoArray;
@synthesize cookIntroduction;

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
    [self conifugrePrivateViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma private messages
-(void)conifugrePrivateViews{
    CGFloat scrlViewHeight=[self cookContentHeight];
    CGFloat width=CGRectGetWidth(self.view.frame);
    scrollView.contentSize=CGSizeMake(width, scrlViewHeight);
    [self addImageInfoUnitViews];
}
-(CGFloat)cookContentHeight{
    CGFloat height=0;
    for (ImageInfo*info in self.cookImageInfoArray) {
        height+=[ImageInfoUnitView expectedHeight:info introductionFont:[UIFont systemFontOfSize:15] width:CGRectGetWidth(self.view.frame)];
    }
    return height;
}
-(void)addImageInfoUnitViews{
    CGFloat yPos=0;
    CGFloat width=CGRectGetWidth(scrollView.frame);
    for (ImageInfo*imf in self.cookImageInfoArray) {
        ImageInfoUnitView*iuv=[[ImageInfoUnitView alloc]initWithFrame:CGRectZero];
        iuv.imageInfo=imf;
        CGFloat height=[ImageInfoUnitView expectedHeight:imf introductionFont:[UIFont systemFontOfSize:15] width:CGRectGetWidth(self.view.frame)];
        CGRect frm=CGRectMake(0,yPos,width,height);
        iuv.frame=frm;
        [scrollView addSubview:iuv];
        yPos+=height;
        
    }
    
}

@end
