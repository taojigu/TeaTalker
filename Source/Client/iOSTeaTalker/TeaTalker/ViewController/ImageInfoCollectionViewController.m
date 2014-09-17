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
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "UIImageView+MJWebCache.h"

#define CookCellIdentifer @"CookImageCellIdentifer"

@interface ImageInfoCollectionViewController (){
    @private
    NSMutableArray*photoArray;
    NSMutableArray*photoViewArray;
}

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
     
        [self initSelf];
    }
    return self;
}


-(void)initSelf{
    self.hidesBottomBarWhenPushed=YES;
    self.title=self.species.name;
    photoArray=[[NSMutableArray alloc]init];
    photoViewArray=[[NSMutableArray alloc]init];
    return;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self preparePhotoBuffer];

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
    __weak ImageCollectionCell*weakCell=cell;
    MJPhoto*photo=[photoArray objectAtIndex:indexPath.row];
    UIImage*defultImage=[UIImage imageNamed:DragonWellImageName];
    [cell.imageView setImageWithURL:[NSURL URLWithString:info.imageUrlString] placeholderImage:defultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            photo.srcImageView=weakCell.imageView;
        }];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self showPhotoBrowserAtIndex:indexPath.row];
    return;
}

#pragma private messages


-(void)showPhotoBrowserAtIndex:(NSInteger)photoIndex{
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = photoIndex; // 弹出相册时显示的第一张图片是？
    browser.photos = photoArray; // 设置所有的图片
    [browser show];
}
-(void)preparePhotoBuffer{
    NSInteger count=self.species.cookImageInfoArray.count;
    for (NSInteger index=0; index<count; index++) {
        ImageInfo*info=[self.species.cookImageInfoArray objectAtIndex:index];
        MJPhoto*photo=[[MJPhoto alloc]init];
        photo.text=info.introduction;
        photo.url=[NSURL URLWithString:info.imageUrlString];
        [photoArray addObject:photo];
        
    }
}
@end
