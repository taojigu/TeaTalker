//
//  ImageInfoCollectionViewController.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-16.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ImageInfoCollectionViewController.h"
#import "ImageInfo.h"
#import "Species.h"
#import "ImageCollectionCell.h"

#define CookCellIdentifer @"CookImageCellIdentifer"

@interface ImageInfoCollectionViewController ()

@end

@implementation ImageInfoCollectionViewController

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
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hidesBottomBarWhenPushed=YES;
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

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.species.cookImageInfoArray count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageInfo*info=[self.species.cookImageInfoArray objectAtIndex:indexPath.row];
    ImageCollectionCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:CookCellIdentifer forIndexPath:indexPath];
    cell.imageView.image=info.image;
    
    return cell;
}

@end
