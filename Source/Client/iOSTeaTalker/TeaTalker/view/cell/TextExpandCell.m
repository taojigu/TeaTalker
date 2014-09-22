//
//  TextExpandCell.m
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-18.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import "TextExpandCell.h"

#define DefaultHeight 100
#define DefaultWidth 320


#define VerticalPadding 10
#define HorizentalPadding 5


#define TextLabelFontName @"Baskerville"
#define TextLabelFontSize 17



@implementation TextExpandCell

@synthesize fullTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    //self.translatesAutoresizingMaskIntoConstraints=YES;
    //self.fullTextLabel.autoresizingMask=UIViewAutoresizingFlexibleHeight;
    self.autoresizesSubviews=YES;

}



-(void)layoutSubviews{

    [super layoutSubviews];
    CGFloat top=VerticalPadding;
    CGFloat left=HorizentalPadding;
    CGFloat width=CGRectGetWidth(self.frame)-2*HorizentalPadding;
    CGFloat height=CGRectGetHeight(self.frame)-2*VerticalPadding;
    CGRect rect=CGRectMake(left, top, width, height);
    self.fullTextLabel.frame=rect;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];


    // Configure the view for the selected state
}

+(CGFloat)cellHeight:(NSString *)text  selected:(BOOL)selected{
    
    UIFont* font=[UIFont fontWithName:TextLabelFontName size:TextLabelFontSize];
    return [TextExpandCell cellHeight:text font:font selected:selected];
    
}
+(CGFloat)cellHeight:(NSString *)text  font:(UIFont*)font selected:(BOOL)selected{
    NSMutableDictionary*attriDict=[[NSMutableDictionary alloc]init];
    [attriDict setObject:font forKey:NSFontAttributeName];
    CGSize sz=CGSizeMake(DefaultWidth-2*HorizentalPadding, MAXFLOAT);
    
    CGRect rect=[text boundingRectWithSize:sz options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attriDict context:nil];
    
    CGFloat resultHeight=0;
    if (selected) {
        resultHeight=CGRectGetHeight(rect);
    }
    else{
        resultHeight=MIN(DefaultHeight, CGRectGetHeight(rect));
    }
    
    return resultHeight+2*VerticalPadding;
}

@end
