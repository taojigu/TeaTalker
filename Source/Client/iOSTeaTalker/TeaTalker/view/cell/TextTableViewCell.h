//
//  TextTableViewCell.h
//  TeaTalker
//
//  Created by user on 14-2-12.
//  Copyright (c) 2014年 voole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTableViewCell : UITableViewCell{
    
}

@property(nonatomic,strong)UILabel*headerLabel;
@property(nonatomic,strong)UILabel*bodyLabel;

+(CGFloat)cellHeightForText:(NSString*)text;

@end
