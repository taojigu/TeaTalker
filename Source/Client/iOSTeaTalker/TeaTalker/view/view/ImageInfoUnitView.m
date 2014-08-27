//
//  ImageInfoUnitView.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-6-20.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "ImageInfoUnitView.h"
#import "ImageInfo.h"
@implementation ImageInfoUnitView

@synthesize imageInfo;
@synthesize introductionFont;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.introductionFont=[UIFont systemFontOfSize:15];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

+(CGFloat)expectedHeight:(ImageInfo*)imageInf introductionFont:(UIFont*)font width:(CGFloat)width{

    CGFloat height=imageInf.image.size.height;
    NSMutableDictionary*dict=[[NSMutableDictionary alloc]init];
    [dict setObject:font forKey:NSFontAttributeName];
    CGRect rect=[imageInf.introduction boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    height+=CGRectGetHeight(rect);
    return height;
}

@end
