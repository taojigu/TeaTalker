//
//  TextExpandCell.h
//  TeaTalker
//
//  Created by VooleDev6 on 14-9-18.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextExpandCell : UITableViewCell{
    
}

@property(nonatomic,strong)IBOutlet UILabel*fullTextLabel;

+(CGFloat)cellHeight:(NSString*)text font:(UIFont*)font selected:(BOOL)selected;
+(CGFloat)cellHeight:(NSString *)text  selected:(BOOL)selected;
@end
