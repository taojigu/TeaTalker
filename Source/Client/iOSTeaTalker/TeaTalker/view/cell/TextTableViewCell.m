//
//  TextTableViewCell.m
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TextTableViewCell.h"

#define TopMargin 10
#define BottomMargin 10
#define LeftMargin 10
#define RightMargin 10
#define HeaderHeight 30

#define TextDistance 5

#define HeaderFontSize 16
#define HeaderFontName @"Helvetica Neue"
#define BodyFontName @"Helvetica Neue"
#define BodyFontSize 12

#define DefaultViewWidth 320

@implementation TextTableViewCell

@synthesize headerLabel;
@synthesize bodyLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initCustomViews];
           }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self initCustomViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    
    [self layoutCustomViews];

}
+(CGFloat)cellHeightForText:(NSString*)text {
    
    CGFloat height=TopMargin+BottomMargin+TextDistance+HeaderHeight;
    UIFont *font=[UIFont fontWithName:BodyFontName size:BodyFontSize];

   
    NSMutableDictionary*dict=[[NSMutableDictionary alloc]init];
    [dict setValue:font forKey:NSFontAttributeName];
    
    CGFloat width=DefaultViewWidth-LeftMargin-RightMargin;
    CGRect attriRect=[text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
     height+=attriRect.size.height;
    return height;
    //return 250;
}
-(void)initCustomViews{
    
    self.headerLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    self.headerLabel.font=[UIFont fontWithName:HeaderFontName size:HeaderFontSize];
    self.headerLabel.textColor=[UIColor redColor];
    [self.contentView addSubview:self.headerLabel];
    
    self.bodyLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    self.bodyLabel.font=[UIFont fontWithName:BodyFontName size:BodyFontSize];
    self.bodyLabel.numberOfLines=-1;
    self.bodyLabel.textColor=[UIColor blackColor];
    [self.contentView addSubview:self.bodyLabel];

}
-(void)layoutCustomViews{
    CGRect rect=CGRectMake(0, TopMargin, CGRectGetWidth(self.frame), HeaderHeight);
    rect=CGRectInset(rect, LeftMargin, 0);
    self.headerLabel.frame=rect;
    
    CGFloat bodyHeight=CGRectGetHeight(self.frame)-TopMargin-HeaderHeight-TextDistance-BottomMargin;
    CGFloat top=CGRectGetMaxY(rect)+TextDistance;
    rect=CGRectMake(0, top, CGRectGetWidth(self.frame), bodyHeight);
    rect=CGRectInset(rect, LeftMargin, 0);
    self.bodyLabel.frame=rect;
}
@end
