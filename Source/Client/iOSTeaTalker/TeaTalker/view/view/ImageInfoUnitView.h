//
//  ImageInfoUnitView.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-6-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageInfo;

@interface ImageInfoUnitView : UIView


@property(nonatomic,strong)UIFont*introductionFont;
@property(nonatomic,strong)ImageInfo*imageInfo;


+(CGFloat)expectedHeight:(ImageInfo*)imageInf introductionFont:(UIFont*)font width:(CGFloat)width;
@end
